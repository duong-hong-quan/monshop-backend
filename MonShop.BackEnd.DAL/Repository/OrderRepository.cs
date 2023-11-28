﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using MonShop.BackEnd.DAL.Models;
using MonShop.BackEnd.DAL.DTO;
using MonShop.BackEnd.DAL.Repository.IRepository;
using MonShop.BackEnd.Utility.Utils;
using MonShop.BackEnd.DAL.Data;

namespace MonShop.BackEnd.DAL.Repository
{
    public class OrderRepository : IOrderRepository
    {
        private readonly MonShopContext _db;
        private readonly ICartRepository _cartRepository;

        public OrderRepository(MonShopContext db, ICartRepository cartRepository)
        {
            _db = db;
            _cartRepository = cartRepository;
        }

        public async Task<List<OrderStatus>> GetAllOrderStatus()
        {
            List<OrderStatus> list = await _db.OrderStatus.ToListAsync();
            return list;
        }
        public async Task AddOrderStatus(OrderStatusDTO dto)
        {
            OrderStatus status = new OrderStatus { OrderStatusId = dto.OrderStatusId, Status = dto.Status };
            await _db.OrderStatus.AddAsync(status);
            await _db.SaveChangesAsync();
        }
        public async Task UpdateOrderStatus(OrderStatusDTO dto)
        {
            OrderStatus status = new OrderStatus { OrderStatusId = dto.OrderStatusId, Status = dto.Status };
            _db.OrderStatus.Update(status);
            await _db.SaveChangesAsync();
        }

        public async Task<bool> IsOutStock(OrderRequest request)
        {
            Cart cart = await _db.Cart.FirstOrDefaultAsync(c => c.CartId == request.CartId);
            if (cart != null)
            {
                List<CartItem> cartItems = await _db.CartItem.Where(c => c.CartId == request.CartId).ToListAsync();
                foreach (CartItem cartItem in cartItems)
                {
                    ProductInventory productInventory = await _db.ProductInventory.Where(p => p.ProductId == cartItem.ProductId && p.SizeId == cartItem.SizeId).SingleOrDefaultAsync();
                    if (productInventory != null && productInventory.Quantity < cartItem.Quantity)
                    {

                        return true;
                    }
                }

            }
            return false;

        }

        public async Task<string> AddOrderRequest(OrderRequest orderRequest)
        {
            if (!await IsOutStock(orderRequest))
            {
                string orderID = null;
                Cart cart = await _db.Cart.FirstOrDefaultAsync(c => c.CartId == orderRequest.CartId);
                if (cart != null)
                {
                    double total = 0;
                    Order order = new Order
                    {
                        OrderId = Guid.NewGuid().ToString(),
                        OrderDate = Utility.Utils.Utility.GetInstance().GetCurrentDateTimeInTimeZone(),
                        Total = total,
                        OrderStatusId = Constant.Order.PENDING_PAY,
                        ApplicationUserId = cart.ApplicationUserId,
                        DeliveryAddressId = orderRequest.DeliveryAddressId
                    };
                    await _db.Order.AddAsync(order);
                    await _db.SaveChangesAsync();
                    orderID = order.OrderId;

                    IEnumerable<CartItem> items = await _cartRepository.GetItemsByCartId(orderRequest.CartId);
                    foreach (CartItem itemDTO in items)
                    {
                        ProductInventory productInventory = await _db.ProductInventory.FirstOrDefaultAsync(i => i.ProductId == itemDTO.ProductId && i.SizeId == itemDTO.SizeId);
                        Product product = await _db.Product.FirstOrDefaultAsync(i => i.ProductId == itemDTO.ProductId);
                        if (productInventory != null && product != null && productInventory.Quantity >= itemDTO.Quantity)
                        {

                            OrderItem item = new OrderItem
                            {
                                OrderId = orderID,
                                ProductId = (int)itemDTO.ProductId,
                                Quantity = itemDTO.Quantity,
                                PricePerUnit = product.Price,
                                Subtotal = (double)(itemDTO.Quantity * product.Price * (100 - product.Discount) / 100),
                                SizeId = itemDTO.SizeId
                            };
                            total += item.Subtotal;

                            await _db.OrderItem.AddAsync(item);
                        }

                    }
                    order.Total = total;
                    await _db.SaveChangesAsync();
                    await _cartRepository.RemoveCart(orderRequest.CartId);

                }

                return orderID;
            }
            return null;

        }

        public async Task UpdateStatusForOrder(string OrderID, int status)
        {
            Order order = await _db.Order.FirstAsync(o => o.OrderId == OrderID);

            order.OrderStatusId = status;

            await _db.SaveChangesAsync();
        }

        public async Task<Order> GetOrderByID(string OrderID)
        {
            Order order = await _db.Order.FirstAsync(o => o.OrderId == OrderID);
            return order;
        }
        public async Task<List<Order>> GetAllOrder()
        {
            List<Order> order = await _db.Order.Include(o => o.ApplicationUser).Include(o => o.OrderStatus).ToListAsync();
            return order;
        }
        public async Task<List<Order>> GetAllOrderByAccountID(string AccountID, int OrderStatusID)
        {
            List<Order> order = await _db.Order.Where(a => a.ApplicationUserId == AccountID && a.OrderStatusId == OrderStatusID).Include(o => o.OrderStatus).ToListAsync();
            return order;
        }
        public async Task<ListOrder> GetListItemByOrderID(string OrderID)
        {
            Order orderDTO = await _db.Order.Include(o => o.ApplicationUser).
                Include(o => o.OrderStatus).
                Where(o => o.OrderId == OrderID).
                FirstAsync();
            List<OrderItem> OrderItem = await _db.OrderItem.
                Include(o => o.Product).
                Where(o => o.OrderId == OrderID).
                ToListAsync();

            PaymentResponse paymentResponse = await _db.PaymentResponse.SingleOrDefaultAsync(p => p.OrderId == OrderID);
            PaymentType paymentMethod = null;
            if (paymentResponse != null)
            {
                paymentMethod = await _db.PaymentType.SingleOrDefaultAsync(p => p.PaymentTypeId == paymentResponse.PaymentTypeId);

            }

            ListOrder listOrder = new ListOrder { order = orderDTO, orderItem = OrderItem, paymentMethod = paymentMethod };
            return listOrder;
        }

        public async Task UpdateQuantityAfterPay(string OrderID)
        {
            List<OrderItem> list = await _db.OrderItem.Where(o => o.OrderId == OrderID).ToListAsync();
            foreach (OrderItem item in list)
            {
                int quantity = item.Quantity;
                ProductInventory product = await _db.ProductInventory.FirstAsync(i => i.ProductId == item.ProductId);
                if (product != null)
                {
                    product.Quantity = product.Quantity - quantity;
                }
            }
            await _db.SaveChangesAsync();
        }

        public async Task<OrderCount> OrderStatistic(string AccountID)
        {
            OrderCount order = new OrderCount
            {
                PendingCount = await OrderCountByStatus(AccountID, Constant.Order.PENDING_PAY),
                SuccessCount = await OrderCountByStatus(AccountID, Constant.Order.SUCCESS_PAY),
                FailCount = await OrderCountByStatus(AccountID, Constant.Order.FAILURE_PAY),
                ShipCount = await OrderCountByStatus(AccountID, Constant.Order.SHIPPED),
                DeliveredCount = await OrderCountByStatus(AccountID, Constant.Order.DELIVERED),
                CancelCount = await OrderCountByStatus(AccountID, Constant.Order.CANCELLED),



            };
            return order;
        }

        private async Task<int> OrderCountByStatus(string AccountID, int status)
        {
            int count = 0;
            count = await _db.Order.Where(o => o.ApplicationUserId == AccountID && o.OrderStatusId == status).CountAsync();
            return count;
        }

        public async Task<bool> VerifyOrder(string OrderID)
        {

            Order order = await _db.Order.FirstAsync(o => o.OrderId == OrderID);
            PaymentResponse payment = await _db.PaymentResponse.FirstOrDefaultAsync(p => p.OrderId == OrderID);
            if (order != null && order.OrderStatusId == Constant.Order.SUCCESS_PAY && payment.Success)
            {

                return true;
            }
            return false;
        }

        public async Task<List<Order>> GetAllOrderByAccountID(string AccountID)
        {
            return await _db.Order.Where(a => a.ApplicationUserId == AccountID).Include(a => a.OrderStatus).ToListAsync();

        }
    }
}
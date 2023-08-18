﻿using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using MonShopLibrary.DTO;
using MonShop.Library.Models;
using MonShopLibrary.Repository;
using Microsoft.AspNetCore.Authorization;

namespace MonShopAPI.Controller
{
    [Route("Order")]
    [ApiController]
    public class OrderController : ControllerBase
    {
        private readonly IOrderRepository _orderRepository;
        private readonly IProductRepository _productRepository;
        public OrderController()
        {
            _orderRepository = new OrderRepository();
            _productRepository = new ProductRepository();
        }

        [HttpGet]
        [Route("GetAllOrder")]
        public async Task<IActionResult> GetAllOrder()
        {
            var list = await _orderRepository.GetAllOrder();
            return Ok(list);
        }
        [HttpGet]
        [Route("GetListItemByOrderID")]
        public async Task<IActionResult> GetListItemByOrderID(string orderID)
        {
            var list = await _orderRepository.GetListItemByOrderID(orderID);
            return Ok(list);
        }

        [HttpGet]
        [Route("GetAllOrderStatus")]
        public async Task<IActionResult> GetAllOrderStatus()
        {
            var list = await _orderRepository.GetAllOrderStatus();
            return Ok(list);
        }
        [HttpPost]
        [Route("AddOrderStatus")]
        public async Task<IActionResult> AddOrderStatus(OrderStatusDTO dto)
        {
            await _orderRepository.AddOrderStatus(dto);
            return Ok(dto);

        }
        [HttpPut]
        [Route("UpdateOrderStatus")]
        public async Task<IActionResult> UpdateOrderStatus(OrderStatusDTO dto)
        {
            await _orderRepository.UpdateOrderStatus(dto);
            return Ok(dto);
        }
        [HttpPost]
        [Route("AddOrderRequest")]
        public async Task<IActionResult> AddOrderRequest(OrderRequest dto)
        {
            foreach (var item in dto.Items)
            {
                if (item.Quantity == 0)
                {
                    return BadRequest($"The quantity must greater than 0");
                }
                Product product = await _productRepository.GetProductByID(item.ProductId);
                if (product == null)
                {
                    return BadRequest($"No result Product with ID {item.ProductId}");
                }

            }

            string OrderID = await _orderRepository.AddOrderRequest(dto);
            return Ok(OrderID);
        }
        [HttpPut]
        [Route("UpdateStatusForOrder")]

        public async Task<IActionResult> UpdateStatusForOrder(string OrderID, int status)
        {
            Order order = await _orderRepository.GetOrderByID(OrderID);
            if(order == null)
            {
                return BadRequest();
            }
            if (order.OrderStatusId != MonShopLibrary.Utils.Constant.Order.PENDING_PAY ||
                  order.OrderStatusId != MonShopLibrary.Utils.Constant.Order.FAILURE_PAY ||
                  order.OrderStatusId != MonShopLibrary.Utils.Constant.Order.SUCCESS_PAY)
            {
                await _orderRepository.UpdateStatusForOrder(OrderID, status);
                return Ok();

            }
            return BadRequest("The system only accept when the order is payed success!");
        }

    //    [Authorize]
        [HttpGet]
        [Route("GetAllOrderByAccountID")]
        public async Task<IActionResult> GetAllOrderByAccountID(int AccountID, int OrderStatusID)
        {
            List<Order> list = await _orderRepository.GetAllOrderByAccountID(AccountID, OrderStatusID);
            return Ok(list);
        }


    }
}

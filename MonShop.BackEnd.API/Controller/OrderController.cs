﻿using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using System.Collections.Generic;
using Microsoft.AspNetCore.SignalR;
using MonShop.BackEnd.API.Model;
using MonShop.BackEnd.DAL.DTO;
using MonShop.BackEnd.DAL.Repository.IRepository;
using MonShop.BackEnd.Utility;
using MonShop.BackEnd.DAL.Models;

namespace MonShop.BackEnd.API.Controller
{
    [Route("Order")]
    [ApiController]
    [Authorize]
    public class OrderController : ControllerBase
    {
        private readonly IOrderRepository _orderRepository;
        private readonly IProductRepository _productRepository;
        private readonly IPaymentRepository _paymentRepository;
        private readonly ICartRepository _cartRepository;
        private readonly ResponseDTO _response;

        public OrderController
            (
            IOrderRepository orderRepository,
            IProductRepository productRepository,
            IPaymentRepository paymentRepository,
            ICartRepository cartRepository
            )
        {
            _orderRepository = orderRepository;
            _productRepository = productRepository;
            _paymentRepository = paymentRepository;
            _cartRepository = cartRepository;
            _response = new ResponseDTO();
        }

        [HttpGet]
        [Route("GetAllOrder")]
        public async Task<ResponseDTO> GetAllOrder()
        {
            try
            {
                var list = await _orderRepository.GetAllOrder();
                _response.Data = list;

            }
            catch (Exception ex)
            {
                _response.IsSuccess = false;
                _response.Message = ex.Message;
            }

            return _response;
        }
        [HttpGet]
        [Route("GetListItemByOrderID/{orderID}")]
        public async Task<ResponseDTO> GetListItemByOrderID(string orderID)
        {
            try
            {
                var list = await _orderRepository.GetListItemByOrderID(orderID);
                _response.Data = list;
            }
            catch (Exception ex)
            {
                _response.IsSuccess = false;
                _response.Message = ex.Message;
            }
            return _response;
        }

        [HttpGet]
        [Route("GetAllOrderStatus")]
        public async Task<ResponseDTO> GetAllOrderStatus()
        {
            try
            {

                var list = await _orderRepository.GetAllOrderStatus();
                _response.Data = list;

            }
            catch (Exception ex)
            {
                _response.IsSuccess = false;
                _response.Message = ex.Message;
            }
            return _response;
        }
        [HttpPost]
        [Route("AddOrderStatus")]
        public async Task<ResponseDTO> AddOrderStatus(OrderStatusDTO dto)
        {
            try
            {
                await _orderRepository.AddOrderStatus(dto);
                _response.Data = dto;

            }
            catch (Exception ex)
            {
                _response.IsSuccess = false;
                _response.Message = ex.Message;
            }
            return _response;

        }
        [HttpPut]
        [Route("UpdateOrderStatus")]
        public async Task<ResponseDTO> UpdateOrderStatus(OrderStatusDTO dto)
        {
            try
            {

                await _orderRepository.UpdateOrderStatus(dto);
                _response.Data = dto;

            }
            catch (Exception ex)
            {
                _response.IsSuccess = false;
                _response.Message = ex.Message;
            }
            return _response;
        }
        [HttpPost]
        [Route("AddOrderRequest")]
        public async Task<ResponseDTO> AddOrderRequest(OrderRequest orderRequest)
        {
            bool isError = false;

            try
            {
                IEnumerable<CartItem> items = await _cartRepository.GetItemsByCartId(orderRequest.CartId);
                foreach (var item in items)
                {
                    if (item.Quantity == 0)
                    {
                        _response.Message = $"The quantity must greater than 0";
                        isError = true;
                        _response.Data = null;
                        break;
                    }
                    Product product = await _productRepository.GetProductByID((int)item.ProductId);
                    if (product == null)
                    {
                        _response.Message = $"No result Product with ID {item.ProductId}";
                        isError = true;
                        _response.Data = null;

                        break;

                    }
                    ProductInventory productInventory = await _productRepository.GetProductInventory((int)item.ProductId, item.SizeId);

                    if (item.Quantity > productInventory?.Quantity)
                    {
                        _response.Message = "This product doesn't have enough quantity";
                        isError = true;
                        _response.Data = null;

                        break;

                    }

                }
                if (!isError)
                {
                    string OrderID = await _orderRepository.AddOrderRequest(orderRequest);
                    _response.Data = OrderID;
                }



            }
            catch (Exception ex)
            {
                _response.IsSuccess = false;
                _response.Message = ex.Message;
            }


            return _response;
        }
        [HttpPut]
        [Route("UpdateStatusForOrder")]

        public async Task<ResponseDTO> UpdateStatusForOrder(string OrderID, int status)
        {
            try
            {
                if (status == Utility.Utils.Constant.Order.FAILURE_PAY ||
                    status == Utility.Utils.Constant.Order.PENDING_PAY ||
                    status == Utility.Utils.Constant.Order.FAILURE_PAY ||
                    status == Utility.Utils.Constant.Order.SUCCESS_PAY)
                {
                    _response.Message = "The system only accept when the order is payed success!";
                }
                else
                {

                    await _orderRepository.UpdateStatusForOrder(OrderID, status);
                    _response.Message = "Update successful";

                }


            }
            catch (Exception ex)
            {
                _response.IsSuccess = false;
                _response.Message = ex.Message;
            }
            return _response;




        }

        //    [Authorize]
        [HttpGet]
        [Route("GetAllOrderByAccountID/{AccountID}/{OrderStatusID}")]
        public async Task<ResponseDTO> GetAllOrderByAccountID(string AccountID, int OrderStatusID)
        {
            try
            {

                List<Order> list = await _orderRepository.GetAllOrderByAccountID(AccountID, OrderStatusID);

                _response.Data = list;
            }
            catch (Exception ex)
            {
                _response.IsSuccess = false;
                _response.Message = ex.Message;
            }
            return _response;
        }

        [HttpGet]
        [Route("GetAllOrderByAccountID/{AccountID}")]
        public async Task<ResponseDTO> GetAllOrderByAccountID(string AccountID)
        {
            try
            {

                List<Order> list = await _orderRepository.GetAllOrderByAccountID(AccountID);

                _response.Data = list;
            }
            catch (Exception ex)
            {
                _response.IsSuccess = false;
                _response.Message = ex.Message;
            }
            return _response;
        }
        [HttpGet]
        [Route("GetOrderStatistic/{AccountID}")]
        public async Task<ResponseDTO> GetOrderStatistic(string AccountID)
        {
            try
            {
                OrderCount order = await _orderRepository.OrderStatistic(AccountID);
                _response.Data = order;


            }
            catch (Exception ex)
            {
                _response.IsSuccess = false;
                _response.Message = ex.Message;
            }
            return _response;
        }

        [HttpGet]
        [Route("VerifyOrder/{OrderID}")]
        public async Task<ResponseDTO> VerifyOrder(string OrderID)
        {
            try
            {

                bool res = await _orderRepository.VerifyOrder(OrderID);
                if (res)
                {
                    _response.Data = true;
                    _response.Message = "Payed successfully";
                }
                else
                {
                    _response.Data = false;
                    _response.Message = "Payed failed";

                }

            }
            catch (Exception ex)
            {

                _response.IsSuccess = false;
                _response.Message = ex.Message;
            }

            return _response;
        }
    }
}
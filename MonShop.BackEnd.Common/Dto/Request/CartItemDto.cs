﻿namespace MonShop.BackEnd.Common.Dto.Request;

public class CartItemDto
{
    public int ProductId { get; set; }
    public int Quantity { get; set; }
    public int SizeId { get; set; }
}
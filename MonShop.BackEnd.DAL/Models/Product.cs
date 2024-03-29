﻿using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MonShop.BackEnd.DAL.Models;

public class Product
{
    [Key] public int ProductId { get; set; }

    public string ProductName { get; set; } = null!;
    public string? ImageUrl { get; set; }
    public double Price { get; set; }
    public double? Discount { get; set; }
    public string? Description { get; set; }
    public int? CategoryId { get; set; }

    [ForeignKey("CategoryId")] public Category? Category { get; set; }

    public int? ProductStatusId { get; set; }

    [ForeignKey("ProductStatusId")] public ProductStatus? ProductStatus { get; set; }

    public bool? IsDeleted { get; set; }
}
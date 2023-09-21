﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MonShop.Library.Models
{
    public class CartItem
    {
        [Key]
        public int CartItemId { get; set; }
        public int? ProductId { get; set; }
        [ForeignKey("ProductId")]
        public Product? Product { get; set; }
        public int Quantity { get; set; }   

        public int CartId { get; set; }
        [ForeignKey("CartId")]
        public Cart Cart {  get; set; } 
    }
}

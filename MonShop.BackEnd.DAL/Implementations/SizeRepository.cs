﻿using MonShop.BackEnd.DAL.Contracts;
using MonShop.BackEnd.DAL.Data;
using MonShop.BackEnd.DAL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MonShop.BackEnd.DAL.Implementations
{
    public class SizeRepository : Repository<Size>, ISizeRepository
    {
        public SizeRepository(MonShopContext context) : base(context)
        {
        }
    }
}

﻿using Microsoft.EntityFrameworkCore;
using MonShopLibrary.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MonShopLibrary.DAO
{
    public class PaymentDBContext : MonShopContext
    {
        public PaymentDBContext() { }

        public async Task AddPaymentMomo(MomoPaymentResponse momo)
        {
            await this.MomoPaymentResponses.AddAsync(momo);
            await this.SaveChangesAsync();
        }
        public async Task<List<MomoPaymentResponse>> GetAllPaymentMomo()
        {
            List<MomoPaymentResponse> list = await this.MomoPaymentResponses.ToListAsync();
            return list;
        }

    }
}

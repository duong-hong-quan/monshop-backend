﻿using MonShop.Library.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using MonShop.Library.Repository.IRepository;
using MonShop.Library.Data;

namespace MonShopLibrary.Repository
{
    public class PaymentRepository : IPaymentRepository
    {
        private readonly MonShopContext _db;

        public PaymentRepository(MonShopContext db)
        {
            _db = db;
        }

        public async Task AddPaymentRespone(PaymentResponse payment)
        {
           await _db.PaymentResponse.AddAsync(payment);
           await _db.SaveChangesAsync();

        }

        public async Task<IEnumerable<PaymentResponse>> GetAllPayment()
        {
            var list = await _db.PaymentResponse.Include(p => p.Order).Include(p => p.PaymentType).ToListAsync();
            return list;
        }

        public async Task<IEnumerable<PaymentResponse>> GetAllPaymentById(string paymentId)
        {
            var list = await _db.PaymentResponse.Include(p => p.Order).Include(p => p.PaymentType).Where(p=> p.PaymentResponseId == paymentId).ToListAsync();
            return list;
        }

        public async Task<IEnumerable<PaymentResponse>> GetPaymentByAccountId(int accountId)
        {
            var list = await _db.PaymentResponse.Include(p => p.Order).Include(p => p.PaymentType).Where(p=> p.Order.BuyerAccountId == accountId).ToListAsync();
            return list;
        }
    }
}

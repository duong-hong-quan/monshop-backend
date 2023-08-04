﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PaymentGateway.Momo
{
    public interface IMomoServices
    {
        public  string SendPaymentRequest(string endpoint, string postJsonString);
        public string CreatePaymentString(Momo momo);

    }
}
﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MonShopLibrary.DTO
{
    public class LoginResponse
    {
        public string Token { get; set; }
        public string RefreshToken { get; set; }

    }
}
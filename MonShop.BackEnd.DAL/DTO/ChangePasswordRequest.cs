﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MonShop.BackEnd.DAL.DTO
{
    public class ChangePasswordRequest
    {
        public string ApplicationUserId { get; set; }
        public string OldPassword { get; set; }
        public string NewPassword { get; set; }
    }
}
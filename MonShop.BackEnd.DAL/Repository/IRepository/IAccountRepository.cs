﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using MonShop.BackEnd.DAL.DTO;
using MonShop.BackEnd.DAL.Models;

namespace MonShop.BackEnd.DAL.Repository.IRepository
{
    public interface IAccountRepository
    {
        public Task<TokenModel> Login(LoginRequest loginRequest);
        public Task<ApplicationUser> SignUp(SignUpRequest dto);
        public Task UpdateAccount(ApplicationUser user);
        public Task DeleteAccount(ApplicationUser user);
        public Task<ApplicationUser> GetAccountById(string accountId);
        public Task<IEnumerable<ApplicationUser>> GetAllAccount();
        public Task AssignRole(string userId, string roleName);
        public Task<IEnumerable<IdentityRole>> GetAllRole();
        public Task AddRole(string role);
        public Task UpdateRole(IdentityRole roleDto);
        public Task DeleteRole(IdentityRole roleDto);
        public Task<IdentityRole<string>> GetRoleForUserId(string userId);


        public Task AddAddress(DeliveryAddressDTO addressDto);
        public Task UpdateAddress(DeliveryAddressDTO addressDto);

        public Task RemoveAddress(DeliveryAddressDTO addressDto);
        public Task<List<DeliveryAddress>> GetAllAddressByUserId(string userId);



    }
}
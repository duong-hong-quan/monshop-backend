﻿using MonShopLibrary.DTO;
using MonShopLibrary.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MonShopLibrary.Repository
{
    public interface IAccountRepository
    {
        public Task<Account> Login(LoginRequest loginRequest);
        public Task<List<Account>> GetAllAccount();

        public  Task AddAccount(AccountDTO dto);


        public Task UpdateAccount(AccountDTO dto);

        public Task DeleteAccount(AccountDTO dto);
        public  Task<List<Role>> GetAllRole();

        public Task<Account> GetAccountByID(int id);
        public  Task<string> GenerateRefreshToken(int AccountID);
        public  Task<Token> GetToken(string token);
    }
}
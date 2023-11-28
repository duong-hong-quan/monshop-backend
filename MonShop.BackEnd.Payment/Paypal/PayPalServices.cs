﻿using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using System.Net;
using PayPal.Core;
using PayPal.v1.Payments;
namespace MonShop.BackEnd.Payment.Paypal
{
    public class PayPalServices : IPayPalServices
    {
        private const double ExchangeRate = 22_863.0;

        public PayPalServices()
        {
        }

        public static double ConvertVndToDollar(double vnd)
        {
            var total = Math.Round(vnd / ExchangeRate, 2);

            return total;
        }

        public async Task<string> CreatePaymentUrl(PaymentInformationModel model, HttpContext context)
        {
            // var envProd = new LiveEnvironment(_configuration["PaypalProduction:ClientId"],
            //     _configuration["PaypalProduction:SecretKey"]);
            IConfiguration config = new ConfigurationBuilder()
              .SetBasePath(Directory.GetCurrentDirectory())
              .AddJsonFile("appsettings.json", true, true)
              .Build();
            var envSandbox = new SandboxEnvironment(config["Paypal:ClientId"], config["Paypal:SecretKey"]);
            var client = new PayPalHttpClient(envSandbox);
            var paypalOrderId = model.OrderID;
            var urlCallBack = config["Paypal:RedirectUrl"];
            string price = ConvertVndToDollar(model.Amount).ToString();

            var payment = new PayPal.v1.Payments.Payment()
            {
                Intent = "sale",
                Transactions = new List<Transaction>()
                {
                    new Transaction()
                    {
                        Amount = new Amount()
                        {
                            Total = price,
                            Currency = "USD"

                        },

                        Description = $"Customer pays bill #{model.OrderID}",
                        InvoiceNumber = paypalOrderId.ToString()
                    }
                },
                RedirectUrls = new RedirectUrls()
                {
                    ReturnUrl = $"{urlCallBack}/{model.OrderID}",
                    CancelUrl = $"{urlCallBack}/{model.OrderID}"
                },
                Payer = new Payer()
                {
                    PaymentMethod = "paypal"
                }
            };

            var request = new PaymentCreateRequest();
            request.RequestBody(payment);

            var paymentUrl = "";
            var response = await client.Execute(request);
            var statusCode = response.StatusCode;

            if (statusCode is not (HttpStatusCode.Accepted or HttpStatusCode.OK or HttpStatusCode.Created))
                return paymentUrl;

            var result = response.Result<PayPal.v1.Payments.Payment>();
            using var links = result.Links.GetEnumerator();

            while (links.MoveNext())
            {
                var lnk = links.Current;
                if (lnk == null) continue;
                if (!lnk.Rel.ToLower().Trim().Equals("approval_url")) continue;
                paymentUrl = lnk.Href;
            }

            return paymentUrl;

        }
        /*
        public PaymentResponePayPal PaymentExecute(IQueryCollection collections)
        {
            var response = new PaymentResponePayPal();

            foreach (var (key, value) in collections)
            {
                if (!string.IsNullOrEmpty(key) && key.ToLower().Equals("order_description"))
                {
                    response.OrderDescription = value;
                }

                if (!string.IsNullOrEmpty(key) && key.ToLower().Equals("transaction_id"))
                {
                    response.TransactionId = value;
                }

                if (!string.IsNullOrEmpty(key) && key.ToLower().Equals("order_id"))
                {
                    response.OrderId = value;
                }

                if (!string.IsNullOrEmpty(key) && key.ToLower().Equals("payment_method"))
                {
                    response.PaymentMethod = value;
                }

                if (!string.IsNullOrEmpty(key) && key.ToLower().Equals("success"))
                {
                    response.Success = Convert.ToInt32(value) > 0;
                }

                if (!string.IsNullOrEmpty(key) && key.ToLower().Equals("paymentid"))
                {
                    response.PaymentId = value;
                }

                if (!string.IsNullOrEmpty(key) && key.ToLower().Equals("payerid"))
                {
                    response.PayerId = value;
                }
                if (!string.IsNullOrEmpty(key) && key.ToLower().Equals("amount"))
                {
                    response.Amount = value;
                }
            }

            return response;
        }
        */
    }

}

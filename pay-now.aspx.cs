using ClosedXML.Excel;
using Razorpay.Api;
using System;
using System.Activities.Expressions;
using System.Activities.Statements;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Query.Dynamic;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class pay_now : System.Web.UI.Page
{
    SqlConnection conMN = new SqlConnection(ConfigurationManager.ConnectionStrings["conMN"].ConnectionString);
    public string strCategories, strContact, strEmail, strUserName, strCountry, strSchool, strAmount = "";
    public string strScrollText = "", strMobLogin = "", strDeskLogin = "", strDeskText = "", strOrders = "", strDeskNavCategory = "", strMobNavCategories = "", strDelivery = "", strBilling = "", strSubTotal = "", strShipping = "", strDiscount = "", strCoupnDiscount = "", strTax = "", strTotal = "", buyerAmount = "", orderIdd = "", buyerName = "", BuyerMobile = "", buyerEmail = "", paybleAmount = "", strRazorId = "", strRazorSecret = "";
    public string strKey = "", strTRid = "", strPInfo = "", strFName = "", strLname = "", strSUrl = "", strFUrl = "", strPhone = "", strHash = "";


    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["order"] == null)
        {
            Response.Redirect("/");
        }
        try
        {
            double cost = 0;
            string cart = string.Empty;
            var ord = Reports.GetSingleOrderDetails(conMN, Request.QueryString["order"]).FirstOrDefault();
            if (ord != null)
            {
                strTotal = Convert.ToDecimal(ord.TotalPrice).ToString("C", CultureInfo.CreateSpecificCulture("en-IN"));

                buyerEmail = ord.EmailId;
                buyerName = ord.UserName;
                BuyerMobile = ord.Contact;
                cost = Convert.ToDouble(ord.TotalPrice);
                paybleAmount = cost.ToString(); ;
                buyerAmount = (cost * 100).ToString();
                var salt = ConfigurationManager.AppSettings["SALTKey"];

                strKey = ConfigurationManager.AppSettings["KeyID"];

                var domain = ConfigurationManager.AppSettings["domain"];
                var details = new PayUAPIRequest()
                {
                    Address1 = "",
                    Address2 = "",
                    Amount = Convert.ToDouble(cost),
                    City = "",
                    State = "",
                    Country = "",
                    Email = ord.EmailId,
                    FirstName = ord.UserName,
                    LastName = "",
                    Furl = domain + "payment-failed.aspx?O=" + ord.OrderId,
                    Surl = domain + "payment-success.aspx?O=" + ord.OrderId,
                    Phone = ord.Contact,
                    ProductInfo = "New Membership",
                    Txnid = ord.OrderGuid,
                    Zipcode = "",
                    Key = strKey
                };
                strTRid = details.Txnid;
                strPInfo = details.ProductInfo;
                strAmount = details.Amount.ToString();
                strEmail = details.Email;
                strFName = details.FirstName;
                strSUrl = details.Surl;
                strFUrl = details.Furl;
                strPhone = details.Phone;
                strHash = GenerateHash(details, salt);
                //var exe = PayUAPI.CreatePayment(details);
                //if (exe != null)
                //{

                //}
                //buyerAmount = "450";
                //Session["payble"] = buyerAmount;
                //Dictionary<string, object> input = new Dictionary<string, object>();
                //input.Add("amount", buyerAmount); // this amount should be same as transaction amount
                //input.Add("currency", "INR");
                //input.Add("receipt", orderid);
                //input.Add("payment_capture", 1);
                //RazorpayClient client = new RazorpayClient(ConfigurationManager.AppSettings["razorid"], ConfigurationManager.AppSettings["razorsecret"]);
                //ServicePointManager.Expect100Continue = true;
                //ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
                //Razorpay.Api.Order order = client.Order.Create(input);
                //orderIdd = order["id"].ToString();
            }

        }
        catch (Exception ex)
        {

        }

        //CreateOrder();
        //getMemberdetails();
    }

    //private void bindValues()
    //{
    //    if (Request.QueryString["order"] == null)
    //    {
    //        Response.Redirect("/");
    //    }
    //    try
    //    {
    //        // double cost = 0;
    //        string orderid = Convert.ToString(Request.QueryString["order"]);
    //        Session["orderid"] = orderid;
    //        string cart = string.Empty;
    //        var ord = Reports.GetSingleOrderDetails(conMN, Request.QueryString["order"]).FirstOrDefault();
    //        if (ord != null)
    //        {
    //            // strBilling = ord.BillingAddress;
    //            //strDelivery = ord.DeliveryAddress;
    //            // cost = Convert.ToDouble(ord.TotalPrice);
    //            //strSubTotal = ord.SubTotal == "0" || ord.SubTotal == "" || ord.SubTotal == null ? "₹ 0" : Convert.ToDecimal(ord.SubTotal).ToString("C", CultureInfo.CreateSpecificCulture("en-IN"));
    //            // strShipping = ord.ShippingPrice == "0" || ord.ShippingPrice == "" || ord.ShippingPrice == null ? "₹ 0" : Convert.ToDecimal(ord.ShippingPrice).ToString("C", CultureInfo.CreateSpecificCulture("en-IN"));
    //            // strDiscount = ord.Discount == "0" || ord.Discount == "" || ord.Discount == null ? "₹ 0" : Convert.ToDecimal(ord.Discount).ToString("C", CultureInfo.CreateSpecificCulture("en-IN"));
    //            //strCoupnDiscount = ord.Discount == "0" || ord.Discount == "" || ord.Discount == null ? "₹ 0" : Convert.ToDecimal(ord.Discount).ToString("C", CultureInfo.CreateSpecificCulture("en-IN"));
    //            //strTax = Convert.ToDecimal(ord.Tax).ToString("C", CultureInfo.CreateSpecificCulture("en-IN"));
    //            strTotal = Convert.ToDecimal(450).ToString("C", CultureInfo.CreateSpecificCulture("en-IN"));

    //            // divDiscount.Visible = false;
    //            buyerEmail = ord.EmailId;
    //            buyerName = ord.UserName;
    //            BuyerMobile = ord.Contact;

    //            buyerAmount = "450";

    //            Session["payble"] = buyerAmount;

    //            Dictionary<string, object> input = new Dictionary<string, object>();
    //            input.Add("amount", buyerAmount); // this amount should be same as transaction amount
    //            input.Add("currency", "INR");
    //            input.Add("receipt", orderid);
    //            input.Add("payment_capture", 1);
    //            RazorpayClient client = new RazorpayClient(strRazorId, strRazorSecret);
    //            ServicePointManager.Expect100Continue = true;
    //            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
    //            Razorpay.Api.Order order = client.Order.Create(input);
    //            orderIdd = order["id"].ToString();
    //        }
    //    }
    //    catch (Exception ex)
    //    {

    //    }
    //}

    protected void CreateOrder()
    {

    }
    public void CreateVisitedUser()
    {
        if (HttpContext.Current.Request.Cookies["med_cust"] == null)
        {
            HttpCookie cookie = new HttpCookie("med_cust");
            cookie.Value = Guid.NewGuid().ToString();
            cookie.Expires = TimeStamps.UTCTime().AddDays(30);
            Response.Cookies.Add(cookie);
        }
    }

    //protected void btn_pay_now_Click(object sender, EventArgs e)
    //{
    //    if (Request.QueryString["order"] == null)
    //    {
    //        Response.Redirect("/");
    //    }
    //    try
    //    {
    //        double cost = 450;
    //        string orderid = Convert.ToString(Request.QueryString["order"]);
    //        Session["orderid"] = orderid;
    //        string cart = string.Empty;
    //        var ord = Reports.GetSingleOrderDetails(conMN, Request.QueryString["order"]).FirstOrDefault();
    //        if (ord != null)
    //        {
    //            // strBilling = ord.BillingAddress;
    //            // strDelivery = ord.DeliveryAddress;
    //            //strSubTotal = ord.SubTotal == "0" || ord.SubTotal == "" || ord.SubTotal == null ? "₹ 0" : Convert.ToDecimal(ord.SubTotal).ToString("C", CultureInfo.CreateSpecificCulture("en-IN"));
    //            //strShipping = ord.ShippingPrice == "0" || ord.ShippingPrice == "" || ord.ShippingPrice == null ? "₹ 0" : Convert.ToDecimal(ord.ShippingPrice).ToString("C", CultureInfo.CreateSpecificCulture("en-IN"));
    //            //strDiscount = ord.Discount == "0" || ord.Discount == "" || ord.Discount == null ? "₹ 0" : Convert.ToDecimal(ord.Discount).ToString("C", CultureInfo.CreateSpecificCulture("en-IN"));
    //            //strCoupnDiscount = ord.Discount == "0" || ord.Discount == "" || ord.Discount == null ? "₹ 0" : Convert.ToDecimal(ord.Discount).ToString("C", CultureInfo.CreateSpecificCulture("en-IN"));
    //            //strTax = Convert.ToDecimal(ord.Tax).ToString("C", CultureInfo.CreateSpecificCulture("en-IN"));
    //            strTotal = Convert.ToDecimal(450).ToString("C", CultureInfo.CreateSpecificCulture("en-IN"));

    //            //divDiscount.Visible = false;
    //            buyerEmail = ord.EmailId;
    //            buyerName = ord.UserName;
    //            BuyerMobile = ord.Contact;

    //            cost = Convert.ToDouble(ord.TotalPrice);
    //            paybleAmount = cost.ToString(); ;
    //            buyerAmount = (cost * 100).ToString();

    //            Session["payble"] = buyerAmount;

    //            Dictionary<string, object> input = new Dictionary<string, object>();
    //            input.Add("amount", buyerAmount); // this amount should be same as transaction amount
    //            input.Add("currency", "INR");
    //            input.Add("receipt", orderid);
    //            input.Add("payment_capture", 1);
    //            RazorpayClient client = new RazorpayClient(ConfigurationManager.AppSettings["razorid"], ConfigurationManager.AppSettings["razorsecret"]);
    //            ServicePointManager.Expect100Continue = true;
    //            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
    //            Razorpay.Api.Order order = client.Order.Create(input);
    //            orderIdd = order["id"].ToString();

    //        }
    //    }
    //    catch (Exception ex)
    //    {

    //    }
    //}

    protected void btn_pay_now_Click(object sender, EventArgs e)
    {
        CreateOrder();
    }

    public static string GenerateHash(PayUAPIRequest details, string salt)
    {
        //string input = "{key}|{txnid}|{amount}|{productinfo}|{firstname}|{email}|||||||||||{salt}";
        var hashString = details.Key + "|" + details.Txnid + "|" + details.Amount + "|" +
                         details.ProductInfo + "|" + details.FirstName + "|" + details.Email +
                         "|||||||||||" + salt;
        return Sha512(hashString);
    }

    private static string Sha512(string input)
    {
        using (SHA512 sha512 = SHA512.Create())
        {
            byte[] bytes = sha512.ComputeHash(Encoding.UTF8.GetBytes(input));
            StringBuilder sb = new StringBuilder();
            foreach (byte b in bytes)
            {
                sb.Append(b.ToString("x2"));
            }
            return sb.ToString();
        }
    }

}
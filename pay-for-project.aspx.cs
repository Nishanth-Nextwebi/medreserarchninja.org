using ClosedXML.Excel;
using DocumentFormat.OpenXml.Presentation;
using Razorpay.Api;
using System;
using System.Activities.Expressions;
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

public partial class pay_for_project : System.Web.UI.Page
{
    SqlConnection conMN = new SqlConnection(ConfigurationManager.ConnectionStrings["conMN"].ConnectionString);
    public string strCategories, strContact, strEmail, strUserName, ProjectCode, Projectname = "";
    public string strScrollText = "", strMobLogin = "", strDeskLogin = "", strDeskText = "", strOrders = "", strDeskNavCategory = "", strMobNavCategories = "", strDelivery = "", strBilling = "", strSubTotal = "", strShipping = "", strDiscount = "", strCoupnDiscount = "", strTax = "", strTotal = "", buyerAmount = "", orderIdd = "", buyerName = "", BuyerMobile = "", buyerEmail = "", paybleAmount = "", strRazorId = "", strRazorSecret = "";
    public string strKey = "", strTRid = "", strPInfo = "", strFName = "", strAmount = "", strLname = "", strSUrl = "", strFUrl = "", strPhone = "", strHash = "";

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request.QueryString["order"] == null)
        {
            Response.Redirect("/");
        }
        try
        {
            double cost = 0; // 450;
                             //string orderid = Convert.ToString(Request.QueryString["order"]);
                             // Session["orderid"] = orderid;
            string cart = string.Empty;
            var ord = PReports.GetSingleOrderDetails(conMN, Request.QueryString["order"]).FirstOrDefault();
            if (ord != null)
            {
                strTotal = Convert.ToDecimal(ord.TotalPrice).ToString("C", CultureInfo.CreateSpecificCulture("en-IN"));


                //divDiscount.Visible = false;
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
                    Furl = domain + "project-payment-failed.aspx?O=" + ord.OrderId,
                    Surl = domain + "project-payment-success.aspx?O=" + ord.OrderId,
                    Phone = ord.Contact,
                    ProductInfo = ord.ProjectName,
                    Txnid = ord.OrderGuid,
                    Zipcode = "",
                    Key = strKey
                };
                strTRid = details.Txnid;
                ProjectCode = ord.ProjectID;
                Projectname = ord.ProjectName;
                strPInfo = details.ProductInfo;
                strAmount = details.Amount.ToString();
                strEmail = details.Email;
                strFName = details.FirstName;
                //strLname = "";
                strSUrl = details.Surl;
                strFUrl = details.Furl;
                strPhone = details.Phone;
                strHash = GenerateHash(details, salt);
            }

        }
        catch (Exception ex)
        {
            ExceptionCapture.CaptureException(HttpContext.Current.Request.Url.PathAndQuery, "Pay_for_Payment", ex.Message);
        }
        // GetPaymentKeys();
        //CreateOrder();
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
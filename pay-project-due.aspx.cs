using System;
using System.Activities.Expressions;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class pay_project_due : System.Web.UI.Page
{
    SqlConnection conMN = new SqlConnection(ConfigurationManager.ConnectionStrings["conMN"].ConnectionString);
    public string ProjectCode = "", Projectname = "", buyerName = "", buyerEmail = "", BuyerMobile = "", paybleAmount = "", buyerAmount = "", strTotal = "";
    public string strKey = "", strTRid = "", strPInfo = "", strAmount = "", strEmail = "", strFName = "", strSUrl = "", strFUrl = "", strPhone = "", strHash = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Request.QueryString["pid"]))
        {
            Response.Redirect("/");
        }
        else
        {
            BindPaymentDetails();
        }
    }

    private void BindPaymentDetails()
    {
        try
        {
            double cost = 0;
            string cart = "";
            var p_Details = Projects.GetPaymentDetailsBy_PaymentGuid(conMN, Request.QueryString["pid"]);
            if (p_Details.Rows.Count > 0)
            {
                strTotal = Convert.ToDecimal(Convert.ToString(p_Details.Rows[0]["Amount"])).ToString("C", CultureInfo.CreateSpecificCulture("en-IN"));
                buyerEmail = Convert.ToString(p_Details.Rows[0]["EmailId"]);
                buyerName = Convert.ToString(p_Details.Rows[0]["FullName"]);
                BuyerMobile = Convert.ToString(p_Details.Rows[0]["Contact"]);
                cost = Convert.ToDouble(Convert.ToString(p_Details.Rows[0]["Amount"]));
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
                    Email = Convert.ToString(p_Details.Rows[0]["EmailId"]),
                    FirstName = Convert.ToString(p_Details.Rows[0]["FullName"]),
                    LastName = "",
                    Furl = domain + "project-due-status.aspx?p=" + Convert.ToString(p_Details.Rows[0]["PaymentGuid"]),
                    Surl = domain + "project-due-status.aspx?p=" + Convert.ToString(p_Details.Rows[0]["PaymentGuid"]),
                    Phone = Convert.ToString(p_Details.Rows[0]["Contact"]),
                    ProductInfo = Convert.ToString(p_Details.Rows[0]["ProjectName"]),
                    Txnid = Convert.ToString(p_Details.Rows[0]["PaymentGuid"]),
                    Zipcode = "",
                    Key = strKey
                };

                strTRid = details.Txnid;
                ProjectCode = Convert.ToString(p_Details.Rows[0]["ProjectId"]);
                Projectname = Convert.ToString(p_Details.Rows[0]["ProjectName"]);
                strPInfo = details.ProductInfo;
                strAmount = details.Amount.ToString();
                strEmail = details.Email;
                strFName = details.FirstName;
                strSUrl = details.Surl;
                strFUrl = details.Furl;
                strPhone = details.Phone;
                strHash = GenerateHash(details, salt);
            }
        }
        catch (Exception ex)
        {
            ExceptionCapture.CaptureException(HttpContext.Current.Request.Url.PathAndQuery, "BindPaymentDetails", ex.Message);
        }
    }

    public static string GenerateHash(PayUAPIRequest details, string salt)
    {
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
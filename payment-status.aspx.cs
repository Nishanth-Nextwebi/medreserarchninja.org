using Razorpay.Api;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Collections.Specialized;
using System.Security.Cryptography;
using System.Net.Mail;

public partial class payment_status : System.Web.UI.Page
{
    SqlConnection conMN = new SqlConnection(ConfigurationManager.ConnectionStrings["conMN"].ConnectionString);
    public string payStatus = "", token = "", orderGuid = "", CODOrderGuid = "";

    protected void Page_Load(object sender, EventArgs e)
    { 
        ProcessRazorpayPayment();
    }

    private void ProcessRazorpayPayment()
    {
        try
        {
            string paymentId = Request.Form["razorpay_payment_id"];
            string orderid = Request.Form["orderIdd"];
            string buyerAmount = Request.Form["buyerAmount"];
            string key = ConfigurationManager.AppSettings["razorid"];
            string secret = ConfigurationManager.AppSettings["razorsecret"];

            if (string.IsNullOrEmpty(paymentId) || string.IsNullOrEmpty(orderid))
            {
                payStatus = "Invalid payment parameters.";
                return;
            }

            Dictionary<string, object> input = new Dictionary<string, object>();
            input.Add("amount", Convert.ToInt32(buyerAmount));

            RazorpayClient client = new RazorpayClient(key, secret);

            Dictionary<string, string> attributes = new Dictionary<string, string>();
            attributes.Add("razorpay_payment_id", paymentId);
            attributes.Add("razorpay_order_id", Request.Form["razorpay_order_id"]);
            attributes.Add("razorpay_signature", Request.Form["razorpay_signature"]);

            Utils.verifyPaymentSignature(attributes);
            Razorpay.Api.Payment payment = client.Payment.Fetch(paymentId);
            var sts = payment.Attributes;

            Orders orders = new Orders();

            if (sts.status == "captured")
            {
                string Oid = UserCheckout.GetOrderId(conMN, orderid);
                string rId = UserCheckout.GetRMax(conMN);

                orders.OrderGuid = orderid;
                orders.PaymentStatus = "Paid";
                orders.OrderStatus = "InProgress";
                orders.PaymentId = paymentId;
                orders.hostedCheckoutId = "";
                orders.RMax = rId;
                orders.ReceiptNo = "MEDIR" + rId;

                int x = UserCheckout.UpdateUserOrder(conMN, orders);

                if (x > 0)
                {
                    var user = Convert.ToString(Reports.GetUserByOrder(conMN, orderid));

                    if (!string.IsNullOrEmpty(user))
                    {
                        UserCheckout.SendToUser(conMN, orderid);

                        var timeline = new OrderTimeline()
                        {
                            OrderGuid = orderid,
                            OrderStatus = "Confirmed",
                            AddedBy = user,
                        };

                        var exe = OrderTimeline.AddTimeline(conMN, timeline);
                        MemberDetails.UpdatePaymentStatus(conMN, user);
                        var userDetail = MemberDetails.GetMemberDetailsByGuid(conMN, user);

                        Response.Redirect("thank-you1.aspx");
                    }
                    else
                    {
                        payStatus = "There is some problem now. Please try again later";
                    }
                }
            }
            else
            {
                string Oid = UserCheckout.GetOrderId(conMN, orderid);

                orders.OrderGuid = orderid;
                orders.PaymentStatus = "Failed";
                orders.OrderStatus = "Failed";
                orders.PaymentId = "";
                orders.hostedCheckoutId = "";
                orders.RMax = "";
                orders.ReceiptNo = "";

                int x = UserCheckout.UpdateUserOrder(conMN, orders);
                Response.Redirect("pay-error.aspx");
            }
        }
        catch (ArgumentNullException ex)
        {
            ExceptionCapture.CaptureException(HttpContext.Current.Request.Url.PathAndQuery, "payment_status_ArgumentNull", ex.Message);
            payStatus = "There is some problem now. Please try again later";
        }
        catch (WebException ex)
        {
            ExceptionCapture.CaptureException(HttpContext.Current.Request.Url.PathAndQuery, "payment_status_WebException", ex.Message);
            payStatus = "There is some problem now. Please try again later";
        }
        catch (Exception ex)
        {
            ExceptionCapture.CaptureException(HttpContext.Current.Request.Url.PathAndQuery, "payment_status_Exception", ex.Message);
            payStatus = "There is some problem now. Please try again later";
        }
    }
}
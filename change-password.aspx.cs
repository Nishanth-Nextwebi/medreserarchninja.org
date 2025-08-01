using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class change_password : System.Web.UI.Page
{
    SqlConnection conMN = new SqlConnection(ConfigurationManager.ConnectionStrings["conMN"].ConnectionString);
    public string strDues = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["med_uid"] == null)
        {

            Response.Redirect("login.aspx");
        }

        int count = Projects.GetPendingProjectDuesCount(conMN, Request.Cookies["med_uid"].Value);
        strDues = count > 0 ? "<span class='badge-circle'>" + count + "</span>" : "";

    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        if (Request.Cookies["med_uid"] != null)
        {
            Response.Cookies["med_uid"].Expires = TimeStamps.UTCTime().AddDays(-10);
            Response.Redirect("login.aspx");
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        lblStatus.Visible = true;
        try
        {
            string pageName = Path.GetFileName(Request.Path);
            if (Page.IsValid)
            {


                var UserGuid = Request.Cookies["med_uid"].Value;
                var Password = CommonModel.Encrypt(txtCurrent.Text.Trim());
                var sts = MemberDetails.CheckPassword(conMN, Password, UserGuid);

                if (sts == "Success")
                {
                    string status = MemberDetails.PasswordReset(conMN, CommonModel.Encrypt(txtNew.Text.Trim()), UserGuid);
                    if (status == "Success")
                    {
                        lblStatus.Text = "Password changed successfully. please login again to proceed";
                        lblStatus.Attributes.Add("class", "alert alert-success");

                        if (Request.Cookies["med_uid"] != null)
                        {
                            Response.Cookies["med_uid"].Expires = TimeStamps.UTCTime().AddDays(-10);
                            //Response.Redirect("login.aspx");
                        }
                    }
                    else
                    {
                        lblStatus.Text = "There is some problem now. Please try after some time";
                        lblStatus.Attributes.Add("class", "alert alert-danger");
                    }
                }
                else
                {
                    lblStatus.Text = "Current Password incorrect";
                    lblStatus.Attributes.Add("class", "alert alert-danger");
                }

            }
        }
        catch (Exception ex)
        {
            lblStatus.Text = "There is some problem now. Please try after some time";
            lblStatus.Attributes.Add("class", "alert alert-danger");
            ExceptionCapture.CaptureException(HttpContext.Current.Request.Url.PathAndQuery, "btnSave_Click", ex.Message);
        }
    }
}
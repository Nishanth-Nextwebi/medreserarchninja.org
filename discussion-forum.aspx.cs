using DocumentFormat.OpenXml.Presentation;
using DocumentFormat.OpenXml.Vml.Office;
using DocumentFormat.OpenXml.Vml;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.EnterpriseServices.Internal;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class discussion_forum : System.Web.UI.Page
{
    SqlConnection conMN = new SqlConnection(ConfigurationManager.ConnectionStrings["conMN"].ConnectionString);
    public string strForums = "", strTopics = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        BindAllForums();
    
    }


    [WebMethod(EnableSession = true)]
    public static string ForumDetails(string title, string topic, string description)
    {

        try
        {
            SqlConnection conMN = new SqlConnection(ConfigurationManager.ConnectionStrings["conMN"].ConnectionString);
            {
                HttpCookie cookie = HttpContext.Current.Request.Cookies["med_uid"];
                string uGuid = cookie != null ? cookie.Value : null;
                var uname = MemberDetails.GetMemberDetailsByGuid(conMN, uGuid);
                Forums f = new Forums
                {
                    Title = title,
                    Topic = topic,
                    Description = description,
                    PageUrl = HttpContext.Current.Request.Url.ToString(),
                    ViewCount = 0,
                    LikeCount = 0,
                    AddedBy = uname.FullName,
                    UserGuid = uGuid,
                    MessageGuid = Guid.NewGuid().ToString(),
                    AddedOn = TimeStamps.UTCTime(),
                    AddedIp = CommonModel.IPAddress(),
                    Status = "Pending"
                };

                int result = Forums.InsertForums(conMN, f);

                if (result > 0)
                {
                    //Emails.NewPostMail(uname.FullName,uname.EmailId);
                    return "Success";
                }
                else
                {
                    return "Error";
                }
            }
        }
        catch (Exception ex)
        {
            ExceptionCapture.CaptureException(HttpContext.Current.Request.Url.PathAndQuery, "ForumDetails", ex.Message);
            return "Error";
        }
    }
    [WebMethod(EnableSession = true)]
    public static string BindAllForums()
    {
        SqlConnection conMN = new SqlConnection(ConfigurationManager.ConnectionStrings["conMN"].ConnectionString);

        try
        {
            var strForums = "";
            var strTopics = "";
            var frm = Forums.GetAllForumsDetails(conMN);
           
            if (frm.Count > 0)
            {

                for (int i = 0; i < frm.Count; i++)
                {
                    if (frm[i].Status == "Accepted")
                    {
                        var url = "forum-details/" + frm[i].MessageGuid;
                        // var cmt = Comments.getNoOfComments(conMN, frm[i].MessageGuid);

                        var currDate = TimeStamps.UTCTime() - frm[i].AddedOn;
                        var ago = "";
                        if (currDate.TotalMinutes < 60)
                        {
                            ago = Convert.ToInt32(currDate.TotalMinutes) + " Minutes ago";
                        }
                        else if (currDate.TotalHours < 24)
                        {
                            ago = currDate.TotalHours.ToString("N0") + " Hours ago";
                        }
                        else if (currDate.TotalDays < 30)
                        {
                            ago = currDate.TotalDays.ToString("N0") + " Days ago";
                        }
                        else if (currDate.TotalDays < 365 / 30)
                        {
                            ago = currDate.TotalDays.ToString("N0") + " Month ago";
                        }
                        else if (currDate.TotalDays > 365)
                        {
                            ago = currDate.TotalDays.ToString("N0") + " Year ago";
                        }
                        var topics = Forums.GetAllForumsTopics(conMN);

                        strForums += @" <div class='community-post wow fadeInUp' data-wow-delay='0.5s' style='visibility: visible; animation-delay: 0.5s; animation-name: fadeInUp;'>
                                        <div class='post-content'>
                                        <div class='author-avatar'>
                                                <img src='new-img/question.png' alt='community post'>
                                        </div>
                                        <div class='entry-content'>
                                                    <h3 class='post-title'><a href='" + url + @"' data-guid='" + frm[i].MessageGuid + @"' id='cnt' data-toggle='modal' data-target='#exampleModal' data-toggle='modal' data-target='#exampleModalCenter'>" + frm[i].Title + @"</a></h3>
                                                <p>Last active: " + ago + @"</p>
                                        </div>
                                        </div>
                                        <div class='post-meta-wrapper'>
                                            <ul class='post-meta-info'>
                                                <li><a href='JavaScript:void(0)'><i class='fas fa-eye'></i>" + frm[i].ViewCount + @"</a></li>
                                                <li><a href='JavaScript:void(0)'><i class='fa-regular fa-comments'></i>" + frm[i].CommentCount + @"</a></li>
                                                <li><a href='JavaScript:void(0)'><i class='fa-solid fa-thumbs-up'></i>" + frm[i].LikeCount + @"</a></li>
                                            </ul>
                                        </div>
                                    </div>";


                        strTopics += @"<ul class='cats pl0'> <li><a href='JavaScript:void(0)'> " + frm[i].Topic + @"<span class='badge pull-right'>" + topics[0].TopicCnt + @"</span></a></li></ul>";

                        // return strTopics;

                    }
                }
                return JsonConvert.SerializeObject(new { Forum = strForums, Topics = strTopics });

            }


            else
            {
                return "Empty";
            }
        }
        catch (Exception ex)
        {
            ExceptionCapture.CaptureException(HttpContext.Current.Request.Url.PathAndQuery, "BindAllForums", ex.Message);
            return "Error";
        }
    }

   
}
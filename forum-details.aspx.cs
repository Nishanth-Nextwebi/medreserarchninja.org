using DocumentFormat.OpenXml.Spreadsheet;
using DocumentFormat.OpenXml.Vml;
using DocumentFormat.OpenXml.Wordprocessing;
using Newtonsoft.Json;
using Razorpay.Api;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Policy;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class fourm_details : System.Web.UI.Page
{
    SqlConnection conMN = new SqlConnection(ConfigurationManager.ConnectionStrings["conMN"].ConnectionString);
    public string strTitle = "", strDescription = "", strLastseen = "", strComments = "", strTopics = "", strNoOfComments = "", strCat = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        GetTopcs();

        var furl = Convert.ToString(RouteData.Values["furl"]);
       
            if (!string.IsNullOrEmpty(furl))
            {
                UpdatePageCount(furl);
                //UpdateLikeCount(furl);

                BindForumsDetailsNew(furl);
            }
        
    }
    [WebMethod(EnableSession = true)]
    public static string BindForumsDetailsNew(string furl)
    {
        SqlConnection conMN = new SqlConnection(ConfigurationManager.ConnectionStrings["conMN"].ConnectionString);
        try
        {
            var frm = Forums.getForumsDetailsByUrl(conMN, furl);
            //after I need to change it
            HttpCookie cookie = HttpContext.Current.Request.Cookies["med_uid"];
            string uGuid = cookie != null ? cookie.Value : null;

            var currentCount = LikesCount.GetLikeStatus(conMN,furl,uGuid);
            var cls = "";
            if (currentCount > 0)
            {
                cls = "text-warning";
            }


            if (frm != null)
            {
               var strComments = Forums.GetForumsComments(conMN, furl);
                #region GetLastSeen
                var ago = "";
                var currDate = TimeStamps.UTCTime() - frm.AddedOn;
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
                    ago = currDate.TotalDays.ToString("N0") + " Months ago";
                }
                else if (currDate.TotalDays > 365)
                {
                    ago = currDate.TotalDays.ToString("N0") + " Years ago";
                }
                #endregion
                var uname = MemberDetails.GetMemberDetailsByGuid(conMN, uGuid);

                var strTitle = frm.Title;
                var strDescription = frm.Description;
                var strLastseen = ago;
                var strTopics = frm.Topic;
                var strprofImae = uname.ProfileImage;
                var strUserName = uname.FullName;
              /*  for (int i = 0; i < strComments.Count; i++)
                {
                    strComments1 += @"<div class='forum-comment'>
                                    <div class='forum-post-top'>
                                        <a class='author-avatar' href='#'>
                                            <img src='/new-img/cp1.png' alt='author avatar'>
                                        </a>
                                        <div class='forum-post-author'>
                                            <a class='author-name' href='#'>Unknown</a>
                                            <div class='forum-author-meta'>
                                                <div class='author-badge'>
                                                    <i class='fa-solid fa-calendar-days'></i>
                                                   <a href='/'>" + Convert.ToDateTime(strComments[i].AddedOn).ToString("MMMM dd 'at' hh:mm tt") + @"</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class='comment-content'>
                                        <p>" + HttpUtility.UrlDecode(strComments[i].Message) + @"</p>
                                    </div>
                                </div>";
                }
*/
                return JsonConvert.SerializeObject(new { Cmnt = strComments,LikeCls=cls, Title = strTitle, Desc = strDescription, LastUpdate = strLastseen, CommentCount = frm.CommentCount, Topics = strTopics, ProfileImage = strprofImae, FullName = strUserName });

            }
            else
            {
                return "Empty";
            }
        }
        catch (Exception ex)
        {
            ExceptionCapture.CaptureException(HttpContext.Current.Request.Url.PathAndQuery, "BindForumsDetailsNew", ex.Message);

            return "Error";
        }
    }

    public void GetTopcs()
    {
        try
        {
            var sub = Forums.GetAllTopicsCount(conMN);
            if (sub != null && sub.Count > 0)
            {
                strCat = "";
                foreach (var topic in sub)
                {
                    strCat += @"<ul class='cats pl0'>
                                <li>
                                    <a href='JavaScript:void(0)'>
                                        "+topic.Topic+@"
                                        <span class='badge pull-right'>"+topic.TopicCnt+@"</span>
                                    </a>
                                </li>
                             </ul>";
                }
            }
        }
        catch (Exception ex)
        {
            ExceptionCapture.CaptureException(HttpContext.Current.Request.Url.PathAndQuery, "GetTopcs", ex.Message);
        }
    }




    private void UpdatePageCount(string uGuid)
    {
        try
        {
            var currentCount = Forums.GetPageCount(conMN, uGuid);
            var res = Forums.UpdateCount(conMN, (currentCount + 1), uGuid);
        }
        catch (Exception ex)
        {
            ExceptionCapture.CaptureException(HttpContext.Current.Request.Url.PathAndQuery, "UpdatePageCount", ex.Message);
        }
    }


    //[WebMethod(EnableSession = true)]
    //public static string BindAllComments(string furl)
    //{
    //    string strComments = "";
    //    try
    //    {
    //        SqlConnection conMN = new SqlConnection(ConfigurationManager.ConnectionStrings["conMN"].ConnectionString);
    //        var cmt = Comments.GetAllCommentsDetails(conMN, furl).ToList();

    //        if (cmt.Count > 0)
    //        {
    //            for (int i = 0; i < cmt.Count; i++)
    //            {
    //                string Date = cmt[i].AddedOn.ToString("MMMM d 'at' h:mm tt");
    //                strComments += @"<div class='forum-comment'>
    //                                <div class='forum-post-top'>
    //                                    <a class='author-avatar' href='#'>
    //                                        <img src='/new-img/cp1.png' alt='author avatar'>
    //                                    </a>
    //                                    <div class='forum-post-author'>
    //                                        <a class='author-name' href='#'>Unknown</a>
    //                                        <div class='forum-author-meta'>
    //                                            <div class='author-badge'>
    //                                                <i class='fa-solid fa-calendar-days'></i>
    //                                                <a href='/'>" + Date + @"</a>
    //                                            </div>
    //                                        </div>
    //                                    </div>
    //                                </div>
    //                                <div class='comment-content'>
    //                                    <p>" + HttpUtility.UrlDecode(cmt[i].Message) + @"</p>
    //                                </div>
    //                            </div>";
    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        ExceptionCapture.CaptureException(HttpContext.Current.Request.Url.PathAndQuery, "BindAllComments", ex.Message);
    //        return "Error";
    //    }
    //    return strComments;
    //}

    [WebMethod(EnableSession = true)]
    public static string Commentsdetails(string message, string guid)
    {
        try
        {
            SqlConnection conMN = new SqlConnection(ConfigurationManager.ConnectionStrings["conMN"].ConnectionString);
            {
                HttpCookie cookie = HttpContext.Current.Request.Cookies["med_uid"];
                string uGuid = cookie != null ? cookie.Value : null;
                var uname = MemberDetails.GetMemberDetailsByGuid(conMN, uGuid);

                Comments c = new Comments

                {
                    Message = message,
                    PageUrl = HttpContext.Current.Request.Url.AbsoluteUri,
                    LikeCount = 0,
                    AddedBy = uname.FullName,
                    UserGuid = uGuid,
                    MessageGuid = Convert.ToString(guid),
                    AddedOn = TimeStamps.UTCTime(),
                    AddedIp = CommonModel.IPAddress(),
                    Status = "Pending"
                };

                int result = Comments.InsertComments(conMN, c);

                if (result > 0)
                {

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
            ExceptionCapture.CaptureException(HttpContext.Current.Request.Url.PathAndQuery, "CommentsDetails", ex.Message);
            return "Error";
        }
    }


    [WebMethod(EnableSession = true)]
    public static string AddLike(string mesGuid)
    {
        SqlConnection conMN = new SqlConnection(ConfigurationManager.ConnectionStrings["conMN"].ConnectionString);

        try
        {

            HttpCookie cookie = HttpContext.Current.Request.Cookies["med_uid"];
            string uGuid = cookie != null ? cookie.Value : null;
            if (uGuid != "")
            {
                var like = new LikesCount()
                {
                    MessageGuid = mesGuid.Trim(),
                    UserGuid = uGuid,
                    AddedIp = CommonModel.IPAddress(),
                    AddedOn = TimeStamps.UTCTime(),

                };
                var exe = LikesCount.InsertLikes(conMN, like);
                if (exe > 0)
                {
                    return "Success";
                }
            }
        }
        catch (Exception ex)
        {
            ExceptionCapture.CaptureException(HttpContext.Current.Request.Url.PathAndQuery, "AddLike", ex.Message);

        }

        return "Error";
    }

    [WebMethod(EnableSession = true)]
    public static string RemoveLike(string mesGuid)
    {
        SqlConnection conMN = new SqlConnection(ConfigurationManager.ConnectionStrings["conMN"].ConnectionString);

        try
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies["med_uid"];
            string uGuid = cookie != null ? cookie.Value : null;
            if (uGuid != "")
            {

                var exe = LikesCount.DeleteLikes(conMN, uGuid, mesGuid.Trim());
                if (exe > 0)
                {
                    return "Success";
                }
            }
        }
        catch (Exception ex)
        {
            ExceptionCapture.CaptureException(HttpContext.Current.Request.Url.PathAndQuery, "RemoveLike", ex.Message);

        }
        return "Error";
    }

}

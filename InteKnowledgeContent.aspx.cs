using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.IO;
using NetworkEducation.DBConnection;
using System.Data;

 
namespace NetworkEducation
{

    public partial class InteKnowledgeContent : System.Web.UI.Page
    {
        public string Content;
        public string NickName;
        public string Title1;
        public string TitleColor;
        public string ViewCount;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserIsValid"] == null)
            {
                Response.Redirect("Default.aspx");
            }

            if (string.IsNullOrEmpty(Request["cid"]))
            {
                Response.End();
            }

            Dictionary<string, object> p = new Dictionary<string, object>()
            {
                {"@cid",Request["cid"]}
            };

            //使用cookie技术设置点击率
            HttpCookie cookie = Request.Cookies["IsFirst"];
            if (cookie == null)
            {
                SqlHelper.ExecuteNonQuery("update InteKContent set ViewCount=ViewCount+1 where Cpid=@cid", p);    
                cookie = new HttpCookie("IsFirst", "No");
                cookie.Expires = DateTime.Now.AddSeconds(2);
                Response.Cookies.Add(cookie);
            }

            string sql = "select * from InteKContent,UserInfor where Cpid=@cid and UserInfor.ID=Cupid";
            
            DataTable dt = SqlHelper.GetDataTable(sql, p);
            this.Content = dt.Rows[0]["Content"].ToString();
            this.NickName = dt.Rows[0]["NickName"].ToString();
            this.TitleColor = dt.Rows[0]["TitleColor"].ToString();
            this.Title1 = dt.Rows[0]["Title"].ToString();
            this.ViewCount = dt.Rows[0]["ViewCount"].ToString();

           

        }

    }
}
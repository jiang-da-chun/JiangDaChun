using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using NetworkEducation.DBConnection;
using System.Data;

namespace NetworkEducation
{
    public partial class UpInteKContent : System.Web.UI.Page
    {
        public int Cupid;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserIsValid"] == null)
            {
                Response.Redirect("Default.aspx");
            }

            if (string.IsNullOrEmpty(Request["Cpid"]))
            {
                Response.End();
            }

            int Cpid = int.Parse(Request["Cpid"].ToString());
            string sql = "select * from InteKnowledge,UserInfor where InteKnowledge.ID=@ID and Kupid=UserInfor.ID";
            Dictionary<string, object> p = new Dictionary<string, object>()
            {
                {"@ID",Cpid}
            };
            DataTable dt = SqlHelper.GetDataTable(sql, p);
            this.tbTitle.Text = dt.Rows[0]["Title"].ToString();
            this.ddlTitleColor.SelectedValue = dt.Rows[0]["TitleColor"].ToString();
            this.tbAuthor.Text = dt.Rows[0]["NickName"].ToString();

            Cupid = int.Parse(dt.Rows[0]["Kupid"].ToString());
            //this.tbTitle.Text = Request["Title"].ToString();
            //this.ddlTitleColor.SelectedValue = Request["TitleColor"].ToString();
            //this.tbAuthor.Text = Request["NickName"].ToString();


        }

        protected void submit_Click(object sender, EventArgs e)
        {
            if (this.IsValid == false)
            {
                return;
            }

            //数据入库
            string sql = @"INSERT INTO [InteKContent]
                                       ([Title]
                                       ,[TitleColor]
                                       ,[Content]
                                       ,[Cpid]
                                       ,[Cupid])
                                 VALUES
                                       (@Title
                                       ,@TitleColor
                                       ,@Content
                                       ,@Cpid
                                       ,@Cupid)";
            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@Content", this.tbContent.Text);
            p.Add("@Title", this.tbTitle.Text);
            p.Add("@TitleColor", this.ddlTitleColor.SelectedValue);
            p.Add("@Cpid", Request["Cpid"]);
            p.Add("@Cupid", Cupid);


            try
            {
                SqlHelper.ExecuteNonQuery(sql, p);
                Response.Redirect("UpInteKnowledge.aspx");
            }
            catch (Exception)
            {
                throw;
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "55", "$.ligerDialog.error('上传文件失败！');", true);
            }

        }

    }
}
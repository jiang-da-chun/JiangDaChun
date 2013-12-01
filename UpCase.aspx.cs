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
    public partial class UpCase : System.Web.UI.Page
    {
        public int Cupid;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserIsValid"] == null)
            {
                Response.Redirect("Default.aspx");
            }

            string sql = "select NickName,ID from UserInfor where LoginName=@loginName";
            Dictionary<string, object> p = new Dictionary<string, object>()
            {
                {"@loginName",Session["LoginName"]}
            };
            DataTable dt = SqlHelper.GetDataTable(sql, p);
            this.tbAuthor.Text = dt.Rows[0]["NickName"].ToString();//填充发布人编辑框
            this.Cupid = int.Parse(dt.Rows[0]["ID"].ToString());//给Teaching表的外键赋值



            //给选择颜色的下来控件Text域显示字体加颜色
            this.ddlTitleColor.Items[1].Attributes.Add("style", "color:green;");
            this.ddlTitleColor.Items[2].Attributes.Add("style", "color:blue;");
            this.ddlTitleColor.Items[3].Attributes.Add("style", "color:red;");

        }

        protected void submit_Click(object sender, EventArgs e)
        {
            if (this.IsValid == false)
            {
                return;
            }

            //数据入库
            string sql = @"INSERT INTO [CaseAnalyse]
                                       ([Title]
                                       ,[Develop]
                                       ,[Content]
                                       ,[Cupid]
                                       ,[TitleColor])
                                 VALUES
                                       (@Title
                                       ,@Develop
                                       ,@Content
                                       ,@Cupid
                                       ,@TitleColor
                                       )";
            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@Content", this.tbContent.Text);
            p.Add("@Title", this.tbTitle.Text);
            p.Add("@TitleColor", this.ddlTitleColor.SelectedValue);
            p.Add("@Cupid", this.Cupid);
            p.Add("@Develop", this.ddlDevelop.SelectedValue);

            try
            {
                SqlHelper.ExecuteNonQuery(sql, p);
                this.tbTitle.Text = string.Empty;
                this.tbContent.Text = string.Empty;
            }
            catch (Exception)
            {
                throw;
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "55", "$.ligerDialog.error('上传文件失败！');", true);
            }

        }

    }
}
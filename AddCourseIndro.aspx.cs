using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NetworkEducation.DBConnection;

namespace NetworkEducation.Admin
{
    public partial class AddCourseIndro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["AdminIsValid"] == null)
            {
                Response.Redirect("../Default.aspx");
            }


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
            string sql = @"INSERT INTO [CourseIndro]
                                   ([Content]
                                   ,[Title]
                                   ,[TitleColor]
                                   ,[Author])
                             VALUES
                                   (@Content
                                   ,@Title
                                   ,@TitleColor
                                   ,@Author)";
            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@Content", this.tbContent.Text);
            p.Add("@Title", this.tbTitle.Text);
            p.Add("@TitleColor", this.ddlTitleColor.SelectedValue);
            if (string.IsNullOrEmpty(this.tbAuthor.Text))
            {
                p.Add("@Author", DBNull.Value);
            }
            else
            {
                p.Add("@Author", this.tbAuthor.Text.Replace(" ", ""));
            }


            try
            {
                SqlHelper.ExecuteNonQuery(sql, p);
                this.tbTitle.Text = string.Empty;
                this.tbContent.Text = string.Empty;
            }
            catch (Exception)
            {

                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "55", "$.ligerDialog.error('数据入库失败！');", true);
            }

        }

    }
}
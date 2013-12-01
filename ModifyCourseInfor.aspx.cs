using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using NetworkEducation.DBConnection;

namespace NetworkEducation.Admin
{
    public partial class ModifyCourseInfor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["AdminIsValid"] == null)
            {
                Response.Redirect("../Default.aspx");
            }

            if (string.IsNullOrEmpty(Request["id"])) //如果id值不能正确获取，则停下来
            {
                Response.End();//运行到此就停止
            }

            //给选择颜色的下来控件Text域显示字体加颜色
            this.ddlTitleColor.Items[1].Attributes.Add("style", "color:green;");
            this.ddlTitleColor.Items[2].Attributes.Add("style", "color:blue;");
            this.ddlTitleColor.Items[3].Attributes.Add("style", "color:red;");

            #region 根据获取得id值查询数据并显示在修改网页上
            if (!this.IsPostBack)
            {

                string sql = @"select * from CourseIndro where id=@id";
                Dictionary<string, object> p = new Dictionary<string, object>();
                p.Add("@id", Request["id"]);
                DataTable dt = SqlHelper.GetDataTable(sql, p);

                //填充信息到修改网页的控件中
                this.tbTitle.Text = dt.Rows[0]["Title"].ToString();
                this.tbContent.Text = dt.Rows[0]["Content"].ToString();
                this.ddlTitleColor.SelectedValue = dt.Rows[0]["TitleColor"].ToString();

                if (dt.Rows[0]["Author"].ToString() == "")
                {
                    this.tbAuthor.Text = "";
                }
                else
                {
                    this.tbAuthor.Text = dt.Rows[0]["Author"].ToString();

                }

            }
            #endregion

            this.tbTitle.Focus();

        }

        protected void submit_Click(object sender, EventArgs e)
        {
            if (this.IsValid == false)//如果网页合法性未通过 
            {
                return;
            }

            string sql = @"UPDATE [CourseIndro]
                               SET [Content] = @Content
                                  ,[Title] = @Title
                                  ,[TitleColor] = @TitleColor
                                  ,[Author] = @Author
                             WHERE id=@id";
            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@id", Request["id"]);

            p.Add("@Content",this.tbContent.Text);
            p.Add("@Title", this.tbTitle.Text.Replace(" ", ""));
            p.Add("@TitleColor", this.ddlTitleColor.SelectedValue);
  
            if (string.IsNullOrWhiteSpace(this.tbAuthor.Text))
            {
                p.Add("@Author", DBNull.Value);
            }
            else
            {
                p.Add("@Author", this.tbAuthor.Text.Replace(" ", ""));

            }


            //数据入库
            try
            {
                SqlHelper.ExecuteNonQuery(sql, p);
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "88", "parent.CloseEdit();", true);
            }
            catch (Exception)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "8", "$.ligerDialog.error('修改失败！');", true);
            }
        }

        protected void Reset1_Click(object sender, EventArgs e)
        {
            this.tbTitle.Text = this.tbAuthor.Text = this.tbContent.Text = string.Empty;
        }

    }
}
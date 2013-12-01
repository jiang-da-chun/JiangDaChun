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
    public partial class UpInteKnowledge : System.Web.UI.Page
    {
        public int Kupid;
        public int Cpid;

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
            this.Kupid = int.Parse(dt.Rows[0]["ID"].ToString());//给InteKnowledge表的外键赋值

            //获取当前要插入内容的ID字段
            sql = "select top 1 * from InteKnowledge order by id desc";
            dt = SqlHelper.GetDataTable(sql, null);
            Cpid = int.Parse(dt.Rows[0]["ID"].ToString()) + 1;


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
            string sql = @"INSERT INTO [InteKnowledge]
                                       ([Title]
                                       ,[TitleColor]
                                       ,[Content]
                                       ,[Kupid])
                                 VALUES
                                       (@Title
                                       ,@TitleColor
                                       ,@Content
                                       ,@Kupid)";
            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@Content", this.tbContent.Text);
            p.Add("@Title", this.tbTitle.Text);
            p.Add("@TitleColor", this.ddlTitleColor.SelectedValue);
            p.Add("@Kupid", this.Kupid);

            try
            {
                SqlHelper.ExecuteNonQuery(sql, p);
                //Response.Redirect("UpTeaching.aspx?id=5");
                //Response.Redirect("UpInteKContent.aspx?Title=" + Title1 + "&TitleColor=" + TitleColor + "&NickName=" + NickName + "&Cpid=" + Cpid + "&Cupid=" + Kupid);
                Response.Redirect("UpInteKContent.aspx?Cpid=" + Cpid);
            }
            catch (Exception)
            {
                throw;
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "55", "$.ligerDialog.error('上传文件失败！');", true);
            }

        }

    }
}
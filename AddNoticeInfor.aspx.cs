using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NetworkEducation.DBConnection;

namespace NetworkEducation
{
    public partial class AddNoticeInfor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UserIsValid"] == null)
            {
                Response.Redirect("Default.aspx");
            }


            if (!this.IsPostBack)
            {
                this.tbName.Focus();
            }
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            if (this.IsValid == false)//如果网页的合法性未通过
            {
                return;
            }

            //数据入库
            string sql = @"INSERT INTO [Notice]
                                       ([Name]
                                       ,[Content])
                                 VALUES
                                       (@Name
                                       ,@Content)";
            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@Name", this.tbName.Text.Replace(" ", ""));
            p.Add("@Content", this.tbContent.Text);
  
            try
            {
                SqlHelper.ExecuteNonQuery(sql, p);
                Response.Redirect("Index.aspx");
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "88", "parent.CloseAdd();", true);
            }
            catch (Exception)
            {
                throw;
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "2", "alert('此数据已经存在，不能重复添加！');", true);
            }

        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NetworkEducation.DBConnection;

namespace NetworkEducation.Admin
{
    public partial class AddAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminIsValid"]==null)
            {
                Response.Redirect("../Default.aspx");
            }

            if (!this.IsPostBack)      
            {
                this.tbName.Focus();
            }
        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string sql = "select count(*) from Admin where LoginName=@LoginName";
            Dictionary<string, object> p = new Dictionary<string, object>()
            {
                {"@LoginName",this.tbName.Text.Replace(" ","")}
            };
            int count = int.Parse(SqlHelper.ExecuteScalar(sql, p).ToString());
            if (count == 1)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            if (this.IsValid == false)//如果网页的合法性未通过
            {
                return;
            }

            //数据入库
            string sql = @"INSERT INTO [Admin]
                                   ([LoginName]
                                   ,[Password]
                                   ,[RealName])
                             VALUES
                                   (@LoginName
                                   ,@Password
                                   ,@RealName)";
            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@LoginName", this.tbName.Text.Replace(" ", ""));
            p.Add("@RealName", this.tbRealName.Text.Replace(" ", ""));
            p.Add("@Password", Common.SHA1(this.tbPassword.Text));

            try
            {
                SqlHelper.ExecuteNonQuery(sql, p);
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "88", "parent.CloseEdit();", true);
            }
            catch (Exception)
            {
                throw;
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "2", "alert('此数据已经存在，不能重复添加！');", true);
            }

        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NetworkEducation.DBConnection;

namespace NetworkEducation.Admin
{
    public partial class ModifyUserPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["AdminIsValid"] == null)
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
            string sql = "select count(*) from UserInfor where LoginName=@LoginName";
            Dictionary<string, object> p = new Dictionary<string, object>()
            {
                {"@LoginName",this.tbName.Text.Replace(" ","")}
            };
            int count = int.Parse(SqlHelper.ExecuteScalar(sql,p).ToString());
            if (count==1)
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }

        }

        protected void submit_Click(object sender, EventArgs e)
        {
            if (!this.IsValid)
            {
                return;
            }
            string sql = @"update UserInfor
                            set Password=@Password
                            where LoginName=@LoginName";
            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@Password",Common.SHA1(this.tbPassword.Text));
            p.Add("@LoginName",this.tbName.Text.Replace(" ",""));

            try
            {
                SqlHelper.ExecuteNonQuery(sql, p);
                //Response.Redirect(Request.UrlReferrer.ToString());//获取有关客户端上次请求的URL信息，该请求链接到当前的URL
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "1", "parent.CloseEdit();", true);
            }
            catch (Exception)
            {
                
                throw;
            }
        }
    }
}
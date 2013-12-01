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
    public partial class ModifyAdminInfor : System.Web.UI.Page
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

            #region 根据获取得id值查询数据并显示在修改网页上
            if (!this.IsPostBack)
            {
                string sql = @"select * from Admin where id=@id";
                Dictionary<string, object> p = new Dictionary<string, object>();
                p.Add("@id", Request["id"]);
                DataTable dt = SqlHelper.GetDataTable(sql, p);

                //填充信息到修改网页的控件中
                this.tbUserName.Text = dt.Rows[0]["LoginName"].ToString();
                this.tbRealName.Text = dt.Rows[0]["RealName"].ToString();
            }
            #endregion
            this.tbUserName.Focus();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (this.IsValid == false)//如果网页合法性未通过
            {
                return;
            }

            string sql = @"UPDATE [Admin]
                            SET {0} [LoginName] = @LoginName 
                                ,[RealName] = @RealName
                            WHERE  id=@id";

            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@id",Request["id"]);
            p.Add("@LoginName",this.tbUserName.Text.Replace(" ",""));
            p.Add("@RealName",this.tbRealName.Text.Replace(" ",""));

            if (!string.IsNullOrWhiteSpace(this.tbPassword.Text))
            {
                sql = string.Format(sql, " [Password]=@Password, ");
                p.Add("@Password",Common.SHA1(this.tbPassword.Text));
            }
            else
            {
                sql = string.Format(sql," ");
            }

            //数据入库
            try
            {
                SqlHelper.ExecuteNonQuery(sql, p);
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "88", "parent.CloseEdit();", true);
            }
            catch (Exception)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "8", "$.ligerDialog.error('修改失败，用户名已存在！');", true);
            }
        }

        protected void Reset1_Click(object sender, EventArgs e)
        {
            this.tbUserName.Text = this.tbRealName.Text = string.Empty;
            this.tbUserName.Focus();
        }


    }
}
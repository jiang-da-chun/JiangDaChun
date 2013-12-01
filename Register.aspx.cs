using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using NetworkEducation.DBConnection;

namespace NetworkEducation
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.tbName.Focus();

        }

        protected void login_Click(object sender, EventArgs e)
        {
            if (this.IsValid==false)//如果网页的合法性未通过
            {
                return;
            }

            //数据入库
            string sql = @"INSERT INTO [UserInfor]
                                   ([LoginName]
                                   ,[NickName]
                                   ,[Password]
                                   ,[QQ]
                                   ,[Address]
                                   ,[Gender]
                                   ,[UserType]
                                   ,[PhoneNumber])
                             VALUES
                                   (@LoginName
                                   ,@NickName
                                   ,@Password
                                   ,@QQ
                                   ,@Address
                                   ,@Gender
                                   ,@UserType
                                   ,@PhoneNumber)";
            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@LoginName",this.tbName.Text.Replace(" ",""));
            p.Add("@NickName", this.tbNickName.Text.Replace(" ", ""));
            p.Add("@UserType",this.ddlUserType.SelectedValue);
            p.Add("@Gender", this.sexMale.Checked == true ? 1 : 0);
            p.Add("@Password",Common.SHA1(this.tbPassword.Text));

            if (string.IsNullOrWhiteSpace(this.tbQQ.Text))
            {
                p.Add("@QQ", DBNull.Value);
            }
            else
            {
                p.Add("@QQ", this.tbQQ.Text.Replace(" ", ""));

            }

            if (string.IsNullOrWhiteSpace(this.tbAddress.Text))
            {
                p.Add("@Address", DBNull.Value);
            }
            else
            {
                p.Add("@Address", this.tbAddress.Text.Replace(" ", ""));

            }


            if (string.IsNullOrWhiteSpace(this.tbPhoneNumber.Text))  
            {
                p.Add("@PhoneNumber", DBNull.Value);
            }
            else
            {
                p.Add("@PhoneNumber", this.tbPhoneNumber.Text.Replace(" ", ""));

            }



            try
            {
                SqlHelper.ExecuteNonQuery(sql, p);
                Response.Redirect("Default.aspx");
            }
            catch (Exception)
            {
                throw;
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "2", "alert('此数据已经存在，不能重复添加！');", true);
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
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

    }
}
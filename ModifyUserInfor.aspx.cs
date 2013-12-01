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
    public partial class ModifyUserInfor : System.Web.UI.Page
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
                string sql = @"select * from UserInfor where id=@id";
                Dictionary<string, object> p = new Dictionary<string, object>();
                p.Add("@id", Request["id"]);
                DataTable dt = SqlHelper.GetDataTable(sql, p);

                //填充信息到修改网页的控件中
                this.tbUserName.Text = dt.Rows[0]["LoginName"].ToString();
                this.tbNickName.Text = dt.Rows[0]["NickName"].ToString();
                this.ddlUserType.SelectedValue = dt.Rows[0]["UserType"].ToString();
                
                if (dt.Rows[0]["Gender"].ToString()=="True")
                {
                    this.sexMale.Checked = true;
                }
                else
                {
                    this.sexFemale.Checked = true;
                }


                if (dt.Rows[0]["QQ"].ToString()=="")
                {
                    this.tbQQ.Text = "";
                }
                else
                {
                    this.tbQQ.Text = dt.Rows[0]["QQ"].ToString();
                }


                if (dt.Rows[0]["Address"].ToString()=="")
                {
                    this.tbAddress.Text = "";
                }
                else
                {
                    this.tbAddress.Text = dt.Rows[0]["Address"].ToString();

                }


                if (dt.Rows[0]["PhoneNumber"].ToString()=="")
                {
                    this.tbPhoneNo.Text = "";
                }
                else
                {
                    this.tbPhoneNo.Text = dt.Rows[0]["PhoneNumber"].ToString();
                }

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

            string sql = @"UPDATE [UserInfor]
                               SET [LoginName] = @LoginName
                                  ,[NickName] = @NickName
                                  ,[QQ] = @QQ
                                  ,[Address] = @Address
                                  ,[Gender] = @Gender
                                  ,[UserType] = @UserType
                                  ,[PhoneNumber] = @PhoneNumber
                             WHERE id=@id";
            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@id",Request["id"]);
            //if (this.tbUserName.Text == "")
            //{
            //    Response.Write("");

            //}
            p.Add("@LoginName", this.tbUserName.Text.Replace(" ", ""));
            p.Add("@NickName", this.tbNickName.Text.Replace(" ", ""));
            p.Add("@UserType", this.ddlUserType.SelectedValue);
            
            p.Add("@Gender", this.sexMale.Checked == true ? 1 : 0);
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


            if (string.IsNullOrWhiteSpace(this.tbPhoneNo.Text))
            {
                p.Add("@PhoneNumber", DBNull.Value);
            }
            else
            {
                p.Add("@PhoneNumber", this.tbPhoneNo.Text.Replace(" ", ""));

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
            this.tbUserName.Text = this.tbNickName.Text = this.tbAddress.Text = this.tbQQ.Text = this.tbPhoneNo.Text = string.Empty;
            this.tbUserName.Focus();
        }


    }
}
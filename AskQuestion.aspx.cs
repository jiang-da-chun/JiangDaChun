using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using NetworkEducation.DBConnection;

namespace NetworkEducation
{
    public partial class AskQuestion : System.Web.UI.Page
    {
        int Qupid;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserIsValid"] == null)
            {
                Response.Redirect("Default.aspx");
            }


            string sql = "select * from UserInfor where LoginName=@LoginName";
            Dictionary<string, object> p = new Dictionary<string, object>()
            {
                {"@LoginName",Session["LoginName"]}
            };


            try
            {
                DataTable dt = SqlHelper.GetDataTable(sql, p);
                this.tbNickName.Text = dt.Rows[0]["NickName"].ToString();

                if (dt.Rows[0]["Gender"].ToString() == "True")
                {
                    this.rblSex.SelectedValue = "1";
                }
                else
                {
                    this.rblSex.SelectedValue = "0";
                }

                if (dt.Rows[0]["QQ"].ToString() == "")
                {
                    this.tbQQ.Text = "";
                }
                else
                {
                    this.tbQQ.Text = dt.Rows[0]["QQ"].ToString();
                }

                if (dt.Rows[0]["Address"].ToString() == "")
                {
                    this.tbAddress.Text = "";
                }
                else
                {
                    this.tbAddress.Text = dt.Rows[0]["Address"].ToString();
                }

                if (dt.Rows[0]["PhoneNumber"].ToString() == "")
                {
                    this.tbPhoneNo.Text = "";
                }
                else
                {
                    this.tbPhoneNo.Text = dt.Rows[0]["PhoneNumber"].ToString();
                }


                this.Qupid = int.Parse(dt.Rows[0]["ID"].ToString());//给外键赋值 

            }
            catch (Exception)
            {

                throw;
            }
            //}

        }


        protected void Button1_Click1(object sender, EventArgs e)
        {
            if (!this.IsValid)
            {
                return;
            }

            string sql = @"INSERT INTO [Question]
                                       ([Content]
                                       ,[Qupid])
                                 VALUES
                                       (@Content
                                       ,@Qupid)";
            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@Content", this.tbContent.Text);
            p.Add("@Qupid", this.Qupid);

            try
            {
                SqlHelper.ExecuteNonQuery(sql, p);

                //Response.Redirect("");
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "2", "alert('数据插入成功！');", true);
                this.tbContent.Text = string.Empty;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
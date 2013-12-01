using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NetworkEducation.DBConnection;

namespace NetworkEducation
{
    public partial class Default : System.Web.UI.Page
    {
        public int count;
        public string loginName;
        public string Password;
        public string userType;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.tbLoginName.Focus();   
                  
            if (Session["AdminIsValid"] != null)
            {
                Response.Redirect("Admin/Frame.aspx");
            }

            if (Session["UserIsValid"] != null)
            {
                Response.Redirect("Index.aspx");
            }

            //获取用户填入的登录信息
            loginName = this.tbLoginName.Text.Replace(" ", "");
            Password = this.tbPassword.Text;
            userType = this.rblType.SelectedValue;


            //如果由于初始化网页而执行Page_Load（第一初级执行，还没有提交的数据），所以后面的数据获取及用户登录认证就不用执行啦
            if (string.IsNullOrEmpty(loginName) || string.IsNullOrEmpty(Password))
            {
                HttpCookie adminCookie = Request.Cookies["adminCookieName"];
                HttpCookie userCookie = Request.Cookies["userCookieName"];

                if (adminCookie != null)
                {
                    loginName = adminCookie["LoginName"].ToString();
                    Password = adminCookie["PassWord"].ToString();
                    userType = adminCookie["userType"].ToString();
                }

                if (userCookie != null)
                {
                    loginName = userCookie["LoginName"].ToString();
                    Password = userCookie["PassWord"].ToString();
                    userType = userCookie["userType"];
                }
            }

            if (string.IsNullOrEmpty(loginName) || string.IsNullOrEmpty(Password))
            {
                return;
            }


        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            HttpCookie cookie = Request.Cookies["CheckCode"];
            if (cookie == null)
            {
                args.IsValid = false;
                return;
            }
            string cookieCode = cookie.Value;
            if (cookieCode != this.tbValideCode.Text.ToUpper())
            {
                args.IsValid = false;
                return;
            }
            args.IsValid = true;
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            if (!this.IsValid)
            {
                return;
            }

            //判断此登录名和密码是否存在于数据中，如果存在，则为合法用户；如果不存在就不能登录系统

            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@loginName", loginName);
            p.Add("@p", Common.SHA1(Password));

            //根据用户类型执行不同的sql语句,如果userType=""则表示管理员,否则表示一般用户
            if (userType == "")
            {
                count = int.Parse(SqlHelper.ExecuteScalar("select count(*) from Admin where LoginName=@loginName and Password=@p", p).ToString());
                if (count > 0)
                {
                    Session["AdminIsValid"] = true;
                    Session.Add("LoginName", loginName);
                    // Session["LoginName"] = loginName;

                    //能进入到此表示成功登录，就要保存此管理员登录的IP地址
                    string sql = "update Admin set LastLoginIP=@LastLoginIP where LoginName=@LoginName";
                    Dictionary <string,object> parameter=new Dictionary<string,object>();
                    parameter.Add("@LoginName", loginName);
                    parameter.Add("@LastLoginIP", Request.UserHostAddress);
                    SqlHelper.ExecuteNonQuery(sql, parameter);

                    //能够进入到此表示成功登录，把用户信息写入Cookie

                    HttpCookie adminLoginCookie = new HttpCookie("adminCookieName");
                    adminLoginCookie["LoginName"] = loginName;
                    adminLoginCookie["Password"] = Password;
                    adminLoginCookie["userType"] = userType;
                    adminLoginCookie.Expires = DateTime.Now.AddMinutes(2);
                    Response.Cookies.Add(adminLoginCookie);

                    Response.Redirect("Admin/Frame.aspx");
                }
                else
                {
                    Response.Write("<script>alert(\"登录信息错误！\");window.history.back();</script>");
                }

            }
            else
            {
                p.Add("@UserType", userType);
                count = int.Parse(SqlHelper.ExecuteScalar("select count(*) from UserInfor where LoginName=@loginName and Password=@p and UserType=@UserType", p).ToString());
                if (count > 0)
                {
                    Session["UserIsValid"] = true;
                    Session.Add("LoginName", loginName);
                    Session["UserType"] = userType;
                    // Session["LoginName"] = loginName;

                    //能够进入到此表示成功登录，把用户信息写入Cookie

                    HttpCookie userLoginCookie = new HttpCookie("userCookieName");
                    userLoginCookie["LoginName"] = loginName;
                    userLoginCookie["Password"] = Password;
                    userLoginCookie["userType"] = userType;
                    userLoginCookie.Expires = DateTime.Now.AddMinutes(2);
                    Response.Cookies.Add(userLoginCookie);

                    Response.Redirect("Index.aspx");
                }
                else
                {
                    Response.Write("<script>alert(\"登录信息错误！\");window.history.back();</script>");
                }

            }

        }
    }
}
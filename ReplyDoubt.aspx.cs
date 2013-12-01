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
    public partial class ReplyDoubt : System.Web.UI.Page
    {
        public string NickName;  
        public string Gender;
        public string QQ;
        public string Address;
        public string PhoneNo;
        public string Content;
        public string PostTime;
        public int QuestionID;
        public int ReplyUserID; 

        protected void Page_Load(object sender, EventArgs e)
        {


            if (Session["UserIsValid"] == null)
            {
                Response.Redirect("Default.aspx");
            }


            //给回复时的控件填充值  
            string sql = "select * from UserInfor where LoginName=@LoginName ";
            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@LoginName", Session["LoginName"]);
            DataTable dt = SqlHelper.GetDataTable(sql, p);

            if (dt.Rows[0]["UserType"].ToString() == "True")//填充用户类别下拉控件的值
            {
                this.ddlUserType.SelectedValue = "1";
            }
            else
            {
                this.ddlUserType.SelectedValue = "0";
            }
            //this.ddlUserType.SelectedValue = dt.Rows[0]["UserType"].ToString();//填充用户类别下拉控件的值
            this.tbNickName.Text = dt.Rows[0]["NickName"].ToString();//填充用户昵称文本框
            this.ReplyUserID = int.Parse(dt.Rows[0]["ID"].ToString());//获取用户的ID号

             
            //根据问题的id号查询问题的内容和提问者的相关信息，以便显示在回复页面上
            
            int.TryParse(Request["qid"], out QuestionID);

            sql = "select * from Question,UserInfor where Question.id=@qid and Qupid=UserInfor.id";
            Dictionary<string, object> parameter = new Dictionary<string, object>();
            parameter.Add("@qid", QuestionID);
            DataTable data = SqlHelper.GetDataTable(sql, parameter);

            NickName = data.Rows[0]["NickName"].ToString();
            Gender = data.Rows[0]["Gender"].ToString() == "" ? "保密" : (bool)data.Rows[0]["Gender"] ? "先生" : "女士";
            QQ = data.Rows[0]["QQ"].ToString() == "" ? "保密" : data.Rows[0]["QQ"].ToString();
            Address = data.Rows[0]["Address"].ToString() == "" ? "保密" : data.Rows[0]["Address"].ToString();
            PhoneNo = data.Rows[0]["PhoneNumber"].ToString() == "" ? "保密" : data.Rows[0]["PhoneNumber"].ToString();
            PostTime = string.Format("{0:f}", data.Rows[0]["PostTime"].ToString());     
            Content = data.Rows[0]["Content"].ToString();


            //设置当前的页码  
            int currentPage;
            int.TryParse(Request["page"], out currentPage);
            if (currentPage <= 0) currentPage = 1;
            
            //给分页控件设置相应的参数
            sql = "select count(*) from Reply where Rqpid=@qid";
            int recordCount = int.Parse(SqlHelper.ExecuteScalar(sql, parameter).ToString());
            this.AspNetPager1.RecordCount = recordCount;
            this.AspNetPager1.CurrentPageIndex = currentPage;
            this.AspNetPager1.PageSize = 2;   


            //设置数据控件Repeater的数据源  
            sql = @"select *
                    from
                    (
	                    select ROW_NUMBER() OVER (ORDER BY ID DESC) AS RowNo,*
	                    from
	                    (
		                    select Reply.ID,Content,PostTime,NickName,QQ,[Address],Gender,UserType,PhoneNumber 
		                    from Reply,UserInfor
                            where Rqpid=@qid and Rupid=UserInfor.ID
	                     )as t1 
                    )AS t2
                    where RowNo>@pageSize*(@CurrentPage-1) and RowNo <=@pageSize*@CurrentPage;";
            parameter.Add("@pageSize", this.AspNetPager1.PageSize);
            parameter.Add("@CurrentPage", currentPage);

            this.rptQuestionReply.DataSource = SqlHelper.GetDataTable(sql, parameter);
            this.rptQuestionReply.DataBind();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string sql = @"INSERT INTO [Reply]
                                   ([Content]
                                   ,[Rupid]
                                   ,[Rqpid]
                                   )
                             VALUES
                                   (@Content
                                   ,@Rupid
                                   ,@Rqpid)";
                                   
            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@Content", this.tbContent.Text);
            p.Add("@Rqpid", QuestionID);
            p.Add("@Rupid", ReplyUserID);

            SqlHelper.ExecuteNonQuery(sql, p);
            Response.Redirect("ReplyDoubt.aspx?qid="+QuestionID);   
        }
    }
}
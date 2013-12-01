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
    public partial class DisplayDoubt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


            if (Session["UserIsValid"] == null)
            {
                Response.Redirect("Default.aspx");
            }

            //设置当前页
            int currentPage;
            int.TryParse(Request["page"], out currentPage);
            if (currentPage <= 0) currentPage = 1;

            //设置分页条的相关参数：记录数RecordCount,当前页码CurrentPageIndex,页码大小PageSize
            string sql = "select count(*) from Question";
            int recordCount = int.Parse(SqlHelper.ExecuteScalar(sql, null).ToString());
            this.AspNetPager1.RecordCount = recordCount;
            this.AspNetPager1.CurrentPageIndex = currentPage;
            this.AspNetPager1.PageSize = 2;

            //设置Repeater数据控件的数据源
            sql = @"select *
                    from
                    (
	                    select ROW_NUMBER() OVER (ORDER BY ID DESC) AS RowNo,*
	                    from
	                    (
		                    select Question.ID,Content,PostTime,NickName,QQ,[Address],Gender,UserType,PhoneNumber 
		                    from Question,UserInfor
                            where Qupid= UserInfor.ID
	                     )as t1 
                    )AS t2
                    where RowNo>@pageSize*(@CurrentPage-1) and RowNo <=@pageSize*@CurrentPage;";

            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@pageSize", this.AspNetPager1.PageSize);
            p.Add("@CurrentPage", currentPage);

            DataTable dt = SqlHelper.GetDataTable(sql, p);
            this.rptQuestion.DataSource = dt;
            this.rptQuestion.DataBind();

        }

        protected void rptQuestion_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Repeater rpt = e.Item.FindControl("rptQuestionReply") as Repeater;//找到内层的Repeater控件
            DataRowView item = e.Item.DataItem as DataRowView;//获得当前外层Repeater控件的当前数据条目Item

            string sql = "select top 3 * from Reply,UserInfor where Rqpid=@Rqpid and Rupid=UserInfor.ID order by Reply.ID desc";
            Dictionary<string, object> p = new Dictionary<string, object>()
            {
                {"@Rqpid",item["id"]}
            };

            rpt.DataSource = SqlHelper.GetDataTable(sql, p);
            rpt.DataBind();

        }


    }
}
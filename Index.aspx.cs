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
    public partial class Index : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserIsValid"]==null)
            {
                Response.Redirect("Default.aspx");
            }
            //从数据库中查询通知公告
            string sql = "select top 5 * from Notice order by ID desc";
            try
            {
                DataTable dt = SqlHelper.GetDataTable(sql, null);
                //this.name = dt.Rows[0]["Name"].ToString();
                //this.content = dt.Rows[0]["Content"].ToString();
                //this.postTime = string.Format("{0:f}", dt.Rows[0]["PostTime"].ToString());
                
                this.rptNews.DataSource = dt;
                this.rptNews.DataBind();
            }
            catch (Exception)
            {

                throw;
            }

            //从数据库中查询软件工程简介内容
            string sqlCourse = "select count(*) from CourseIndro";
            int recordCount = int.Parse(SqlHelper.ExecuteScalar(sqlCourse, null).ToString());
            this.AspNetPager1.RecordCount = recordCount;
            this.AspNetPager1.PageSize = 2;


        }

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            int pageSize = 2;

            int currentPage = string.IsNullOrEmpty(Request["page"]) ? 1 : int.Parse(Request["page"]);

            this.BindDataToPage(pageSize, currentPage);
        }

        public void BindDataToPage(int pageSize, int currentPage)
        {
            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@PageSize", pageSize);
            p.Add("@CurrentPage", currentPage);

            string sql = @"select *
                                    from
                                    (
	                                    select row_number() over (order by id desc) AS RowNo,*
		                                from
                                            (
	                                            select *
	                                            from CourseIndro 
                                            )as t
	                                )AS t1
                                    where RowNo>@PageSize*(@CurrentPage-1) and RowNo<=@PageSize*@CurrentPage";

            this.rptIndro.DataSource = SqlHelper.GetDataTable(sql, p);
            this.rptIndro.DataBind();
        }
    }
}
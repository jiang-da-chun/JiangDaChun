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

    public partial class ShowProgenyList : System.Web.UI.Page
    {
        public bool UserType;
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
            string sql = "select count(*) from Progeny";
            int recordCount = int.Parse(SqlHelper.ExecuteScalar(sql, null).ToString());
            this.AspNetPager1.RecordCount = recordCount;
            this.AspNetPager1.CurrentPageIndex = currentPage;
            this.AspNetPager1.PageSize = 5;

            //设置Repeater数据控件的数据源
            sql = @"select *
                    from
                    (
	                    select ROW_NUMBER() OVER (ORDER BY ID DESC) AS RowNo,*
	                    from
	                    (
		                    select Progeny.ID,Title,PostTime,ViewCount,Content,TitleColor,NickName
		                    from Progeny,UserInfor
                            where Pupid= UserInfor.ID
	                     )as t1 
                    )AS t2
                    where RowNo>@pageSize*(@CurrentPage-1) and RowNo <=@pageSize*@CurrentPage;";

            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@pageSize", this.AspNetPager1.PageSize);
            p.Add("@CurrentPage", currentPage);

            DataTable dt = SqlHelper.GetDataTable(sql, p);
            this.rptTeaching.DataSource = dt;
            this.rptTeaching.DataBind();

        }
    }
}
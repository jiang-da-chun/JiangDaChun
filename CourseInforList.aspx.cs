﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using NetworkEducation.DBConnection;

namespace NetworkEducation.Admin
{
    public partial class CourseInforList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["AdminIsValid"] == null)
            {
                Response.Redirect("../Default.aspx");
            }

            if (!this.IsPostBack)
            {

                #region 第一次初始化网页的时候执行，把之前的输入或选择保存下来 查询时用的

                this.tbKey.Text = Request["key"];


                #endregion

                //获取行数据id的值，并对行数据的值进行删除操作
                if (!string.IsNullOrEmpty(Request["id"]))
                {
                    string sql = "delete from CourseIndro where id=@id";
                    Dictionary<string, object> p = new Dictionary<string, object>()
                    {
                        {"@id",Request["id"]}
                    };
                    SqlHelper.ExecuteNonQuery(sql, p);

                }




                Dictionary<string, object> parameter = new Dictionary<string, object>()
            {
                {"@key",this.tbKey.Text.Trim()}
            };

                string searchSql = @"select count(*)
                                from
                                (
	                                select *
	                                from CourseIndro
                                )as t
                                where (Title like '%'+@key+'%' or Author like '%'+@key+'%')";
                int recordCount = int.Parse(SqlHelper.ExecuteScalar(searchSql, parameter).ToString());
                this.AspNetPager1.RecordCount = recordCount; //告诉分页控件:总的有...条数据
                this.AspNetPager1.PageSize = string.IsNullOrEmpty(Request["pageSize"]) ? 2 : int.Parse(Request["pageSize"]);//告诉分页控件:每页有多少条数据

            }

        }

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            //取出分页的数据
            int pageSize = string.IsNullOrEmpty(Request["pageSize"]) ? 2 : int.Parse(Request["pageSize"]);

            int currentPage = string.IsNullOrEmpty(Request.QueryString["page"]) ? 1 : int.Parse(Request.QueryString["page"]);

            this.BindDataToPage(pageSize, currentPage);

        }

        public void BindDataToPage(int pageSize, int currentPage)
        {
            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@PageSize", pageSize);
            p.Add("@CurrentPage", currentPage);
            p.Add("@key", this.tbKey.Text.Trim());

            string sql = @"select *
                                    from
                                    (
	                                    select row_number() over (order by id desc) AS RowNo,*
		                                from
                                            (
	                                            select *
	                                            from CourseIndro 
                                            )as t
                                        where (Title like '%'+@key+'%' or Author like '%'+@key+'%')
	                                )AS t1
                                    where RowNo>@PageSize*(@CurrentPage-1) and RowNo<=@PageSize*@CurrentPage";

            this.rptMessage.DataSource = SqlHelper.GetDataTable(sql, p);
            this.rptMessage.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminList.aspx?key=" + this.tbKey.Text + "&page=1&pageSize=" + Request["pageSize"]);//重新去从0开始执行网页
        }

    }
}
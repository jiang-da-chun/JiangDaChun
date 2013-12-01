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

    public partial class CaseStudy : System.Web.UI.Page
    {
        public bool UserType;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserIsValid"] == null)
            {
                Response.Redirect("Default.aspx");
            }

            if (!this.IsPostBack)
            {

                #region 第一次初始化网页的时候执行，把之前的输入或选择保存下来

                this.tbKey.Text = Request["key"];

                if (Request["Develop"] != null)
                {
                    foreach (ListItem li in this.rblDevolopment.Items)
                    {
                        li.Selected = false;//清楚之前的默认选项
                        if (li.Value == Request["Develop"])
                        {
                            li.Selected = true;
                        }
                    }
                }

                #endregion

                Dictionary<string, object> parameter = new Dictionary<string, object>()
            {
                {"@key",this.tbKey.Text.Trim()}
            };

                string partSql = string.Empty;
                if (this.rblDevolopment.SelectedValue != string.Empty)
                {
                    partSql = " and Develop=@Develop ";
                    parameter.Add("@Develop", this.rblDevolopment.SelectedValue);
                }
                string searchSql = @"select count(*)
                                            from
                                            (
	                                            select *
	                                            from CaseAnalyse
                                            )as t
                                            where Title like '%'+@key+'%'" + partSql;
                int recordCount = int.Parse(SqlHelper.ExecuteScalar(searchSql, parameter).ToString());
                this.AspNetPager1.RecordCount = recordCount; //告诉分页控件:总的有...条数据
                this.AspNetPager1.PageSize = 5;

            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Response.Redirect("CaseStudy.aspx?Develop=" + this.rblDevolopment.SelectedValue + "&key=" + this.tbKey.Text + "&page=1");//重新去从0开始执行网页
        }

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            //取出分页的数据
            int pageSize = 5;

            int currentPage = string.IsNullOrEmpty(Request.QueryString["page"]) ? 1 : int.Parse(Request.QueryString["page"]);

            this.BindDataToPage(pageSize, currentPage);
        }

        public void BindDataToPage(int pageSize, int currentPage)
        {
            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@PageSize", pageSize);
            p.Add("@CurrentPage", currentPage);
            p.Add("@key", this.tbKey.Text.Trim());


            string partSql = string.Empty;
            if (this.rblDevolopment.SelectedValue != string.Empty)
            {
                partSql = " and Develop=@Develop ";
                p.Add("@Develop", this.rblDevolopment.SelectedValue);
            }

            string sql = @"select *
                                    from
                                    (
	                                    select row_number() over (order by id desc) AS RowNo,*
		                                from
                                            (
	                                            select CaseAnalyse.ID,Develop,Title,PostTime,ViewCount,Content,TitleColor,NickName
		                                        from CaseAnalyse,UserInfor
                                                where Cupid= UserInfor.ID
                                            )as t
                                        where (Title like '%'+@key+'%')" + partSql + @"
	                                )AS t1
                                    where RowNo>@PageSize*(@CurrentPage-1) and RowNo<=@PageSize*@CurrentPage";

            this.rptCase.DataSource = SqlHelper.GetDataTable(sql, p);
            this.rptCase.DataBind();


        }
       
    }
}
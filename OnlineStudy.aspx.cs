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
    public partial class OnlineStudy : System.Web.UI.Page
    {

        public string StudyContent;
        public string CaseContent;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UserIsValid"] == null)
            {
                Response.Redirect("Default.aspx");
            }

            string sql = "select top 1 * from StudyIndro order by id desc";
            DataTable dt = SqlHelper.GetDataTable(sql, null);
            StudyContent = dt.Rows[0]["Content"].ToString();

            sql = "select top 1 * from CaseIndro order by id desc";
            dt = SqlHelper.GetDataTable(sql, null);
            CaseContent = dt.Rows[0]["Content"].ToString();
        }
    }
}
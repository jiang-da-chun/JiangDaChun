using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NetworkEducation.DBConnection;

namespace NetworkEducation.Admin
{
    public partial class AddStudyIndro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


            if (Session["AdminIsValid"] == null)
            {
                Response.Redirect("../Default.aspx");
            }

        }

        protected void submit_Click(object sender, EventArgs e)
        {
            if (this.IsValid==false)
            {
                return;
            }

            //数据入库
            string sql = @"INSERT INTO [StudyIndro]
                                   ([Content])
                             VALUES
                                   (@Content)";
            Dictionary<string, object> p = new Dictionary<string, object>();
            p.Add("@Content",this.tbContent.Text);
           


            try
            {
                SqlHelper.ExecuteNonQuery(sql, p);
               
                this.tbContent.Text=string.Empty;
            }
            catch (Exception)
            {

                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "55", "$.ligerDialog.error('数据入库失败！');", true);
            }

        }

    }
}
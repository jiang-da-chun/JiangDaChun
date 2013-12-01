using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NetworkEducation.Admin
{
    public partial class Frame : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["AdminIsValid"] == null)
            {
                Response.Redirect("../Default.aspx");
            }

        }
    }
}
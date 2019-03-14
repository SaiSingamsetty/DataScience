using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bloggered.Profiles
{
    public partial class DashBoard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string userid = (Request.Cookies["userid"].Value!=null ? Request.Cookies["userid"].Value : "");
            Label1.Text = userid;
        }
    }
}
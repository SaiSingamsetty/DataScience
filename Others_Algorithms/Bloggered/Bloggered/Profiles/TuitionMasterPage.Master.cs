using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bloggered.Models;
using System.Web.Security;

namespace Bloggered
{
    public partial class TuitionMasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string userid = (Request.Cookies["userid"].Value != null ? Request.Cookies["userid"].Value : "");
            Label1.Text = userid;
            
        }

        protected void lnkProfile_Click(object sender, EventArgs e)
        {

            Response.Redirect("~/Profiles/MyProfile.aspx?UserID="+Label1.Text);

        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            // LOGOUT
            FormsAuthentication.SignOut();
            Session.Clear();
            Session.RemoveAll();
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }

        protected void lnkSuggestions_Click(object sender, EventArgs e)
        {
            // Find suggestions
            Response.Redirect("~/Profiles/Suggestions.aspx?UserID=" + Label1.Text);
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            // Dashboard
            Response.Redirect("~/Profiles/DashBoard.aspx");
        }
    }
}
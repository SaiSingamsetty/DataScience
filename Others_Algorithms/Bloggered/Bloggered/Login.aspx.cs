using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bloggered.Models;
using System.ComponentModel;

namespace Bloggered
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                if (Request.Cookies["userid"] != null)
                    TextBox1.Text = Request.Cookies["userid"].Value;

                if (Request.Cookies["pwd"] != null)
                    TextBox2.Attributes.Add("value", Request.Cookies["pwd"].Value);

            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string temp = TextBox1.Text;

            dynamic userid;

            if (temp.Length > 5)
            {
                userid = TextBox1.Text;
            }
            else
            {
                userid = Convert.ToInt32(TextBox1.Text);
            }
            string password = TextBox2.Text;

            User user = new Models.User(userid, password);

            int tempid = user.IsUser(userid, password);

            if (tempid > 0)
            {
                Response.Cookies["userid"].Value = TextBox1.Text;
                Response.Cookies["pwd"].Value = TextBox2.Text;
                Response.Cookies["userid"].Expires = DateTime.Now.AddDays(15);
                Response.Cookies["pwd"].Expires = DateTime.Now.AddDays(15);

                HttpCookie cookie = new HttpCookie("userid");
                cookie.Value = user.IsUser(userid, password).ToString();
                Response.Cookies.Add(cookie);

                FormsAuthentication.RedirectFromLoginPage(TextBox1.Text, true);
            }
            else
            {
                Label1.Text = "Credentials are incorrect. Please check.";
                Label1.ForeColor = System.Drawing.Color.Red;
            }
            
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            // Navigate to Register Page
            Response.Redirect("~/RegistrationFold/RegisterPage.aspx");
        }

        
    }
}
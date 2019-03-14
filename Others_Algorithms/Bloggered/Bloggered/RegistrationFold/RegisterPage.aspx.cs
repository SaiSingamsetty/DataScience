using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bloggered
{
    public partial class RegisterPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //RegisterasStudent
            Response.Redirect("~/RegistrationFold/RegisterStudent.aspx");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            //RegisterasTutor
            Response.Redirect("~/RegistrationFold/RegisterTutor.aspx");
        }
    }
}
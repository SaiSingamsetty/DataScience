using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bloggered.Models;

namespace Bloggered
{
    public partial class RegisterTutor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            // Create a Tutor with ROLE : TUTOR
            try
            {
                string username = txtUserName.Text;
                string password = txtPassword.Text;
                string cellnumber = txtCellNumber.Text;
                int age = Convert.ToInt32(txtAge.Text);
                int exp = Convert.ToInt32(txtExperience.Text);
                string recentdegree = txtRecentDegree.Text;
                string recentinstitute = txtRecentInstitute.Text;
                string description = txtDescription.Text;
                string address = txtAddress.Text;
                
                bool demo = RadioButtonList1.SelectedValue == "Yes" ? true : false;

                User tutor = new Models.User();
                tutor.UserName = username;
                tutor.Password = password;
                tutor.CellNumber = cellnumber;
                tutor.Age = age;
                tutor.Experience = exp;
                tutor.RecentDegree = recentdegree;
                tutor.Role = "tutor";
                tutor.RecentInstitute = recentinstitute;
                tutor.Description = description;
                tutor.Address = address;

                tutor.DemoClassCharged = Convert.ToBoolean(demo);

                using (TuitionContext tc = new TuitionContext())
                {
                    tc.Users.Add(tutor);
                    tc.SaveChanges();
                }
                //TODO: Create success page
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Added Successfully')", true);
                Response.Redirect("~/Login.aspx");
            }
            catch (Exception x)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Exception. Please check!')", true);
            }
        }
    }
}
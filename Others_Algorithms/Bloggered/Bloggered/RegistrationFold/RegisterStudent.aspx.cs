using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bloggered.Models;

namespace Bloggered
{
    public partial class RegisterStudent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            // Add the student with ROLE: Student
            try
            {
                string username = txtUserName.Text;
                string password = txtPassword.Text;
                string cellnumber = txtCellNumber.Text;
                int age = Convert.ToInt32(txtAge.Text);
                string classstudying = txtRecentDegree.Text;
                string school = txtRecentInstitute.Text;
                string requirement = txtDescription.Text;
                string address = txtAddress.Text;
                string board = txtBoard.Text;
                bool demo = RadioButtonList1.SelectedValue == "Yes" ? true : false;

                User student = new Models.User();
                student.UserName = username;
                student.Password = password;
                student.CellNumber = cellnumber;
                student.Age = age;
                student.RecentDegree = classstudying;
                student.Role = "student";
                student.RecentInstitute = school;
                student.Description = requirement;
                student.Address = address;
                student.BoardOfEducation = board;
                student.DemoClassCharged = Convert.ToBoolean(demo);

                using (TuitionContext tc = new TuitionContext())
                {
                    tc.Users.Add(student);
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
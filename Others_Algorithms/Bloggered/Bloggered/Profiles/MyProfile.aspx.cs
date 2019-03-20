using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bloggered.Models;

namespace Bloggered.Profiles
{
    public partial class MyProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Label2.Text = Request.QueryString["UserID"] != null ? Request.QueryString["UserID"] : "";
            lblName.Text = "";
            int userid = Convert.ToInt32(Label2.Text);
            PopulateData(userid);
            lblForExperience.Visible = false;
            lblExperience.Visible = false;
            lblBoard.Visible = false;
            lblForBoard.Visible = false;
        }

        private void PopulateData(int userid)
        {
            using (TuitionContext tc = new TuitionContext())
            {
                User temp_user = new User();
                temp_user = tc.Users.SingleOrDefault(x => x.UserId == userid);
                if (temp_user != null)
                {
                    lblName.Text = temp_user.UserName;
                    lblID.Text = temp_user.UserId.ToString();
                    lblContacts.Text = temp_user.CellNumber + ", (" + temp_user.Address + ") ";
                    lblAge.Text = temp_user.Age.ToString();
                    
                    if(temp_user.Role.ToLower() == "tutor")
                    {
                        lblForExperience.Visible = true;
                        lblExperience.Visible = true;
                        lblExperience.Text = temp_user.Experience.ToString();
                        lblForRecentDegree.Text = "Recent Degree:";
                        lblForRecentInst.Text = "Recent Institute you have studied:";
                        lblForDescription.Text = "Describe Yourself:";
                        lblForDemo.Text = "Is Demo class charged?";
                    }
                    if (temp_user.Role.ToLower() == "student")
                    {
                        lblForExperience.Visible = false;
                        lblExperience.Visible = false;
                        lblForRecentDegree.Text = "Class Studying:";
                        lblForRecentInst.Text = "School/College:";
                        lblForDescription.Text = "Requirement in words:";
                        lblForDemo.Text = "Is Demo class needed?";
                        lblForBoard.Visible = true;
                        lblBoard.Visible = true;
                        lblForBoard.Text = "Board of Education:";
                        lblBoard.Text = temp_user.BoardOfEducation;
                    }

                    lblRecentDegree.Text = temp_user.RecentDegree;
                    lblRecentInst.Text = temp_user.RecentInstitute;
                    lblDescription.Text = temp_user.Description;
                    lblDemo.Text = temp_user.DemoClassCharged.ToString();


                }
            }
        }
    }
}
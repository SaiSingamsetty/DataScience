using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bloggered.Models;

namespace Bloggered.Profiles
{
    public partial class Details : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Label1.Text = Request.QueryString["UserID"] != null ? Request.QueryString["UserID"] : null;

            PopulateData(Label1.Text);
        }

        private void PopulateData(string useridstr)
        {
            int userid = Convert.ToInt32(useridstr);
            using(TuitionContext tc = new TuitionContext())
            {
                var temp_user = tc.Users.FirstOrDefault(x => x.UserId == userid);
                if (temp_user != null)
                {
                    lblName.Text = temp_user.UserName;
                    
                    lblContacts.Text = temp_user.CellNumber + ", (" + temp_user.Address + ") ";
                    lblAge.Text = temp_user.Age.ToString();
                    lbluser.Text = temp_user.Role;
                    if (temp_user.Role.ToLower() == "tutor")
                    {
                        
                        lblForExperience.Visible = true;
                        lblExperience.Visible = true;
                        lblExperience.Text = temp_user.Experience.ToString();
                        lblForRecentDegree.Text = "Recent Degree:";
                        lblForRecentInst.Text = "Recent Institute:";
                        lblForDescription.Text = "Summary:";
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
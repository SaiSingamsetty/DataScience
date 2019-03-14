using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bloggered.Models;
using System.Web.Services;

namespace Bloggered.Profiles
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public partial class Suggestions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Label2.Text = Request.QueryString["UserID"] != null ? Request.QueryString["UserID"] : "";
           // PopulateData(Convert.ToInt32(Label2.Text));
        }

        [WebMethod]
        public static string PopulateData(int userid)
        {
            //int userid = 1002;
            using (TuitionContext tc = new TuitionContext())
            {
                var suggestions = tc.Users.Where(x => x.Role != (tc.Users.FirstOrDefault(y => y.UserId == userid).Role)).ToList();

                string concatenated_suggestions = "<br/><br/>";

                for (int i = 0; i < suggestions.Count; i++)
                {
                    concatenated_suggestions = concatenated_suggestions + "<div><a href='#' onclick='pop(event)'>" + suggestions[i].UserId + "</a> <span> " + suggestions[i].UserName + "</span><br/><span>" + suggestions[i].Description + "</span></div><br/><hr>";
                    //Details.aspx
                }
                if (concatenated_suggestions != string.Empty)
                    return concatenated_suggestions;
                else
                    return "No Suggestions!";
            }
        }

        protected void HiddenField1_ValueChanged(object sender, EventArgs e)
        {
            Session["detailsid"] = HiddenField1.Value;
        }
    }
}
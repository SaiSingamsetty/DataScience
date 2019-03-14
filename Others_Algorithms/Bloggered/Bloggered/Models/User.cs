using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Bloggered.Models
{
    public class User
    {
        public int UserId { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string Role { get; set; }
        public string CellNumber { get; set; }
        public int Age { get; set; }
        public int Experience { get; set; }
        public string RecentDegree { get; set; }
        public string RecentInstitute { get; set; }
        public string Description { get; set; }
        public string Address { get; set; }
        public bool DemoClassCharged { get; set; }
        public string BoardOfEducation { get; set; }

        public User(string un, string pw)
        {
            this.CellNumber = un;
            this.Password = pw;
        }
        public User(int un, string pw)
        {
            this.UserId = un;
            this.Password = pw;
        }

        public User()
        {

        }
        
        public int IsUser(int un, string pw)
        {
            using (TuitionContext tc = new TuitionContext())
            {
                //Not so efficient way. It creates a list with values of True/false.
                //var user = tc.Users.Select(x => x.UserName == un && x.Password == pw).ToList();
                // if(//user.Count() > 0 && user.Contains(true))

                var test = tc.Users.SingleOrDefault(x => x.UserId == un && x.Password == pw);
                // SingleOrDefault returns the whole User object or NULL 
                
                if (test != null)
                {
                    return test.UserId;
                }
                else
                {
                    return 0;
                }
                
            }
        }
        public int IsUser(string un, string pw)
        {
            using (TuitionContext tc = new TuitionContext())
            {
                //Not so efficient way. It creates a list with values of True/false.
                //var user = tc.Users.Select(x => x.UserName == un && x.Password == pw).ToList();
                // if(//user.Count() > 0 && user.Contains(true))

                var test = tc.Users.SingleOrDefault(x => x.CellNumber == un && x.Password == pw);
                // SingleOrDefault returns the whole User object or NULL 

                if (test != null)
                {
                    return test.UserId;
                }
                else
                {
                    return 0;
                }

            }
        }
    }
    
}
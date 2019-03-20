using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bloggered.Models
{
    public class TutorSubject
    {
        public int Id { get; set; }
        public string tsubject { get; set; }
        public List<User> Users { get; set; }
    }
}
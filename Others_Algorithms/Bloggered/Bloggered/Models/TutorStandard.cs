using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Bloggered.Models;

namespace Bloggered.Models
{
    public class TutorStandard
    {
        public int Id { get; set; }
        public string tclass { get; set; }
        public List<User> Users { get; set; } 

    }
}
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace Bloggered.Models
{
    public class TuitionContext : DbContext
    {
        public DbSet<User> Users { get; set; }
        public DbSet<TutorStandard> TutorStandards { get; set; }
        public DbSet<TutorSubject> TutorSubjects { get; set; } 

    }
}
namespace Bloggered.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class UpdatestoUser : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Users", "Role", c => c.String());
            AddColumn("dbo.Users", "CellNumber", c => c.String());
            AddColumn("dbo.Users", "Age", c => c.Int(nullable: false));
            AddColumn("dbo.Users", "Experience", c => c.Int(nullable: false));
            AddColumn("dbo.Users", "RecentDegree", c => c.String());
            AddColumn("dbo.Users", "RecentInstitute", c => c.String());
            AddColumn("dbo.Users", "Description", c => c.String());
            AddColumn("dbo.Users", "Address", c => c.String());
            AddColumn("dbo.Users", "DemoClassCharged", c => c.Boolean(nullable: false));
            AddColumn("dbo.Users", "BoardOfEducation", c => c.String());
        }
        
        public override void Down()
        {
            DropColumn("dbo.Users", "BoardOfEducation");
            DropColumn("dbo.Users", "DemoClassCharged");
            DropColumn("dbo.Users", "Address");
            DropColumn("dbo.Users", "Description");
            DropColumn("dbo.Users", "RecentInstitute");
            DropColumn("dbo.Users", "RecentDegree");
            DropColumn("dbo.Users", "Experience");
            DropColumn("dbo.Users", "Age");
            DropColumn("dbo.Users", "CellNumber");
            DropColumn("dbo.Users", "Role");
        }
    }
}

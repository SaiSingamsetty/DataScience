namespace Bloggered.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class UserSubjectsClasses : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.TutorStandards",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        tclass = c.String(),
                    })
                .PrimaryKey(t => t.Id);
            
            AddColumn("dbo.Users", "TutorStandard_Id", c => c.Int());
            CreateIndex("dbo.Users", "TutorStandard_Id");
            AddForeignKey("dbo.Users", "TutorStandard_Id", "dbo.TutorStandards", "Id");
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Users", "TutorStandard_Id", "dbo.TutorStandards");
            DropIndex("dbo.Users", new[] { "TutorStandard_Id" });
            DropColumn("dbo.Users", "TutorStandard_Id");
            DropTable("dbo.TutorStandards");
        }
    }
}

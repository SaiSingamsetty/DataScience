namespace Bloggered.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class UserSubStand : DbMigration
    {
        public override void Up()
        {
            DropForeignKey("dbo.Users", "TutorStandard_Id", "dbo.TutorStandards");
            DropIndex("dbo.Users", new[] { "TutorStandard_Id" });
            CreateTable(
                "dbo.TutorSubjects",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        tsubject = c.String(),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.UserTutorStandards",
                c => new
                    {
                        User_UserId = c.Int(nullable: false),
                        TutorStandard_Id = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.User_UserId, t.TutorStandard_Id })
                .ForeignKey("dbo.Users", t => t.User_UserId, cascadeDelete: true)
                .ForeignKey("dbo.TutorStandards", t => t.TutorStandard_Id, cascadeDelete: true)
                .Index(t => t.User_UserId)
                .Index(t => t.TutorStandard_Id);
            
            CreateTable(
                "dbo.TutorSubjectUsers",
                c => new
                    {
                        TutorSubject_Id = c.Int(nullable: false),
                        User_UserId = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.TutorSubject_Id, t.User_UserId })
                .ForeignKey("dbo.TutorSubjects", t => t.TutorSubject_Id, cascadeDelete: true)
                .ForeignKey("dbo.Users", t => t.User_UserId, cascadeDelete: true)
                .Index(t => t.TutorSubject_Id)
                .Index(t => t.User_UserId);
            
            DropColumn("dbo.Users", "TutorStandard_Id");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Users", "TutorStandard_Id", c => c.Int());
            DropForeignKey("dbo.TutorSubjectUsers", "User_UserId", "dbo.Users");
            DropForeignKey("dbo.TutorSubjectUsers", "TutorSubject_Id", "dbo.TutorSubjects");
            DropForeignKey("dbo.UserTutorStandards", "TutorStandard_Id", "dbo.TutorStandards");
            DropForeignKey("dbo.UserTutorStandards", "User_UserId", "dbo.Users");
            DropIndex("dbo.TutorSubjectUsers", new[] { "User_UserId" });
            DropIndex("dbo.TutorSubjectUsers", new[] { "TutorSubject_Id" });
            DropIndex("dbo.UserTutorStandards", new[] { "TutorStandard_Id" });
            DropIndex("dbo.UserTutorStandards", new[] { "User_UserId" });
            DropTable("dbo.TutorSubjectUsers");
            DropTable("dbo.UserTutorStandards");
            DropTable("dbo.TutorSubjects");
            CreateIndex("dbo.Users", "TutorStandard_Id");
            AddForeignKey("dbo.Users", "TutorStandard_Id", "dbo.TutorStandards", "Id");
        }
    }
}

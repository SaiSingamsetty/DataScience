<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Bloggered.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 150px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
       <table>
           <tr>
               <td class="auto-style1">User ID:</td>
               <td><asp:TextBox ID="TextBox1" runat="server" placeholder="Mobile or User ID"></asp:TextBox></td>
           </tr>
           <tr>
               <td class="auto-style1">Password:</td>
               <td><asp:TextBox ID="TextBox2" runat="server"></asp:TextBox></td>
           </tr>
           <tr>
               
               <td class="auto-style1">

               </td>
               <td>
                   <asp:Button ID="Button1" runat="server" Text="Login" OnClick="Button1_Click" />
               </td>
               <td>
                   <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">New ? Register Here</asp:LinkButton>
               </td>
           </tr>
           
                   
               
       </table>
        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
    </div>
        
        
    </form>
</body>
</html>


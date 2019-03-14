<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterStudent.aspx.cs" Inherits="Bloggered.RegisterStudent" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table>
        <tr>
            <td>
                Name:
            </td>
            <td>
                <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Password:
            </td>
            <td>
                <asp:TextBox ID="txtPassword" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Re-enter Password:
            </td>
            <td>
                <asp:TextBox ID="txtRePassword" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Mobile Number:
            </td>
            <td>
                <asp:TextBox ID="txtCellNumber" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Age:
            </td>
            <td>
                <asp:TextBox ID="txtAge" runat="server"></asp:TextBox>
            </td>
        </tr>
        
        <tr>
            <td>
                Class you are studying:
            </td>
            <td>
                <asp:TextBox ID="txtRecentDegree" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Institute/ School:
            </td>
            <td>
                <asp:TextBox ID="txtRecentInstitute" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Requirement in words:
            </td>
            <td>
                <asp:TextBox ID="txtDescription" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Area you are located:
            </td>
            <td>
                <asp:TextBox ID="txtAddress" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Is Demo Class Needed ?
            </td>
            <td>
                <asp:RadioButtonList ID="RadioButtonList1" runat="server">
                    <asp:ListItem>Yes</asp:ListItem>
                    <asp:ListItem>No</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td>
                Board of Education you are in:
            </td>
            <td>
                <asp:TextBox ID="txtBoard" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                
            </td>
            <td>
                <asp:Button ID="Button1" runat="server" Text="Create" OnClick="Button1_Click" />
            </td>
        </tr>
    </table>
    </div>
    </form>
</body>
</html>

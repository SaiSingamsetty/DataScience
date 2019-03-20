<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterTutor.aspx.cs" Inherits="Bloggered.RegisterTutor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#btnSub').click(function () {
                AddText();
            });

            $(".cancel").click(function () {
                alert('Hi');
            })

            function AddText() {
                var temp = $("#txtSubjects").val();
                $('<span class=subject>' + temp + '</span><span class=cancel>X</span> ').appendTo('#divSub');
                $("#txtSubjects").val(' ');
            }
        })
    </script>
    <style>
        .subject{
            padding:1px;
        }
        .cancel{
            padding:4px;
            color:red;
            cursor:pointer;
        }
    </style>
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
                Experience (in years):
            </td>
            <td>
                <asp:TextBox ID="txtExperience" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Most Recent Degree:
            </td>
            <td>
                <asp:TextBox ID="txtRecentDegree" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Most Recent Institute:
            </td>
            <td>
                <asp:TextBox ID="txtRecentInstitute" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Describe yourself:
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
                Is Demo Class charged ?
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
                Subjects you can teach:
            </td>
            <td>
                
                <asp:TextBox ID="txtSubjects" runat="server" Width="125px"></asp:TextBox>&nbsp;&nbsp;&nbsp;
                <input id="btnSub" type="button" value="Add" /><br />
                
            </td>
            
        </tr>
        <tr>
            <td>

            </td>
            <td>
                <div id="divSub">
                </div>
            </td>
        </tr>
        <tr>
            <td>
                
            </td>
            <td>
                <asp:Button ID="Button1" runat="server" Text="Create" OnClick="Button1_Click" Height="29px" Width="96px" />
            </td>
        </tr>
    </table>
    </div>
    </form>
</body>
</html>

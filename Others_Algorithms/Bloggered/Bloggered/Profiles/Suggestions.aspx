<%@ Page Title="" Language="C#" MasterPageFile="~/Profiles/TuitionMasterPage.Master" AutoEventWireup="true" CodeBehind="Suggestions.aspx.cs" Inherits="Bloggered.Profiles.Suggestions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Label ID="Label2" runat="server" Visible="False"></asp:Label>
    <asp:HiddenField ID="HiddenField1" runat="server" OnValueChanged="HiddenField1_ValueChanged" />
    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <div id="suggestionsdiv">
        
        
    </div>
    <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
    <script src="../scripts/TempJS.js"></script>
    <script type="text/javascript">
       function pop(e) {
           alert(e.target.text);
           var x = e.target.text;
                document.getElementById("#lblDet").value = x;
                alert('HI');
            }
        
    </script>
</asp:Content>

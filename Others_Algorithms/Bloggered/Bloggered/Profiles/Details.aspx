<%@ Page Title="" Language="C#" MasterPageFile="~/Profiles/TuitionMasterPage.Master" AutoEventWireup="true" CodeBehind="Details.aspx.cs" Inherits="Bloggered.Profiles.Details" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    Full details of the <asp:Label ID="lbluser" runat="server" Text=""></asp:Label>:
    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
    <br /><br />
    <table>
        <tr>
            <td>
                Name:
            </td>
            <td>
                <asp:Label ID="lblName" runat="server" Text="Label"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Contact Details:
            </td>
            <td>
                <asp:Label ID="lblContacts" runat="server" Text="Label"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Age:
            </td>
            <td>
                <asp:Label ID="lblAge" runat="server" Text="Label"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style3">
                <asp:label ID="lblForExperience" runat="server" text="Experience:"></asp:label>
            </td>
            <td class="auto-style2">
                <asp:label ID="lblExperience" runat="server" text=""></asp:label>
            </td>
        </tr>
        <tr>
            <td class="auto-style3">
                <asp:label ID="lblForRecentDegree" runat="server" text=""></asp:label>
            </td>
             <td class="auto-style2">
                <asp:label ID="lblRecentDegree" runat="server" text=""></asp:label>
            </td>
        </tr>
        <tr>
            <td class="auto-style3">
                <asp:label ID="lblForRecentInst" runat="server" text=""></asp:label>
            </td>
             <td class="auto-style2">
                <asp:label ID="lblRecentInst" runat="server" text=""></asp:label>
            </td>
        </tr>
         <tr>
            <td class="auto-style3">
                <asp:label ID="lblForBoard" runat="server" text=""></asp:label>
            </td>
            <td class="auto-style2">
                <asp:label ID="lblBoard" runat="server" text=""></asp:label>
            </td>
        </tr>
        <tr>
            <td class="auto-style3">
                <asp:label ID="lblForDescription" runat="server" text=""></asp:label>
            </td>
             <td class="auto-style2">
                <asp:label ID="lblDescription" runat="server" text=""></asp:label>
            </td>
        </tr>
        <tr>
            <td class="auto-style3">
                <asp:label ID="lblForDemo" runat="server" text=""></asp:label>
            </td>
            <td class="auto-style2">
                <asp:label ID="lblDemo" runat="server" text=""></asp:label>
            </td>
        </tr>
       
    </table>

</asp:Content>

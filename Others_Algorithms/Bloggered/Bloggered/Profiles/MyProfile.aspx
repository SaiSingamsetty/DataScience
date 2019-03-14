<%@ Page Title="" Language="C#" MasterPageFile="~/Profiles/TuitionMasterPage.Master" AutoEventWireup="true" CodeBehind="MyProfile.aspx.cs" Inherits="Bloggered.Profiles.MyProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style2 {
        width: 261px;
    }
    .auto-style3 {
        width: 231px;
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <asp:Label ID="Label2" runat="server" Visible="False"></asp:Label>
    <br />
    <br />
    <table>
        <tr>
            <td class="auto-style3">
                Name:
            </td>
            <td class="auto-style2">
                <asp:label ID="lblName" runat="server" text=""></asp:label>
            </td>
        </tr>
        <tr>
            <td class="auto-style3">
                Your ID:
            </td>
            <td class="auto-style2">
                <asp:label ID="lblID" runat="server" text=""></asp:label>
            </td>
        </tr>
        <tr>
            <td class="auto-style3">
                Contact Details:
            </td>
            <td class="auto-style2">
                <asp:label ID="lblContacts" runat="server" text=""></asp:label>
            </td>
        </tr>
        <tr>
            <td class="auto-style3">
                Age:
            </td>
            <td class="auto-style2">
                <asp:label ID="lblAge" runat="server" text=""></asp:label>
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

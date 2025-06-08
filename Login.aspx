<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="BookSwapVersion2.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <h2 class="mb-4">Log In</h2>

        <asp:Label ID="lblRedirectMessage" runat="server" ForeColor="Red" Font-Bold="true" />
        <asp:Label ID="lblLoginMsg" runat="server" ForeColor="Red" /><br />

        <div class="mb-3">
            <asp:TextBox ID="txtEmailLogin" runat="server" CssClass="form-control" Placeholder="Email" />
        </div>

        <div class="mb-3">
            <asp:TextBox ID="txtPassLogin" runat="server" TextMode="Password" CssClass="form-control" Placeholder="Password" />
        </div>

        <asp:Button ID="btnLogin" runat="server" Text="Log in" OnClick="btnLogin_Click" CssClass="btn btn-success" />
    </div>
</asp:Content>

<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="BookSwapVersion2.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <h2 class="mb-4">User Registration</h2>

        <asp:Label ID="lblMessage" runat="server" ForeColor="Red" /><br />

        <!-- Username -->
        <div class="mb-3">
            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" Placeholder="Username" />
            <asp:RequiredFieldValidator ID="rfvUser" runat="server" ControlToValidate="txtUsername" ErrorMessage="* required" ForeColor="Red" Display="Dynamic" />
        </div>

        <!-- Email -->
        <div class="mb-3">
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Email" />
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="* required" ForeColor="Red" Display="Dynamic" />
            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                ErrorMessage="* invalid" ForeColor="Red" Display="Dynamic" />
        </div>

        <!-- Location / City -->
        <div class="mb-3">
            <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" Placeholder="Location / City" />
            <asp:RequiredFieldValidator ID="rfvLocation" runat="server" ControlToValidate="txtLocation" ErrorMessage="* required" ForeColor="Red" Display="Dynamic" />
        </div>

        <!-- Phone Number -->
        <div class="mb-3">
            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" Placeholder="Phone Number" />
            <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="* required" ForeColor="Red" Display="Dynamic" />
            <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="txtPhone"
                ValidationExpression="^\d{7,15}$"
                ErrorMessage="* invalid phone" ForeColor="Red" Display="Dynamic" />
        </div>

        <!-- Date of Birth -->
        <div class="mb-3">
            <asp:TextBox ID="txtDOB" runat="server" TextMode="Date" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvDOB" runat="server" ControlToValidate="txtDOB" ErrorMessage="* required" ForeColor="Red" Display="Dynamic" />
        </div>

        <!-- Password -->
        <div class="mb-3">
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" Placeholder="Password" />
            <asp:RequiredFieldValidator ID="rfvPass" runat="server" ControlToValidate="txtPassword" ErrorMessage="* required" ForeColor="Red" Display="Dynamic" />
        </div>

        <asp:ValidationSummary ID="vsReg" runat="server" ForeColor="Red" ShowSummary="True" />

        <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" CssClass="btn btn-primary" />

        <div class="mt-3">
            Already have an account? <a href="Login.aspx">Log in</a>
        </div>
    </div>
</asp:Content>

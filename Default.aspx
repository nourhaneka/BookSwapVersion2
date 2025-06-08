<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BookSwapVersion2._Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="text-center mt-5">
        <div class="text-center">
    <h1 class="display-4">Welcome to Book Swap Community!</h1>
</div>
        <asp:GridView ID="gvSearchResults" runat="server" CssClass="table table-bordered w-75 mx-auto" AutoGenerateColumns="true" Visible="false"></asp:GridView>

        <div class="row mt-5">
            <div class="col-md-4">
                <a href="Books.aspx" class="btn btn-success w-100 p-4"> Add Book</a>
            </div>
            <div class="col-md-4">
                <a href="Manage.aspx" class="btn btn-warning w-100 p-4"> Manage Books</a>
            </div>
            <div class="col-md-4">
                <a href="Explore.aspx" class="btn btn-info w-100 p-4"> Explore Books</a>
            </div>
        </div>
    </div>
</asp:Content>

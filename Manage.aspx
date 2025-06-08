<%@ Page Title="Manage Books" MasterPageFile="~/Site.Master" Language="C#" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="BookSwapVersion2.Manage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Manage Your Books</h2>
    <br />
    <asp:Label ID="NotificationLabel" runat="server" CssClass="alert alert-info" />
    <br /><br />
    <asp:GridView ID="BooksGrid" runat="server" AutoGenerateColumns="False" DataKeyNames="BookID"
        OnRowEditing="BooksGrid_RowEditing" OnRowUpdating="BooksGrid_RowUpdating"
        OnRowCancelingEdit="BooksGrid_RowCancelingEdit" OnRowDeleting="BooksGrid_RowDeleting"
        OnRowDataBound="BooksGrid_RowDataBound" CssClass="table table-bordered">
        <Columns>
            <asp:BoundField DataField="BookID" HeaderText="Book ID" ReadOnly="true" />
            <asp:BoundField DataField="Title" HeaderText="Title" />
            <asp:BoundField DataField="Author" HeaderText="Author" />
            <asp:TemplateField HeaderText="Genre">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlGenre" runat="server">
                        <asp:ListItem Text="Romance" />
                        <asp:ListItem Text="Horror" />
                        <asp:ListItem Text="Mystery" />
                        <asp:ListItem Text="Fantasy" />
                        <asp:ListItem Text="History" />
                        <asp:ListItem Text="Biography" />
                        <asp:ListItem Text="Thriller" />
                        <asp:ListItem Text="Fiction" />

                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <%# Eval("Genre") %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" />
        </Columns>
    </asp:GridView>
</asp:Content>

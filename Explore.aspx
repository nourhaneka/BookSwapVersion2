<%@ Page Title="Explore Books" MasterPageFile="~/Site.Master" Language="C#" AutoEventWireup="true" CodeBehind="Explore.aspx.cs" Inherits="BookSwapVersion2.Explore" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Explore Books</h2>
    <asp:GridView ID="ExploreGrid" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered">
        <Columns>
            <asp:BoundField DataField="Title" HeaderText="Title" />
            <asp:BoundField DataField="Author" HeaderText="Author" />
            <asp:BoundField DataField="Genre" HeaderText="Genre" />
            <asp:BoundField DataField="Year" HeaderText="Year" />
            <asp:BoundField DataField="Condition" HeaderText="Condition" />
            <asp:BoundField DataField="Description" HeaderText="Description" />
            <asp:TemplateField HeaderText="Request">
                <ItemTemplate>
                    <asp:Button ID="btnRequest" runat="server" Text="Request" Enabled="false" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>

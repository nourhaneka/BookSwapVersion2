<%@ Page Title="Books"
         Language="C#"
         MasterPageFile="~/Site.master"
         AutoEventWireup="true"
         CodeBehind="Books.aspx.cs"
         Inherits="BookSwapVersion2.Books" %>

<asp:Content ID="ContentBooks" ContentPlaceHolderID="MainContent" runat="server">

    <h2 class="mb-4">Add a Book</h2>

    <!-- MESSAGE -->
    <asp:Label ID="lblMessage" runat="server" CssClass="fw-bold" />

    <!-- ──────────────────────────────── ADD-BOOK FORM ──────────────────────────────── -->
    <div class="card p-3 mb-4">
        <!-- Title -->
        <asp:TextBox ID="txtTitle" runat="server"
                     CssClass="form-control mb-2"
                     Placeholder="Title" />
        <asp:RequiredFieldValidator ID="rfvTitle" runat="server"
            ControlToValidate="txtTitle" ErrorMessage="* title required"
            ForeColor="Red" Display="Dynamic" />

        <!-- Author -->
        <asp:TextBox ID="txtAuthor" runat="server"
                     CssClass="form-control my-2"
                     Placeholder="Author" />
        <asp:RequiredFieldValidator ID="rfvAuthor" runat="server"
            ControlToValidate="txtAuthor" ErrorMessage="* author required"
            ForeColor="Red" Display="Dynamic" />

        <!-- Genre dropdown -->
        <asp:DropDownList ID="ddlGenre" runat="server" AutoPostBack="true"
                          OnSelectedIndexChanged="ddlGenre_SelectedIndexChanged"
                          CssClass="form-select my-2">
            <asp:ListItem Text="Select Genre" Value="" />
            <asp:ListItem Text="Fiction" />
            <asp:ListItem Text="Mystery" />
            <asp:ListItem Text="Sci-Fi" />
            <asp:ListItem Text="Romance" />
            <asp:ListItem Text="Thriller" />
            <asp:ListItem Text="Fantasy" />
            <asp:ListItem Text="Biography" />
            <asp:ListItem Text="History" />
            <asp:ListItem Text="Horror" />
            <asp:ListItem Text="Other" />
        </asp:DropDownList>
        <asp:RequiredFieldValidator ID="rfvGenre" runat="server"
            ControlToValidate="ddlGenre" InitialValue=""
            ErrorMessage="* pick a genre" ForeColor="Red" Display="Dynamic" />

        <!-- ‘Other’ genre textbox -->
        <asp:Panel ID="pnlOtherGenre" runat="server" Visible="false" CssClass="my-2">
            <asp:Label ID="lblOtherGenre" runat="server" Text="Other genre:" CssClass="me-2" />
            <asp:TextBox ID="txtOtherGenre" runat="server" CssClass="form-control d-inline w-auto" />
        </asp:Panel>

        <!-- Year -->
        <asp:TextBox ID="txtYear" runat="server"
                     CssClass="form-control my-2"
                     Placeholder="Year (YYYY)" />
        <asp:RequiredFieldValidator ID="rfvYear" runat="server"
            ControlToValidate="txtYear" ErrorMessage="* year required"
            ForeColor="Red" Display="Dynamic" />
        <asp:RegularExpressionValidator ID="revYear" runat="server"
            ControlToValidate="txtYear" ValidationExpression="^\d{4}$"
            ErrorMessage="* 4-digit year" ForeColor="Red" Display="Dynamic" />

        <!-- Description -->
        <asp:TextBox ID="txtDescription" runat="server"
                     CssClass="form-control my-2"
                     Placeholder="Description" />
        <asp:RequiredFieldValidator ID="rfvDescription" runat="server"
            ControlToValidate="txtDescription" ErrorMessage="* description required"
            ForeColor="Red" Display="Dynamic" />

        <!-- Owner Email -->
        <asp:TextBox ID="txtOwnerEmail" runat="server"
                     CssClass="form-control my-2"
                     Placeholder="Owner Email" />
        <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
            ControlToValidate="txtOwnerEmail" ErrorMessage="* email required"
            ForeColor="Red" Display="Dynamic" />
        <asp:RegularExpressionValidator ID="revEmail" runat="server"
            ControlToValidate="txtOwnerEmail"
            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
            ErrorMessage="* invalid email"
            ForeColor="Red" Display="Dynamic" />

        <!-- Condition -->
        <asp:DropDownList ID="ddlCondition" runat="server" CssClass="form-select my-2">
            <asp:ListItem Text="Select Condition" Value="" />
            <asp:ListItem Text="New" />
            <asp:ListItem Text="Like New" />
            <asp:ListItem Text="Used" />
            <asp:ListItem Text="Worn" />
        </asp:DropDownList>
        <asp:RequiredFieldValidator ID="rfvCondition" runat="server"
            ControlToValidate="ddlCondition" InitialValue=""
            ErrorMessage="* pick condition" ForeColor="Red" Display="Dynamic" />

        <!-- Summary -->
        <asp:ValidationSummary ID="vsSummary" runat="server"
                               ForeColor="Red" CssClass="mb-2" />

        <!-- Add button -->
        <asp:Button ID="btnAddBook" runat="server"
                    Text="Add Book"
                    CssClass="btn btn-primary"
                    OnClick="btnAddBook_Click" />
    </div>

    <!-- ──────────────────────────────── BOOKS GRID ──────────────────────────────── -->
    <asp:GridView ID="GridView1" runat="server"
                  CssClass="table table-striped"
                  AutoGenerateColumns="False"
                  DataKeyNames="BookID"
                  DataSourceID="SqlDataSource1"
                  AllowPaging="True"
                  PageSize="5"
                  OnPageIndexChanging="GridView1_PageIndexChanging">
        <Columns>
            <asp:BoundField DataField="BookID" HeaderText="ID" ReadOnly="True" />
            <asp:BoundField DataField="Title" HeaderText="Title" />
            <asp:BoundField DataField="Author" HeaderText="Author" />
            <asp:BoundField DataField="Genre" HeaderText="Genre" />
            <asp:BoundField DataField="Year" HeaderText="Year" />
            <asp:BoundField DataField="OwnerEmail" HeaderText="Owner Email" />
            <asp:BoundField DataField="Condition" HeaderText="Condition" />
        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
    ConnectionString="<%$ ConnectionStrings:BookSwapDBConnectionString %>"
    SelectCommand="SELECT BookID, Title, Author, Genre, Year, OwnerEmail, [Condition] FROM Books WHERE OwnerEmail = @Email ORDER BY BookID DESC">
    <SelectParameters>
        <asp:SessionParameter Name="Email" SessionField="Email" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>

</asp:Content>

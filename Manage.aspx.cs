using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BookSwapVersion2
{
    public partial class Manage : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["BookSwapDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBooks();
                ShowNotification("No new notifications.");
            }
        }

        private void LoadBooks()
        {
            if (Session["Email"] == null) return;
            string email = Session["Email"].ToString();

            string query = "SELECT BookID, Title, Author, Genre FROM Books WHERE OwnerEmail = @Email";
            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Email", email);
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                BooksGrid.DataSource = dt;
                BooksGrid.DataBind();
            }
        }

        private void ShowNotification(string message)
        {
            NotificationLabel.Text = $"<strong>Notifications:</strong> {message}";
        }

        protected void BooksGrid_RowEditing(object sender, GridViewEditEventArgs e)
        {
            BooksGrid.EditIndex = e.NewEditIndex;
            LoadBooks();
        }

        protected void BooksGrid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            BooksGrid.EditIndex = -1;
            LoadBooks();
        }

        protected void BooksGrid_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int bookId = Convert.ToInt32(BooksGrid.DataKeys[e.RowIndex].Value);
            GridViewRow row = BooksGrid.Rows[e.RowIndex];

            string title = ((TextBox)row.Cells[1].Controls[0]).Text;
            string author = ((TextBox)row.Cells[2].Controls[0]).Text;
            string genre = ((DropDownList)row.FindControl("ddlGenre")).SelectedValue;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "UPDATE Books SET Title = @Title, Author = @Author, Genre = @Genre WHERE BookID = @BookID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@Author", author);
                cmd.Parameters.AddWithValue("@Genre", genre);
                cmd.Parameters.AddWithValue("@BookID", bookId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            BooksGrid.EditIndex = -1;
            LoadBooks();
            ShowNotification("Book updated successfully.");
        }

        protected void BooksGrid_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int bookId = Convert.ToInt32(BooksGrid.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Books WHERE BookID = @BookID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BookID", bookId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            LoadBooks();
            ShowNotification("Book deleted successfully.");
        }

        protected void BooksGrid_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && (e.Row.RowState & DataControlRowState.Edit) > 0)
            {
                DropDownList ddlGenre = (DropDownList)e.Row.FindControl("ddlGenre");
                if (ddlGenre != null)
                {
                    string genreValue = DataBinder.Eval(e.Row.DataItem, "Genre")?.ToString();
                    if (!string.IsNullOrEmpty(genreValue))
                    {
                        ListItem item = ddlGenre.Items.FindByText(genreValue);
                        if (item != null)
                            ddlGenre.ClearSelection();
                        ddlGenre.SelectedValue = genreValue;
                    }
                }
            }
        }
    }
}

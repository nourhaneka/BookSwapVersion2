using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.UI;

namespace BookSwapVersion2
{
    public partial class Books : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Session["RedirectMessage"] = "Please log in to access the Books page.";
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                pnlOtherGenre.Visible = false;
            }
        }

        protected void btnAddBook_Click(object sender, EventArgs e)
        {
            lblMessage.Text = string.Empty;

            if (!Regex.IsMatch(txtOwnerEmail.Text.Trim(), @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                ShowError("Invalid email format."); return;
            }

            if (!int.TryParse(txtYear.Text.Trim(), out int year))
            {
                ShowError("Year must be a valid number."); return;
            }

            if (string.IsNullOrWhiteSpace(ddlCondition.SelectedValue))
            {
                ShowError("Please select a book condition."); return;
            }

            string genre = ddlGenre.SelectedValue == "Other"
                ? txtOtherGenre.Text.Trim()
                : ddlGenre.SelectedValue;

            if (string.IsNullOrWhiteSpace(genre))
            {
                ShowError("Please specify a genre."); return;
            }

            string cs = ConfigurationManager.ConnectionStrings["BookSwapDBConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string sql =
                        @"INSERT INTO Books (Title, Author, Genre, Year, OwnerEmail, [Condition], Description)
                          VALUES (@Title, @Author, @Genre, @Year, @OwnerEmail, @Condition, @Description)";

                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());
                        cmd.Parameters.AddWithValue("@Author", txtAuthor.Text.Trim());
                        cmd.Parameters.AddWithValue("@Genre", genre);
                        cmd.Parameters.AddWithValue("@Year", year);
                        cmd.Parameters.AddWithValue("@OwnerEmail", txtOwnerEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@Condition", ddlCondition.SelectedValue);
                        cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                GridView1.DataBind();
                ClearForm();
                ShowSuccess("Book added successfully!");
            }
            catch (Exception ex)
            {
                ShowError("Error while adding: " + ex.Message);
            }
        }

        protected void ddlGenre_SelectedIndexChanged(object sender, EventArgs e)
        {
            pnlOtherGenre.Visible = ddlGenre.SelectedValue == "Other";
        }

        protected void GridView1_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GridView1.DataBind();
        }

        private void ClearForm()
        {
            txtTitle.Text = txtAuthor.Text = txtYear.Text = txtOwnerEmail.Text = txtOtherGenre.Text = txtDescription.Text = "";
            ddlGenre.ClearSelection();
            ddlCondition.ClearSelection();
            pnlOtherGenre.Visible = false;
        }

        private void ShowError(string msg)
        {
            lblMessage.Text = msg;
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }

        private void ShowSuccess(string msg)
        {
            lblMessage.Text = msg;
            lblMessage.ForeColor = System.Drawing.Color.Green;
        }
    }
}

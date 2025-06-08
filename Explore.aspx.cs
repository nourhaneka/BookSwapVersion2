using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace BookSwapVersion2
{
    public partial class Explore : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["BookSwapDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBooks();
            }
        }

        private void LoadBooks()
        {
            if (Session["Email"] == null) return;

            string userEmail = Session["Email"].ToString();
            string query = "SELECT Title, Author, Genre, Year, Condition, Description FROM Books WHERE OwnerEmail <> @Email";

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Email", userEmail);
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                ExploreGrid.DataSource = dt;
                ExploreGrid.DataBind();
            }
        }
    }
}

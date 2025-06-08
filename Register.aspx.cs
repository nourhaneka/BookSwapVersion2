using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace BookSwapVersion2
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string cs = ConfigurationManager
                       .ConnectionStrings["BookSwapDBConnectionString"]
                       .ConnectionString;

            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();

                // 1) Check for existing user
                string dup = "SELECT COUNT(*) FROM Users WHERE Email=@Email OR Username=@User";
                SqlCommand dupCmd = new SqlCommand(dup, conn);
                dupCmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                dupCmd.Parameters.AddWithValue("@User", txtUsername.Text.Trim());

                int exists = (int)dupCmd.ExecuteScalar();
                if (exists > 0)
                {
                    lblMessage.Text = "User already registered — please log in.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                // 2) Insert new user
                string ins = "INSERT INTO Users (Username, Email, Password, Location, PhoneNumber, DateOfBirth) " +
                             "VALUES (@U, @E, @P, @L, @Ph, @DOB)";
                SqlCommand insCmd = new SqlCommand(ins, conn);
                insCmd.Parameters.AddWithValue("@U", txtUsername.Text.Trim());
                insCmd.Parameters.AddWithValue("@E", txtEmail.Text.Trim());
                insCmd.Parameters.AddWithValue("@P", txtPassword.Text);
                insCmd.Parameters.AddWithValue("@L", txtLocation.Text.Trim());
                insCmd.Parameters.AddWithValue("@Ph", txtPhone.Text.Trim());
                insCmd.Parameters.AddWithValue("@DOB", txtDOB.Text.Trim());

                insCmd.ExecuteNonQuery();
            }

            // 3) Success message
            lblMessage.Text = "Registration successful! Please log in.";
            lblMessage.ForeColor = System.Drawing.Color.Green;
        }
    }
}

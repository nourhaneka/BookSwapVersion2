using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BookSwapVersion2
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["RedirectMessage"] != null)
                {
                    lblRedirectMessage.Text = Session["RedirectMessage"].ToString();
                    Session["RedirectMessage"] = null;
                }
            }
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["BookSwapDBConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();
                string q = "SELECT UserID FROM Users WHERE Email=@E AND Password=@P";
                SqlCommand cmd = new SqlCommand(q, conn);
                cmd.Parameters.AddWithValue("@E", txtEmailLogin.Text.Trim());
                cmd.Parameters.AddWithValue("@P", txtPassLogin.Text);
                object id = cmd.ExecuteScalar();

                if (id == null)
                {
                    lblLoginMsg.Text = "Invalid login.";
                    return;
                }

                // save session
                Session["UserID"] = id;
                Session["Email"] = txtEmailLogin.Text.Trim();
                Response.Redirect("Books.aspx");
            }
        }

    }
}
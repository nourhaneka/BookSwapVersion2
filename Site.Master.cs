using System;
using System.Web;

namespace BookSwapVersion2
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] != null)
                {
                    btnLogout.Visible = true;
                    btnLogin.Visible = false;
                    btnSignup.Visible = false;
                    lblWelcome.Text = "Hello, " + Session["Email"];
                }
                else
                {
                    btnLogout.Visible = false;
                    btnLogin.Visible = true;
                    btnSignup.Visible = true;
                    lblWelcome.Text = "";
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Default.aspx");
        }
    }
}

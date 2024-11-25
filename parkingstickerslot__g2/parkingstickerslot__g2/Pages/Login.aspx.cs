using System;
using MySql.Data.MySqlClient;

namespace parkingstickerslot__g2
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Optional: Code to run on page load
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                try
                {
                    conn.Open();

                    // SQL query to check if the user exists, and get user_id and account_type
                    string query = @"SELECT ua.user_id, up.account_type
                                     FROM user_account ua
                                     JOIN user_profile up ON ua.user_id = up.user_id
                                     WHERE ua.username = @username AND ua.password = @password";
                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@username", txtUsername.Text.Trim());
                        cmd.Parameters.AddWithValue("@password", txtPassword.Text.Trim());

                        using (MySqlDataReader reader = cmd.ExecuteReader())
                        {
                            // Check if login is successful
                            if (reader.Read())
                            {
                                int userId = Convert.ToInt32(reader["user_id"]);
                                string accountType = reader["account_type"].ToString();

                                // Store user ID and account type in session
                                Session["UserID"] = userId;
                                Session["username"] = txtUsername.Text.Trim();

                                // Redirect based on account type
                                if (accountType == "Admin")
                                {
                                    Response.Redirect("Admin.aspx");
                                }
                                else if (accountType == "Student" || accountType == "Teacher" || accountType == "Employee")
                                {
                                    Response.Redirect("Index.aspx");
                                }
                                else
                                {
                                    lblMessage.Text = "Invalid account type.";
                                }
                            }
                            else
                            {
                                // Display error message
                                lblMessage.Text = "Invalid username or password.";
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Handle any errors that might occur during the database operation
                    lblMessage.Text = "Error: " + ex.Message;
                }
            }
        }
    }
}

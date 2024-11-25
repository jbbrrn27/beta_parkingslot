using System;
using System.Data;
using MySql.Data.MySqlClient;
using System.Web.UI.WebControls;  // Add this line


namespace parkingstickerslot__g2.Pages
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] == null)
                {
                    // Redirect to login if the user is not logged in
                    Response.Redirect("Login.aspx");
                }

                int userId;
                if (int.TryParse(Session["UserId"].ToString(), out userId))
                {
                    LoadStickerRequests(userId);
                    LoadAcceptedStickers(userId);
                    LoadUserProfile(userId); // Ensure this loads profile information too
                }
            }
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int stickerId = Convert.ToInt32(btn.CommandArgument);

            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySqlConnection"]?.ConnectionString;

            if (string.IsNullOrEmpty(connectionString))
            {
                return;
            }

            try
            {
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "DELETE FROM sticker_request WHERE sticker_id = @StickerId AND status != 'Accepted'";
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@StickerId", stickerId);
                    cmd.ExecuteNonQuery();

                    // Reload the sticker requests to update the UI after deletion
                    int userId = int.Parse(Session["UserId"].ToString());
                    LoadStickerRequests(userId);
                    LoadAcceptedStickers(userId);
                }
            }
            catch (Exception ex)
            {
                lblErrorMessage.Text = "Something went wrong, please try again."; // Set the error message
                lblErrorMessage.Visible = true; // Make the error message visible
            }
        }



        private void LoadStickerRequests(int userId)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySqlConnection"]?.ConnectionString;

            if (string.IsNullOrEmpty(connectionString))
            {
                return;
            }

            try
            {
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT sticker_id, vehicle_type, vehicle_brand, plate_number, created_at, status, gdrive_link " +
                                   "FROM sticker_request WHERE user_id = @UserId AND status != 'Accepted'";
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    repeaterStickerRequests.DataSource = dt;
                    repeaterStickerRequests.DataBind();
                }
            }
            catch (Exception ex)
            {
                // Handle any errors appropriately (log or show error message)
            }
        }


        private void LoadAcceptedStickers(int userId)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySqlConnection"]?.ConnectionString;

            if (string.IsNullOrEmpty(connectionString))
            {
                return;
            }

            try
            {
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT sticker_id, vehicle_type, vehicle_brand, plate_number, gdrive_link, qr_code " +
                                   "FROM sticker_request WHERE user_id = @UserId AND status = 'Accepted'";
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    repeaterAcceptedStickers.DataSource = dt;
                    repeaterAcceptedStickers.DataBind();
                }
            }
            catch (Exception ex)
            {
                // Handle any errors appropriately (log or show error message)
            }
        }



        protected void ExitButton_Click(object sender, EventArgs e)
        {
            Session.Abandon(); // End the current session
 
            Response.Redirect("Login.aspx"); // Redirect to login page
        }
        protected void StickerBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Sticker.aspx"); // Change to your desired landing page
        }

        private void LoadUserProfile(int userId)
        {
            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                try
                {
                    conn.Open();

                    // SQL query to get user profile details based on the userId
                    string query = @"
            SELECT fullname, department, campus, account_type, email, contact_number 
            FROM user_profile 
            WHERE user_id = @UserId";

                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);

                        using (MySqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Populate the labels with data from the user profile
                                lblFullName.Text = reader["fullname"].ToString();
                                lblDepartment.Text = reader["department"].ToString();
                                lblCampus.Text = reader["campus"].ToString();
                                lblAccountType.Text = reader["account_type"].ToString();
                                lblEmail.Text = reader["email"].ToString();
                                lblContactNumber.Text = reader["contact_number"].ToString();
                            }
                            else
                            {
                                // Handle case where user profile is not found
                                lblFullName.Text = "Profile not found.";
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Handle any errors that might occur during the database operation
                    lblFullName.Text = "Error: " + ex.Message;
                }
            }
        }

    }
}


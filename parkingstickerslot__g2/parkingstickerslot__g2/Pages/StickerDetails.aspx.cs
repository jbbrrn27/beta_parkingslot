using System;
using MySql.Data.MySqlClient;

namespace parkingstickerslot__g2.Pages
{
    public partial class StickerDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string stickerId = Request.QueryString["sticker_id"];
                if (!string.IsNullOrEmpty(stickerId))
                {
                    LoadStickerDetails(stickerId);
                }
                else
                {
                    lblStickerID.Text = "No sticker ID provided.";
                }
            }
        }

        private void LoadStickerDetails(string stickerId)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySqlConnection"]?.ConnectionString;

            if (string.IsNullOrEmpty(connectionString))
            {
                lblStickerID.Text = "Error: Database connection is not configured.";
                return;
            }

            try
            {
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    string query = @"
                        SELECT sticker_id, vehicle_type, vehicle_brand, plate_number, up.fullname 
                        FROM sticker_request sr
                        JOIN user_account ua ON sr.user_id = ua.user_id
                        JOIN user_profile up ON ua.user_id = up.user_id
                        WHERE sticker_id = @StickerId";

                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@StickerId", stickerId);

                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblStickerID.Text = "Sticker ID: " + reader["sticker_id"].ToString();
                            lblVehicleType.Text = "Vehicle Type: " + reader["vehicle_type"].ToString();
                            lblVehicleBrand.Text = "Vehicle Brand: " + reader["vehicle_brand"].ToString();
                            lblPlateNumber.Text = "Plate Number: " + reader["plate_number"].ToString();
                            lblOwnerName.Text = "Owner: " + reader["fullname"].ToString();
                        }
                        else
                        {
                            lblStickerID.Text = "Sticker details not found.";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblStickerID.Text = "Error: " + ex.Message;
            }
        }
    }
}

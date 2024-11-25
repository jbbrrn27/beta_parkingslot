using System;
using System.Data;
using MySql.Data.MySqlClient;  // Add this for MySQL support
using System.Configuration;
using System.Web.UI.WebControls;  // Needed for Button control
using QRCoder;
using System.Drawing; // To work with Bitmap
using System.IO; // For MemoryStream

namespace parkingstickerslot__g2.Pages
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStickerRequests("Pending");
            }
        }

        private void LoadStickerRequests(string status)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString;
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                // Updated SQL query to join sticker_request, user_account, and user_profile to get the fullname
                string query = @"
                SELECT sr.sticker_id, up.fullname, sr.vehicle_type, sr.vehicle_brand, sr.plate_number, sr.gdrive_link, sr.status, sr.qr_code 
                FROM sticker_request sr
                JOIN user_account ua ON sr.user_id = ua.user_id
                JOIN user_profile up ON ua.user_id = up.user_id
                WHERE sr.status = @Status";

                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Status", status);
                MySqlDataAdapter sda = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                // Bind the data to the GridView
                gvStickerRequests.DataSource = dt;
                gvStickerRequests.DataBind();
            }
        }

        protected void ddlStatusFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedStatus = ddlStatusFilter.SelectedValue;
            LoadStickerRequests(selectedStatus);
        }

        private string GenerateQRCodeFromUrl(string url)
        {
            using (var generator = new QRCoder.QRCodeGenerator())
            {
                var qrCodeData = generator.CreateQrCode(url, QRCoder.QRCodeGenerator.ECCLevel.Q);
                using (var qrCode = new QRCoder.QRCode(qrCodeData))
                {
                    using (var bitmap = qrCode.GetGraphic(20))
                    {
                        // Convert bitmap to Base64 string to store in the database
                        using (var stream = new System.IO.MemoryStream())
                        {
                            bitmap.Save(stream, System.Drawing.Imaging.ImageFormat.Png);
                            return Convert.ToBase64String(stream.ToArray());
                        }
                    }
                }
            }
        }

        protected void StickerRequestAction_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string requestID = btn.CommandArgument;
            string action = btn.CommandName;
            string status = action == "Accept" ? "Accepted" : "Denied";

            string connectionString = ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString;
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Update the status of the sticker request
                    MySqlCommand cmd = new MySqlCommand("UPDATE sticker_request SET status = @Status WHERE sticker_id = @RequestID", conn);
                    cmd.Parameters.AddWithValue("@Status", status);
                    cmd.Parameters.AddWithValue("@RequestID", requestID);
                    cmd.ExecuteNonQuery();

                    // If the sticker request is accepted, generate the QR code
                    if (action == "Accept")
                    {
                        GenerateQRCode(requestID);
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Error updating sticker request: " + ex.Message);
                }
                finally
                {
                    conn.Close();
                }
            }

            // Reload sticker requests to reflect the changes based on the selected filter
            LoadStickerRequests(ddlStatusFilter.SelectedValue);
        }

        private void GenerateQRCode(string requestID)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString;

                // Replace 'http://yourdomain.com' with your actual domain or localhost during testing
                string baseUrl = "http://localhost:PORT/Pages/StickerDetails.aspx"; // Update PORT to match your setup
                string qrCodeUrl = $"{baseUrl}?sticker_id={requestID}";

                // Debugging statement
                System.Diagnostics.Debug.WriteLine("QR Code URL: " + qrCodeUrl);

                // Generate QR Code
                string qrCodeData = GenerateQRCodeFromUrl(qrCodeUrl);

                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    string query = "UPDATE sticker_request SET qr_code = @QRCode WHERE sticker_id = @RequestId";
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@QRCode", qrCodeData);
                    cmd.Parameters.AddWithValue("@RequestId", requestID);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    System.Diagnostics.Debug.WriteLine("Rows affected: " + rowsAffected);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error generating QR code: " + ex.Message);
            }
        }
    }
}

using System;
using MySql.Data.MySqlClient;
using System.Web.UI.WebControls;

namespace parkingstickerslot__g2
{
    public partial class StickerReq_g2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        protected void carType_SelectedIndexChanged(object sender, EventArgs e)
        {
            vehicleBrand.Items.Clear();

            // Populate the vehicle brand dropdown based on the selected vehicle type
            if (carType.SelectedValue == "Car")
            {
                vehicleBrand.Items.Add(new ListItem("--Select--", ""));
                vehicleBrand.Items.Add(new ListItem("Chevrolet", "Chevrolet"));
                vehicleBrand.Items.Add(new ListItem("Toyota", "Toyota"));
                vehicleBrand.Items.Add(new ListItem("Honda", "Honda"));
                vehicleBrand.Items.Add(new ListItem("Ford", "Ford"));
                vehicleBrand.Items.Add(new ListItem("Mitsubishi", "Mitsubishi"));
                vehicleBrand.Items.Add(new ListItem("Nissan", "Nissan"));
                vehicleBrand.Items.Add(new ListItem("Hyundai", "Hyundai"));
                vehicleBrand.Items.Add(new ListItem("Suzuki", "Suzuki"));
            }
            else if (carType.SelectedValue == "Motorcycle")
            {
                vehicleBrand.Items.Add(new ListItem("--Select--", ""));
                vehicleBrand.Items.Add(new ListItem("Kawasaki", "Kawasaki"));
                vehicleBrand.Items.Add(new ListItem("Yamaha", "Yamaha"));
                vehicleBrand.Items.Add(new ListItem("Honda", "Honda"));
                vehicleBrand.Items.Add(new ListItem("Suzuki", "Suzuki"));
                vehicleBrand.Items.Add(new ListItem("Rusi", "Rusi"));
            }
        }

        private string GenerateStickerCode(string vehicleType)
        {
            string prefix = "";
            if (vehicleType.ToLower() == "motorcycle")
            {
                prefix = "LC-M";
            }
            else if (vehicleType.ToLower() == "car")
            {
                prefix = "LC-C";
            }
            else
            {
                prefix = "LC-O";  // Default prefix for other vehicle types
            }

            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySqlConnection"]?.ConnectionString;

            if (string.IsNullOrEmpty(connectionString))
            {
                return null;
            }

            try
            {
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    // Count existing stickers of the same type to determine the sequence number
                    string query = "SELECT COUNT(*) FROM sticker_request WHERE sticker_id LIKE @Prefix";
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Prefix", prefix + "%");
                    int count = Convert.ToInt32(cmd.ExecuteScalar());

                    // Generate the sticker ID as LC-M00001 or LC-C00001
                    string newCode = $"{prefix}{(count + 1).ToString("D5")}";
                    return newCode;
                }
            }
            catch (Exception)
            {
                return null; // Handle the exception in a more appropriate way in the calling code
            }
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            // Ensure UserId is available
            if (Session["UserId"] == null)
            {
                lblMessage.Text = "Error: User not logged in.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            int userId;
            if (!int.TryParse(Session["UserId"].ToString(), out userId))
            {
                lblMessage.Text = "Error: Invalid user ID.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // Ensure all form fields are filled before proceeding
            if (string.IsNullOrEmpty(carType.SelectedValue) ||
                string.IsNullOrEmpty(vehicleBrand.SelectedValue) ||
                string.IsNullOrEmpty(plateNo.Text.Trim()) ||
                string.IsNullOrEmpty(gdriveLink.Text.Trim()))
            {
                lblMessage.Text = "Error: All fields are required.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // Generate the sticker code
            string vehicleType = carType.SelectedValue;
            string stickerId = GenerateStickerCode(vehicleType);
            if (string.IsNullOrEmpty(stickerId))
            {
                lblMessage.Text = "Error generating sticker ID. Please try again.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string vehicleBrandText = vehicleBrand.SelectedValue;
            string plateNumber = plateNo.Text.Trim();
            string gdriveLinkText = gdriveLink.Text.Trim();

            // Get the connection string
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySqlConnection"]?.ConnectionString;

            if (string.IsNullOrEmpty(connectionString))
            {
                lblMessage.Text = "Error: Database connection is not configured correctly.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    // Insert data into the database with the generated sticker_id
                    string query = "INSERT INTO sticker_request (sticker_id, user_id, vehicle_type, vehicle_brand, plate_number, gdrive_link) " +
                                   "VALUES (@StickerId, @UserId, @VehicleType, @VehicleBrand, @PlateNumber, @GDriveLink)";
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@StickerId", stickerId);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@VehicleType", vehicleType);
                    cmd.Parameters.AddWithValue("@VehicleBrand", vehicleBrandText);
                    cmd.Parameters.AddWithValue("@PlateNumber", plateNumber);
                    cmd.Parameters.AddWithValue("@GDriveLink", gdriveLinkText);

                    cmd.ExecuteNonQuery();
                }

                // Redirect to Index.aspx with a success status
                Response.Redirect("Index.aspx?status=success");
            }
            catch (MySqlException ex)
            {
                // Handle duplicate entry error (Error number 1062 in MySQL is for duplicate entry)
                if (ex.Number == 1062)
                {
                    lblMessage.Text = "Error: Plate number already exists.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
                else
                {
                    lblMessage.Text = "Database error: " + ex.Message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
    }

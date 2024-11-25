<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="parkingstickerslot__g2.Pages.Index" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modern Profile</title>
    <link rel="stylesheet" href="Css/Home.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <style>
        /* Toast styles */
        #toast {
            visibility: hidden;
            min-width: 250px;
            background-color: #333;
            color: #fff;
            text-align: center;
            border-radius: 5px;
            padding: 16px;
            position: fixed;
            z-index: 1;
            left: 50%;
            bottom: 30px;
            transform: translateX(-50%);
            font-size: 17px;
        }

        #toast.show {
            visibility: visible;
            animation: fadein 0.5s, fadeout 0.5s 2.5s;
        }

        @keyframes fadein {
            from {bottom: 0; opacity: 0;}
            to {bottom: 30px; opacity: 1;}
        }

        @keyframes fadeout {
            from {bottom: 30px; opacity: 1;}
            to {bottom: 0; opacity: 0;}
        }
        /* Existing CSS */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: #f5f7fa;
            display: flex;
            justify-content: flex-start;
            align-items: flex-start;
            height: 100vh;
            font-size: 16px;
            overflow-x: hidden;
        }

        /* Sidebar Styles */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 60px;
            height: 100%;
            background-color: #34495e;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            transition: width 0.3s ease;
            z-index: 100;
            padding: 10px;
        }

        .sidebar:hover {
            width: 220px;
        }

        .sidebar-icons {
            padding-top: 30px;
            display: flex;
            flex-direction: column;
            width: 100%;
        }

        .sidebar-icons a {
            display: flex;
            align-items: center;
            color: white;
            margin: 20px 0;
            font-size: 20px;
            transition: transform 0.3s ease;
            width: 100%;
        }

        .sidebar-icons a:hover {
            transform: scale(1.2);
        }

        .sidebar-icons a span.icon-label {
            display: none;
            margin-left: 10px;
            font-size: 16px;
        }

        .sidebar:hover .sidebar-icons a span.icon-label {
            display: inline;
        }

        /* Adjust layout for sidebar content */
        .sidebar-icons a span {
            color: white;
        }

        /* Main Container */
        .container {
            margin-left: 60px;
            padding: 30px;
            display: flex;
            flex-direction: row;
            gap: 40px;
            width: calc(100% - 60px);
            transition: margin-left 0.3s ease;
        }

        .sidebar:hover + .container {
            margin-left: 220px;
            width: calc(100% - 220px);
        }

        /* Profile Section */
        .profile-section {
            background-color: #fff;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }

        .profile-logo {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            border: 3px solid #ddd;
            margin-bottom: 20px;
        }

        h2, p {
            color: #2c3e50;
        }

        .request-sticker-btn {
            background-color: #e74c3c;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .request-sticker-btn:hover {
            background-color: #c0392b;
        }

        /* Vehicle Cards Section */
        .status-section {
            flex: 1;
            background-color: #fff;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.1);
            overflow-y: auto;
            max-height: 85vh;
        }

        .status-section h2 {
            font-size: 24px;
            color: #34495e;
            margin-bottom: 20px;
        }

        .vehicle-card {
            background-color: #ecf0f1;
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 20px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }

        /* Modal Styles */
        .modal-toggle {
            display: none; /* Keep checkbox hidden */
        }

        .modal {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            width: 80%;
            max-width: 500px;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            z-index: 200;
            display: none; /* Initially hidden */
        }

        /* Show Modal when Checkbox is Checked */
        .modal-toggle:checked + label + .modal {
            display: block; /* Display modal when checkbox is checked */
        }

        .modal-content {
            position: relative;
            padding: 20px;
        }

        h4 {
            color: #3498db;
            margin-bottom: 15px;
        }

        .modal-content p {
            margin: 10px 0;
            color: #2c3e50;
        }

        .close-modal-btn {
            display: inline-block;
            background-color: #e74c3c;
            color: white;
            padding: 8px 20px;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 20px;
            text-align: center;
        }

        .container {
    display: flex;
    gap: 20px; /* Add space between sections */
    margin-top: 20px;
}

.sticker-requests-section {
    flex: 1; /* Allow this section to take up equal space */
    background-color: #ffffff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.accepted-stickers-section {
    flex: 1; /* Allow this section to take up equal space */
    background-color: #ffffff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.sticker-details, .accepted-sticker-details {
    margin-bottom: 20px;
}

.qr-code-container {
    margin-top: 15px;
    text-align: center;
}


        .close-modal-btn:hover {
            background-color: #c0392b;
        }

        /* Updated View Details Button Design */
        .expand-btn {
            display: inline-block;
            color: #e74c3c;
            text-decoration: underline;
            cursor: pointer;
            margin-top: 10px;
            font-weight: bold;
            transition: color 0.3s ease;
        }

        .delete-button {
    background-color: #e74c3c;
    color: white;
    border: none;
    padding: 5px 10px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.delete-button:hover {
    background-color: #c0392b;
}
.error-message {
    display: inline-block;
    background-color: #f8d7da;  /* Light red background */
    color: #721c24;             /* Dark red text */
    border: 1px solid #f5c6cb;  /* Border color matching background */
    padding: 10px;
    margin-top: 20px;
    border-radius: 5px;
    text-align: center;
    width: 100%;
}

    </style>
</head>
<body>
    <form id="form2" runat="server">
        <div class="sidebar">
            <div class="sidebar-icons">

                <!-- Exit Button -->
                <asp:LinkButton ID="ExitButton" runat="server" OnClick="ExitButton_Click">
                    <span class="fas fa-sign-out-alt"></span>
                    <span class="icon-label">Exit</span>
                </asp:LinkButton>
            </div>
        </div>
         <!-- Toast Notification -->
        <div id="toast">Request Submitted Successfully!</div>

        <div class="container">
            <!-- Profile Section -->
            <div class="profile-section">
                <div class="profile-card">
                    <h2><asp:Label ID="lblFullName" runat="server" Text="User Name"></asp:Label></h2>
                    <p><asp:Label ID="lblDepartment" runat="server" Text="Department"></asp:Label></p>
                    <div class="profile-details">
                        <p><strong>Campus:</strong> <asp:Label ID="lblCampus" runat="server" Text="Campus"></asp:Label></p>
                        <p><strong>Account Type:</strong> <asp:Label ID="lblAccountType" runat="server" Text="Account Type"></asp:Label></p>
                        <p><strong>Email:</strong> <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label></p>
                        <p><strong>Contact No:</strong> <asp:Label ID="lblContactNumber" runat="server" Text="Contact Number"></asp:Label></p>
                        <asp:Button ID="RequestSticker" runat="server" OnClick="StickerBtn_Click" Text="Request Sticker" CssClass="request-sticker-btn" />
                    </div>
                </div>
            </div>

      <div class="container">
    <div class="sticker-requests-section">
        <h2>Vehicle Request Sticker Status</h2>
       <asp:Repeater ID="repeaterStickerRequests" runat="server">
    <ItemTemplate>
        <div class="sticker-details">
            <p>Sticker ID: <%# Eval("sticker_id") %></p>
            <p>Vehicle Type: <%# Eval("vehicle_type") %></p>
            <p>Vehicle Brand: <%# Eval("vehicle_brand") %></p>
            <p>Plate Number: <%# Eval("plate_number") %></p>
            <p>Status: <%# Eval("status") %></p>
            <p>Google Drive Link: <%# Eval("gdrive_link") %></p>
            
            <!-- Delete Button -->
            <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandArgument='<%# Eval("sticker_id") %>' OnClick="btnDelete_Click" CssClass="delete-button" />
        </div>
    </ItemTemplate>
</asp:Repeater>
    </div>

    <div class="accepted-stickers-section">
        <h2>Accepted Stickers</h2>
        <asp:Repeater ID="repeaterAcceptedStickers" runat="server">
            <ItemTemplate>
                <div class="accepted-sticker-details">
                    <p>Sticker ID: <%# Eval("sticker_id") %></p>
                    <p>Plate Number: <%# Eval("plate_number") %></p>
                    <div class="qr-code-container">
                        <p>Check your QR Code in your app!</p>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>

            

        <!-- Modal for Vehicle Request Sticker Details -->
       <div id="detailsModal" class="modal">
    <div class="modal-content">
        <span class="close-button" onclick="closeModal()">×</span>
        <h2>Vehicle Request Details</h2>
        <p><strong>Vehicle Type:</strong> <span id="modalVehicleType"></span></p>
        <p><strong>Vehicle Brand:</strong> <span id="modalVehicleBrand"></span></p>
        <p><strong>Plate Number:</strong> <span id="modalPlateNumber"></span></p>
        <p><strong>Google Drive Link:</strong> <a href="" target="_blank" id="modalGDriveLink">Link</a></p>
    </div>
</div>

    </form>
    <script>
        // Function to show the modal with vehicle details
        function showDetails(vehicleType, vehicleBrand, plateNumber, gdriveLink) {
            // Populate the modal with the passed values
            document.getElementById("modalVehicleType").innerText = vehicleType;
            document.getElementById("modalVehicleBrand").innerText = vehicleBrand;
            document.getElementById("modalPlateNumber").innerText = plateNumber;
            document.getElementById("modalGDriveLink").href = gdriveLink;

            // Show the modal
            document.getElementById("detailsModal").style.display = "block";
        }

        // Function to close the modal
        function closeModal() {
            document.getElementById("detailsModal").style.display = "none";
        }
</script>
    <script>
        // Function to show toast notification
        function showToast() {
            var toast = document.getElementById("toast");
            toast.className = "show";
            setTimeout(function () {
                toast.className = toast.className.replace("show", "");
            }, 3000);
        }

        // Check for the status parameter in the URL
        window.onload = function () {
            var urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('status') === 'success') {
                showToast();
            }
        };
    </script>
    <asp:Label ID="lblErrorMessage" runat="server" CssClass="error-message" Visible="false"></asp:Label>
</body>
</html>

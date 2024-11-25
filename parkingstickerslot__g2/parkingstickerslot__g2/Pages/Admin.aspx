<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="parkingstickerslot__g2.Pages.Admin" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin - Parking Spot Logger</title>
    <link rel="stylesheet" type="text/css" href="Css/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            padding: 0;
            display: flex;
            height: 100vh;
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
            text-decoration: none;
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

        /* Content Section */
        .content {
            flex: 1;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            overflow-y: auto;
        }

        .sticker-requests {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .sticker-requests th, .sticker-requests td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .sticker-requests th {
            background-color: #007bff;
            color: white;
        }

        .accept-button {
            background-color: #28a745;
            color: #fff;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
        }

        .deny-button {
            background-color: #dc3545;
            color: #fff;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
        }

        .accept-button:hover, .deny-button:hover {
            opacity: 0.8;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <!-- Hidden Field to Track Current View -->
        <asp:HiddenField ID="hfCurrentView" runat="server" />
        
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-icons">
                <a href="#" onclick="showHomePage(); return false;">
                    <i class="fas fa-home"></i>
                    <span class="icon-label">Home</span>
                </a>
                <a href="#" onclick="toggleStickerRequests(); return false;">
                    <i class="fas fa-sticky-note"></i>
                    <span class="icon-label">View Sticker Requests</span>
                </a>
                <a href="Login.aspx">
                    <i class="fas fa-sign-out-alt"></i>
                    <span class="icon-label">Exit</span>
                </a>
            </div>
        </div>
        
        <!-- Content -->
        <div class="container">
            <div class="content" id="homePageContent">
                <h2>Welcome to the Admin Panel</h2>
                <p>Use the sidebar to navigate between features, manage sticker requests, and view parking details.</p>
            </div>
            <div class="content" id="stickerRequestsContent" style="display: none;">
                <div class="filter-container">
                    <h2>Sticker Requests</h2>
                    <asp:DropDownList ID="ddlStatusFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlStatusFilter_SelectedIndexChanged">
                        <asp:ListItem Text="Pending" Value="Pending" />
                        <asp:ListItem Text="Accepted" Value="Accepted" />
                        <asp:ListItem Text="Denied" Value="Denied" />
                    </asp:DropDownList>
                </div>
        <asp:GridView ID="gvStickerRequests" runat="server" AutoGenerateColumns="False" CssClass="sticker-requests">
    <Columns>
        <asp:BoundField DataField="fullname" HeaderText="Full Name" />
        <asp:BoundField DataField="sticker_id" HeaderText="Request ID" />
        <asp:BoundField DataField="vehicle_type" HeaderText="Vehicle Type" />
        <asp:BoundField DataField="vehicle_brand" HeaderText="Vehicle Brand" />
        <asp:BoundField DataField="plate_number" HeaderText="Plate Number" />
        <asp:BoundField DataField="gdrive_link" HeaderText="Google Drive Link" />
        <asp:BoundField DataField="status" HeaderText="Status" />
        <asp:TemplateField HeaderText="QR Code">
            <ItemTemplate>
                <asp:Image ID="imgQRCode" runat="server" ImageUrl='<%# "data:image/png;base64," + Eval("qr_code") %>' Width="100px" Height="100px" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
                <asp:Button ID="btnAccept" runat="server" CommandName="Accept" CommandArgument='<%# Eval("sticker_id") %>' Text="Accept" OnClick="StickerRequestAction_Click" CssClass="accept-button" Visible='<%# Eval("status").ToString() == "Pending" %>' />
                <asp:Button ID="btnDeny" runat="server" CommandName="Deny" CommandArgument='<%# Eval("sticker_id") %>' Text="Deny" OnClick="StickerRequestAction_Click" CssClass="deny-button" Visible='<%# Eval("status").ToString() == "Pending" %>' />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

            </div>
        </div>
    </form>

    <script>
        window.onload = function() {
            var currentView = document.getElementById("<%= hfCurrentView.ClientID %>").value;
            setView(currentView || "homePage");
        }

        function setView(viewName) {
            document.getElementById("stickerRequestsContent").style.display = (viewName === "stickerRequests") ? "block" : "none";
            document.getElementById("homePageContent").style.display = (viewName === "homePage") ? "block" : "none";
            document.getElementById("<%= hfCurrentView.ClientID %>").value = viewName;
        }

        function toggleStickerRequests() {
            setView("stickerRequests");
        }

        function showHomePage() {
            setView("homePage");
        }
    </script>
</body>
</html>

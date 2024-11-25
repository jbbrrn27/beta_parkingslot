<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StickerDetails.aspx.cs" Inherits="parkingstickerslot__g2.Pages.StickerDetails" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sticker Details</title>
    <link rel="stylesheet" type="text/css" href="Css/style.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="content">
            <h2>Sticker Details</h2>
            <asp:Label ID="lblStickerID" runat="server" Text=""></asp:Label><br />
            <asp:Label ID="lblVehicleType" runat="server" Text=""></asp:Label><br />
            <asp:Label ID="lblVehicleBrand" runat="server" Text=""></asp:Label><br />
            <asp:Label ID="lblPlateNumber" runat="server" Text=""></asp:Label><br />
            <asp:Label ID="lblOwnerName" runat="server" Text=""></asp:Label><br />
        </div>
    </form>
</body>
</html>
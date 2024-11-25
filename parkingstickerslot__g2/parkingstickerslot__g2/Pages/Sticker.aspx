<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sticker.aspx.cs" Inherits="parkingstickerslot__g2.StickerReq_g2" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sticker Request Form</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f7f7f7;
            color: #333;
            margin: 0;
            padding: 0;
        }

        .form-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 20px;
            border: 1px solid #800000;
            border-radius: 8px;
            background-color: #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #800000;
            font-size: 24px;
        }

        .form-group {
            margin-bottom: 15px;
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 5px;
            font-weight: bold;
            color: #800000;
        }

        .form-group input,
        .form-group select {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        .form-group input:focus,
        .form-group select:focus {
            border-color: #800000;
            outline: none;
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        .submit-button {
            padding: 12px 25px;
            background-color: #800000;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 18px;
            transition: background-color 0.3s, transform 0.3s;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            font-weight: bold;
        }

        .submit-button:hover {
            background-color: #6f0000;
            transform: translateY(-2px);
        }

        .submit-button:active {
            transform: translateY(0);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <h2>Sticker Request</h2>
            <!-- error -->
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

            <!-- Vehicle Type Dropdown -->
            <div class="form-group">
                <label for="carType">Vehicle Type:</label>
                <asp:DropDownList ID="carType" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="carType_SelectedIndexChanged">
                    <asp:ListItem Value="">--Select--</asp:ListItem>
                    <asp:ListItem Value="Car">Car</asp:ListItem>
                    <asp:ListItem Value="Motorcycle">Motorcycle</asp:ListItem>
                </asp:DropDownList>
            </div>

            <!-- Vehicle Brand Dropdown -->
            <div class="form-group">
                <label for="vehicleBrand">Vehicle Brand:</label>
                <asp:DropDownList ID="vehicleBrand" runat="server" CssClass="form-control">
                    <asp:ListItem Value="" Text="--Select--"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <!-- Plate Number and Google Drive Link Fields -->
            <div class="form-group">
                <label for="plateNo">Plate No. or CR:</label>
                <asp:TextBox ID="plateNo" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="gdriveLink">Google Drive Link:</label>
                <asp:TextBox ID="gdriveLink" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <!-- Submit Button -->
            <div class="button-container">
                <asp:Button ID="submitButton" runat="server" Text="Save and Submit" CssClass="submit-button" OnClick="SubmitButton_Click" />
            </div>
        </div>
    </form>
</body>
</html>

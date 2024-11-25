<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="parkingstickerslot__g2.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <style>
        body {
            background-color: #f0f0f0; /* Light background color */
            font-family: Arial, sans-serif; /* Font style */
            display: flex; /* Center the form */
            justify-content: center; /* Center horizontally */
            align-items: center; /* Center vertically */
            height: 100vh; /* Full viewport height */
            margin: 0; /* Remove default margin */
            flex-direction: column; /* Stack items vertically */
        }
        .login-container {
            background-color: #800000; /* Maroon background */
            color: yellow; /* Yellow text */
            padding: 30px; /* Padding around the form */
            border-radius: 8px; /* Rounded corners */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* Subtle shadow */
            width: 300px; /* Fixed width */
            text-align: left; /* Align text to the left */
            margin-top: 10px; /* Space between image and container */
            position: relative; /* Position relative to enable absolute positioning */
        }
        img {
            width: 150px; /* Adjusted logo width */
            height: auto; /* Maintain aspect ratio */
            margin-bottom: 10px; /* Space below logo */
            position: absolute; /* Position absolute to move it */
            top: 20px; /* Space from the top */
            right: 20px; /* Space from the right */
        }
        h2 {
            margin-bottom: 20px; /* Space below heading */
        }
        .input-group {
            margin-bottom: 15px; /* Space between input groups */
            width: 100%; /* Full width to align inputs */
        }
        label {
            display: block; /* Block display for labels */
            margin-bottom: 5px; /* Space below label */
        }
        input[type="text"], input[type="password"] {
            padding: 10px; /* Padding inside the input */
            border: 1px solid #ccc; /* Border for input */
            border-radius: 4px; /* Rounded corners for input */
            width: calc(100% - 20px); /* Full width minus padding */
            box-sizing: border-box; /* Include padding and border in width calculation */
        }
        input[type="text"]:focus, input[type="password"]:focus {
            border-color: yellow; /* Change border color on focus */
            outline: none; /* Remove default outline */
        }
        #btnLogin {
            background-color: yellow; /* Yellow button */
            color: maroon; /* Maroon text */
            padding: 10px; /* Padding inside the button */
            border: none; /* No border */
            border-radius: 4px; /* Rounded corners */
            cursor: pointer; /* Pointer cursor on hover */
            font-weight: bold; /* Bold text */
            width: 120px; /* Smaller width for the button */
            margin: 10px 0; /* Space above and below the button */
            display: block; /* Block display to ensure it centers */
        }
        #btnLogin:hover {
            background-color: #e5e500; /* Lighter yellow on hover */
        }
        #lblMessage {
            margin-bottom: 10px; /* Space below the message label */
            font-weight: bold; /* Bold for error message */
            color: red; /* Red color for error messages */
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <img src="~/Images/ublogo_.png" alt="Logo" />
            <h2>Login</h2>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" />
            <br />
            <div class="input-group">
                <asp:Label ID="lblUsername" runat="server" Text="Username" AssociatedControlID="txtUsername" />
                <asp:TextBox ID="txtUsername" runat="server" required="true" />
            </div>
            <div class="input-group">
                <asp:Label ID="lblPassword" runat="server" Text="Password" AssociatedControlID="txtPassword" />
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" required="true" />
            </div>
            <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="btn" />
        </div>
    </form>
</body>
</html>

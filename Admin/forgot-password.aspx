﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="forgot-password.aspx.cs" Inherits="Admin_forgot_password" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Med Research Ninja Password Recovery</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="Med Research Ninja" name="author" />
    <!-- App favicon -->
    <link rel="shortcut icon" href="assets/images/favicon.png">

    <!-- Bootstrap Css -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Icons Css -->
    <link href="assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    <!-- App Css-->
    <link href="assets/css/app.min.css" rel="stylesheet" type="text/css" />
    <!-- custom Css-->
    <link href="assets/css/custom.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="auth-page-wrapper pt-5">

            <!-- auth page content -->
            <div class="auth-page-content">
                <div class="container">

                    <div class="row justify-content-center">
                        <div class="col-md-12 col-lg-10 col-xl-10">
                            <div class="card mt-4">

                                <div class="card-body p-4">

                                    <div class="row">
                                        <div class="col-lg-6">
                                            <img src="assets/images/login-bg.jpg" class="w-100" />
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="text-center mt-2">
                                                <a href="/admin" class="d-inline-block auth-logo">
                                                    <img src="assets/images/logo.png" height="70" />
                                                </a>
                                            </div>
                                            <div class="text-center mt-2">
                                                <h5 class="text-primary">Forgot Password?</h5>
                                                <p class="text-muted">Reset password with Med Research Ninja Admin</p>
                                            </div>
                                            <div class="alert alert-borderless alert-warning text-center mb-2 mx-2" role="alert">
                                                Enter your email and instructions will be sent to you! 
                                            </div>
                                            <div class="p-2 mb-4">
                                                <asp:Label ID="lblStatus" runat="server" Style="width: 100%;" Visible="false"></asp:Label>
                                                <div class="mb-4">
                                                    <label class="form-label">Email<span class="text-danger">*</span></label>
                                                    <asp:TextBox ID="txtEmail" runat="server" MaxLength="100" CssClass="form-control" placeholder="Enter Email" />
                                                    <asp:RequiredFieldValidator ID="req1" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="Reset" ErrorMessage="Field can't be empty"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator runat="server" ValidationGroup="Reset" SetFocusOnError="true" ControlToValidate="txtEmail" Display="Dynamic" ForeColor="Red" ErrorMessage="Invalid Email Id" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                </div>
                                                <div class="text-center mt-4 ">
                                                    <asp:Button runat="server" ID="btnLogin" OnClick="btnReset_Click" class="btn btn-primary btn-primary-login w-100" ValidationGroup="Reset" Text="Send Reset Link" />
                                                </div>
                                                <div class="mt-4 text-center">
                                                    <p class="mb-0">Wait, I remember my password... <a href="/admin" class="fw-semibold text-primary text-decoration-underline">Click here </a></p>
                                                </div>
                                                <!-- end form -->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- end card body -->
                            </div>
                            <!-- end card -->

                            <div class="mt-4 text-center">
                                <p class="mb-0">
                                    &copy;
                               
                                    <script>document.write(new Date().getFullYear())</script>
                                    Med Research Ninja
                                </p>
                            </div>

                        </div>
                    </div>
                    <!-- end row -->
                </div>
                <!-- end container -->
            </div>
            <!-- end auth page content -->

            <!-- footer -->
            <footer class="footer">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="text-center">
                                <a href="https://www.nextwebi.com/">
                                    <p class="mb-0 text-muted">
                                        Designed & Developed by Nextwebi
                                    </p>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </footer>
            <!-- end Footer -->
        </div>
        <!-- end auth-page-wrapper -->

        <!-- JAVASCRIPT -->
        <script src="assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
    </form>
</body>
</html>

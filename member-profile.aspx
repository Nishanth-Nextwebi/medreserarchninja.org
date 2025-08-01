<%@ Page Title="" Language="C#" MasterPageFile="~/User.master" AutoEventWireup="true" CodeFile="member-profile.aspx.cs" Inherits="member_profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">

    <style>
        section.header-top-home11.bg-dark.pt10.pb10 {
            display: none !important;
        }

        a.header-logo.logo1 {
            position: relative;
            top: unset !important;
        }

        .header-logo img {
            width: 190px;
        }

        header.nav-homepage-style {
            margin-right: 0px;
            padding: 0px 0px;
        }

        .new-head {
            height: 100px;
        }

        .dashboard__sidebar {
            margin-top: 0px;
            position: relative;
        }

        .new-block {
            display: block !important;
        }

        .dashboard__main {
            margin-top: 0px;
            padding-left: 0px;
        }

        input[type="file"] {
            background: #f1f1f1;
            padding: 2px 10px;
        }

        @media (min-width:320px) and (max-width:767px) {
            .new-join {
                display: none;
            }

            .new-profile {
                display: flex !important;
            }
        }

        @media (min-width:768px) and (max-width:911px) {
            .new-join {
                display: none;
            }

            .new-profile {
                display: flex !important;
            }
        }

        @media (min-width:767px) and (max-width:991px) {
            label.heading-color.ff-heading.fw500.mb10 {
                font-size: 12px;
            }

            .new-flex-whats {
                flex-direction: column;
                align-items: start;
                gap: .5rem;
            }
        }

        @media (min-width:992px) and (max-width:1199pxs) {
            label.heading-color.ff-heading.fw500.mb10 {
                font-size: 12px;
            }
        }

        @media (min-width:320px) and (max-width:767px) {
            .new-join {
                display: none;
            }

            .new-flex-whats {
                flex-direction: column;
                align-items: start;
                gap: .5rem;
            }

            .new-profile {
                display: flex !important;
            }

            label.heading-color.ff-heading.fw500.mb10 {
                font-size: 12px;
            }
        }

        a.text-center.text-success.btn.btn-outline-success {
            display: flex;
            gap: .5rem;
        }

        i.bx.bxl-whatsapp.text-success {
            font-size: 24px;
        }

        .btn.btn-outline-success:hover {
            color: #fff !important;
        }

            .btn.btn-outline-success:hover i {
                color: #fff !important;
            }
    </style>
    <link href="js/snackbar/snackbar.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="dashboard_content_wrapper">
        <div class="dashboard dashboard_wrapper ">
            <div class="dashboard__sidebar d-none d-lg-block">
                <div class="dashboard_sidebar_list">
                    <p class="fz15 fw400 ff-heading pl30">Member Dashboard</p>
                    <div class="sidebar_list_item">
                        <a href="/general-information.aspx" class="items-center "><i class="flaticon-document mr15"></i>General Information</a>
                    </div>
                    <div class="sidebar_list_item">
                        <a href="/member-profile.aspx" class="items-center -is-active"><i class="flaticon-home mr15"></i>My Profile</a>
                    </div>
                    <div class="sidebar_list_item">
                        <a href="/my-projects.aspx" class="items-center"><i class="flaticon-like mr15"></i>My Projects</a>
                    </div>
                    <div class="sidebar_list_item">
                        <a href="/recent-projects.aspx" class="items-center "><i class="flaticon-document mr15"></i>Recent Projects</a>
                    </div>
                    <div class="sidebar_list_item position-relative">
                        <a href="/my-payment.aspx" class="items-center "><i class="flaticon-receipt mr15"></i>Projects Due</a><%= strDues %>
                    </div>
                    <div class="sidebar_list_item ">
                        <a href="/my-discussion.aspx" class="items-center"><i class="flaticon-chat mr15"></i>My Discussion</a>
                    </div>
                    <div class="sidebar_list_item ">
                        <a href="/my-blueprintrx.aspx" class="items-center"><i class="flaticon-review-1 mr15"></i>My BlueprintRX</a>
                    </div>
                    <div class="sidebar_list_item">
                        <a href="/my-portfolio.aspx" class="items-center"><i class="flaticon-receipt mr15"></i>Build My Research Portfolio</a>
                    </div>
                    <div class="sidebar_list_item">
                        <a href="/change-password.aspx" class="items-center"><i class="flaticon-presentation mr15"></i>Change Password</a>
                    </div>
                    <div class="sidebar_list_item ">
                        <asp:LinkButton class="items-center" ID="lnkLogout" runat="server" OnClick="btnLogout_Click"><i class="flaticon-logout mr15"></i>Logout</asp:LinkButton>
                    </div>

                </div>
            </div>
            <div class="dashboard__main pl0-md">
                <div class="dashboard__content hover-bgc-color">

                    <div class="row">
                        <div class="col-xl-12">
                            <div class="col-lg-12">
                                <div class="dashboard_navigationbar d-block d-lg-none">
                                    <div class="dropdown">
                                        <a onclick="myFunction()" class="dropbtn"><i class="fa fa-bars pr10"></i>Dashboard Navigation</a>
                                        <ul id="myDropdown" class="dropdown-content">
                                            <li>
                                                <p class="fz15 fw400 ff-heading mt30 pl30">Start</p>
                                            </li>
                                            <li><a href="/general-information.aspx" contenteditable="false" style="cursor: pointer;"><i class="flaticon-document mr10"></i>General Information</a></li>
                                            <li class="active"><a href="/member-profile.aspx" contenteditable="false" style="cursor: pointer;"><i class="flaticon-home mr10"></i>My Profile</a></li>
                                            <li><a href="/my-projects.aspx" contenteditable="false" style="cursor: pointer;"><i class="flaticon-receipt mr10"></i>My Projects</a></li>
                                            <li><a href="/recent-projects.aspx" contenteditable="false" style="cursor: pointer;"><i class="flaticon-chat mr10"></i>Recent Projects</a></li>
                                            <li><a href="/my-payment.aspx" contenteditable="false" style="cursor: pointer;"><i class="flaticon-review-1 mr10"></i>Projects Due</a><%= strDues %></li>
                                            <li><a href="/my-discussion.aspx" contenteditable="false" style="cursor: pointer;"><i class="flaticon-chat mr10"></i>My Discussion</a></li>
                                            <li><a href="/my-blueprintrx.aspx" contenteditable="false" style="cursor: pointer;"><i class="flaticon-review-1 mr10"></i>My BlueprintRX</a></li>
                                            <li><a href="/my-portfolio.aspx" contenteditable="false" style="cursor: pointer;"><i class="flaticon-receipt mr10"></i>Build My Research Portfolio</a></li>
                                            <li><a href="/change-password.aspx" contenteditable="false" style="cursor: pointer;"><i class="flaticon-presentation  mr10"></i>Change Password</a></li>

                                            <li>
                                                <asp:LinkButton ID="btnLogout" runat="server" class="items-center" OnClick="btnLogout_Click">
                                                <i class="flaticon-logout mr15"></i>Logout</asp:LinkButton></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="ps-widget bgc-white bdrs4 p30 mb30 overflow-hidden position-relative">
                                <div class="bdrb1 pb15 mb25 d-flex justify-content-between new-flex-whats">
                                    <h5 class="list-title fw-bold">Profile Details</h5>
                                    <a aria-label="Join our WhatsApp group" href="<%=StrWLink %>" target="_blank" class="text-center text-success btn btn-outline-success" title="Join our WhatsApp group">
                                        <i class="bx bxl-whatsapp text-success "></i><span>Join WhatsApp Group</span>
                                    </a>
                                </div>
                                <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>

                                <div class="col-lg-12">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="profile-box d-sm-flex align-items-center mb30">
                                                <div class="profile-img mb20-sm">
                                                    <%=strProfileimg %>
                                                </div>
                                                <div class="profile-content ml20 ml0-xs">
                                                    <div class="">
                                                        <asp:FileUpload ID="uploadProfileimg" CssClass="form-control formFile" runat="server" />
                                                        <span class="text-danger">image type .png,.jpg is required. resolution of 250 px * 250 px is recommended</span>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="mb20">
                                                <label class="heading-color ff-heading fw500 mb10">Full Name</label>
                                                <asp:TextBox class="form-control" ID="txtFullName" runat="server" MaxLength="100" placeholder="Full Name"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="mb20">
                                                <label class="heading-color ff-heading fw500 mb10">Email Address</label>
                                                <asp:TextBox class="form-control" ID="txtEmailAddress" runat="server" MaxLength="100" placeholder="Email Address"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEmailAddress" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="Save" ErrorMessage="Field can't be empty"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmailAddress" ErrorMessage="Please Enter valid EmailAddress" ForeColor="Red" ValidationGroup="Save" SetFocusOnError="True" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="mb20">
                                                <label class="heading-color ff-heading fw500 mb10">Contact Number</label>
                                                <asp:TextBox class="form-control onlyNum" ID="txtContactNumber" runat="server" MaxLength="15" placeholder="Contact Number"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtContactNumber" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="Save" ErrorMessage="Field can't be empty"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtContactNumber" ErrorMessage="Please Enter valid contact number" ForeColor="Red" ValidationGroup="Save" SetFocusOnError="True" Display="Dynamic" ValidationExpression="^([0-9\(\)\/\+ \-]*)$"></asp:RegularExpressionValidator>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="mb20">
                                                <label class="heading-color ff-heading fw500 mb10">Country</label>
                                                <asp:TextBox class="form-control" ID="txtCountry" runat="server" MaxLength="100" placeholder="Country"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="mb20">
                                                <label class="heading-color ff-heading fw500 mb10">Address</label>

                                                <asp:TextBox class="form-control" ID="txtAddress" runat="server" MaxLength="100" placeholder="Address"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="mb20">
                                                <label class="heading-color ff-heading fw500 mb10">City</label>
                                                <asp:TextBox class="form-control" ID="txtCity" runat="server" MaxLength="100" placeholder="City"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="mb20">
                                                <label class="heading-color ff-heading fw500 mb10">State</label>

                                                <asp:TextBox class="form-control" ID="txtState" runat="server" MaxLength="100" placeholder="State"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="mb20">
                                                <label class="heading-color ff-heading fw500 mb10">Pincode</label>

                                                <asp:TextBox class="form-control" ID="txtPincode" runat="server" MaxLength="100" placeholder="Pincode"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="mb20">
                                                <label class="heading-color ff-heading fw500 mb10">Who are you?</label>
                                                <asp:DropDownList ID="ddlWhoAreYou" runat="server" CssClass="form-control" onchange="toggleSections()">
                                                    <asp:ListItem Text="Who are you ?" Value=""></asp:ListItem>
                                                    <asp:ListItem Text="Medical Student" Value="Medical Student"></asp:ListItem>
                                                    <asp:ListItem Text="Graduate" Value="Graduate"></asp:ListItem>
                                                    <asp:ListItem Text="Resident" Value="Resident"></asp:ListItem>
                                                    <asp:ListItem Text="Other" Value="Others"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div id="otherTextBoxContainer" class="col-sm-6 d-none">
                                            <div class="mb20">
                                                <label class="heading-color ff-heading fw500 mb10">Please Specify</label>
                                                <asp:TextBox class="form-control" ID="txtspecify" runat="server" MaxLength="100" placeholder="Other ? Please Specify"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv12" runat="server" ControlToValidate="txtspecify" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="Save" ErrorMessage="Field can't be empty"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="mb20">
                                                <label class="heading-color ff-heading fw500 mb10">Medical School Name/ Undergraduate Course </label>
                                                <asp:TextBox class="form-control" ID="txtCourse" runat="server" MaxLength="100" placeholder="Medical School Name/ Undergraduate Course"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="mb20">
                                                <label class="heading-color ff-heading fw500 mb10">GovtID</label>

                                                <asp:FileUpload ID="UploadGovtID" runat="server" ToolTip="Maxmimum 2 MB file size" CssClass="form-control"></asp:FileUpload>
                                                <small class="text-danger">.pdf, .doc, .docx, .png, .jpg .jpeg formats are required</small><br />
                                                <%=strGovtImg %>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="text-start">
                                                <asp:LinkButton ID="btnUpdate" runat="server" class="ud-btn btn-thm" OnClick="btnUpdate_Click" Visible="false" ValidationGroup="save">Update<i class="fal fa-arrow-right-long"></i></asp:LinkButton>
                                                <asp:Label ID="lblThumb" runat="server" Visible="false"></asp:Label>
                                                <asp:Label ID="lblGovtID" runat="server" Visible="false"></asp:Label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <script src="js/jquery-3.6.0.min.js"></script>
    <script src="js/snackbar/snackbar.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            toggleSections();
        });
        function toggleSections() {
            var dropdown = document.getElementById("<%=ddlWhoAreYou.ClientID %>");
            var otherTextBoxContainer = document.getElementById("otherTextBoxContainer");
            var validator = document.getElementById("<%=rfv12.ClientID %>");

            if (dropdown.value === "Others") {
                otherTextBoxContainer.classList.remove("d-none");
                validator.enabled = true;
            } else {
                otherTextBoxContainer.classList.add("d-none");
                validator.enabled = false;
            }
        }
    </script>
</asp:Content>


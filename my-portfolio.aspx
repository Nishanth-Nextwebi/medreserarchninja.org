﻿<%@ Page Title="" Language="C#" MasterPageFile="User.master" AutoEventWireup="true" CodeFile="my-portfolio.aspx.cs" Inherits="my_portfolio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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

        .new-block {
            display: block !important;
        }

        .new-join {
            display: none;
        }

        .new-profile {
            display: flex !important;
        }

        .mobile_menu_bar .right-side {
            display: flex;
        }

        .new-profile .btn {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

            .new-profile .btn img {
                height: 36px;
                width: 36px;
            }

        .user-name span {
            line-height: 10px;
        }

        .new-head {
            height: 100px;
        }

        .dashboard__sidebar {
            margin-top: 0px;
            position: sticky;
            top: 0px;
        }

        .details h5 {
            font-family: "DM Sans", sans-serif;
        }

        .dashboard__main {
            margin-top: 0px;
            padding-left: 0px;
        }

        .bootstrap-select:not([class*=col-]):not([class*=form-control]):not(.input-group-btn) .btn, .bootstrap-select:not([class*=col-]):not([class*=form-control]):not(.input-group-btn) .btn-light {
            background-color: #fff;
            border-radius: 8px;
        }

        #lblStatus {
            font-size: 100px;
        }

        .form-control[type=file] {
            border-radius: 8px;
            border: 2px solid transparent;
            box-shadow: none;
            height: 53px;
            outline: 1px solid #E9E9E9;
            /* padding-left: 14px; */
            padding: 12px 20px;
        }

        .dashboard_sidebar_list .sidebar_list_item active {
            background: #222222;
        }

        @media (min-width:320px) and (max-width:767px) {
            .new-join {
                display: none;
            }

            .new-profile {
                display: flex !important;
            }
        }

        .pending-style.style6 {
            background-color: #F1FAFF;
            color: #00A3FF;
            /* width: 126px !important; */
            display: block;
        }
    </style>
    <link href="js/snackbar/snackbar.min.css" rel="stylesheet" />
    <link href="js/sweetalert2/sweetalert2.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="dashboard_content_wrapper">
        <div class="dashboard dashboard_wrapper ">
            <div class="dashboard__sidebar d-none d-lg-block">
                <div class="dashboard_sidebar_list">
                    <p class="fz15 fw400 ff-heading pl30">Member Dashboard</p>
                    <div class="sidebar_list_item">
                        <a href="general-information.aspx" class="items-center "><i class="flaticon-document mr15"></i>General Information</a>
                    </div>
                    <div class="sidebar_list_item">
                        <a href="member-profile.aspx" class="items-center"><i class="flaticon-home mr15"></i>My Profile</a>
                    </div>
                    <div class="sidebar_list_item">
                        <a href="my-projects.aspx" class="items-center"><i class="flaticon-like mr15"></i>My Projects</a>
                    </div>
                    <div class="sidebar_list_item">
                        <a href="recent-projects.aspx" class="items-center "><i class="flaticon-document mr15"></i>Recent Projects</a>
                    </div>
                    <div class="sidebar_list_item position-relative">
                        <a href="my-payment.aspx" class="items-center "><i class="flaticon-receipt mr15"></i>Projects Due</a><%= strDues %>
                    </div>
                    <div class="sidebar_list_item ">
                        <a href="my-discussion.aspx" class="items-center"><i class="flaticon-chat mr15"></i>My Discussion</a>
                    </div>
                    <div class="sidebar_list_item ">
                        <a href="my-blueprintrx.aspx" class="items-center"><i class="flaticon-review-1 mr15"></i>My BlueprintRX</a>
                    </div>
                    <div class="sidebar_list_item">
                        <a href="my-portfolio.aspx" class="items-center -is-active"><i class="flaticon-receipt mr15"></i>Build My Research Portfolio</a>
                    </div>
                    <div class="sidebar_list_item">
                        <a href="change-password.aspx" class="items-center"><i class="flaticon-presentation mr15"></i>Change Password</a>
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
                            <div class="dashboard_navigationbar d-block d-lg-none">
                                <div class="dropdown">
                                    <a onclick="myFunction()" class="dropbtn"><i class="fa fa-bars pr10"></i>Dashboard Navigation</a>
                                    <ul id="myDropdown" class="dropdown-content">
                                        <li>
                                            <p class="fz15 fw400 ff-heading mt30 pl30">Start</p>
                                        </li>
                                        <li><a href="/general-information.aspx" contenteditable="false" style="cursor: pointer;"><i class="flaticon-document mr10"></i>General Information</a></li>
                                        <li><a href="/member-profile.aspx" contenteditable="false" style="cursor: pointer;"><i class="flaticon-home mr10"></i>My Profile</a></li>
                                        <li><a href="/my-projects.aspx" contenteditable="false" style="cursor: pointer;"><i class="flaticon-receipt mr10"></i>My Projects</a></li>
                                        <li><a href="/recent-projects.aspx" contenteditable="false" style="cursor: pointer;"><i class="flaticon-chat mr10"></i>Recent Projects</a></li>
                                        <li><a href="/my-payment.aspx" contenteditable="false" style="cursor: pointer;"><i class="flaticon-review-1 mr10"></i>Projects Due</a><%= strDues %></li>
                                        <li><a href="/my-discussion.aspx" contenteditable="false" style="cursor: pointer;"><i class="flaticon-chat mr10"></i>My Discussion</a></li>
                                        <li><a href="/my-blueprintrx.aspx" contenteditable="false" style="cursor: pointer;"><i class="flaticon-review-1 mr10"></i>My BlueprintRX</a></li>
                                        <li class="active"><a href="/my-portfolio.aspx" contenteditable="false" style="cursor: pointer;"><i class="flaticon-receipt mr10"></i>Build My Research Portfolio</a></li>
                                        <li><a href="/change-password.aspx" contenteditable="false" style="cursor: pointer;"><i class="flaticon-presentation  mr10"></i>Change Password</a></li>

                                        <li>
                                            <asp:LinkButton ID="btnLogout" runat="server" class="items-center" OnClick="btnLogout_Click">
                                            <i class="flaticon-logout mr15"></i>Logout 
                                            </asp:LinkButton></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="ps-widget bgc-white bdrs4 p30 mb30 overflow-hidden position-relative">
                                <div class="bdrb1 pb15 mb25">
                                    <h5 class="list-title fw-bold">My Research Portfolio </h5>
                                </div>
                                <div class="col-lg-12 d-none">
                                    <h2>Coming Soon!</h2>
                                </div>
                                <div class="col-lg-12">
                                    <asp:Label ID="lblStatus" runat="server" Visible="false" Width="100%"></asp:Label>
                                    <form class="form-style1">
                                        <div class="row">

                                            <div class="col-sm-6">
                                                <div class="mb20">
                                                    <label class="heading-color ff-heading fw500 mb10">Title<sup class="text-danger">*</sup></label>
                                                    <asp:TextBox runat="server" class="form-control" ID="txtTitle" placeholder="Enter Portfolio title" MaxLength="100" />
                                                    <asp:RequiredFieldValidator ID="rfv1" runat="server" ControlToValidate="txtTitle" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="Save" ErrorMessage="Field can't be empty"></asp:RequiredFieldValidator>

                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="mb20">
                                                    <label class="heading-color ff-heading fw500 mb10">Status<sup class="text-danger">*</sup></label>
                                                    <asp:TextBox runat="server" class="form-control" ID="txtStatus" placeholder="Enter current payment status" MaxLength="100" />
                                                    <asp:RequiredFieldValidator ID="rfv2" runat="server" ControlToValidate="txtStatus" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="Save" ErrorMessage="Field can't be empty"></asp:RequiredFieldValidator>

                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-style1 mb20">
                                                    <asp:Label ID="lblResourceType" runat="server" CssClass="heading-color ff-heading fw500" Text="Resource Type"></asp:Label>
                                                    <sup class="text-danger">*</sup>
                                                    <div class="bootselect-multiselect">
                                                        <asp:DropDownList ID="ddlResourceType" runat="server" CssClass="selectpicker " onchange="toggleSections()">
                                                            <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                                            <asp:ListItem Text="Link" Value="Link"></asp:ListItem>
                                                            <asp:ListItem Text="PDF" Value="PDF"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:RequiredFieldValidator ID="rfv7" runat="server" ControlToValidate="ddlResourceType" InitialValue="" ErrorMessage="Please select a resource type" ForeColor="Red" Display="Dynamic" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>
                                            </div>


                                            <div class="col-sm-6 d-none" id="pdfUploadSection">
                                                <div class="mb20">
                                                    <label class="heading-color ff-heading fw500 mb10">Upload Pdf<sup class="text-danger">*</sup></label>
                                                    <asp:FileUpload ID="upldPdf" runat="server" ToolTip="Maxmimum 2 MB file size" CssClass="form-control"></asp:FileUpload>
                                                    <small class="text-danger">.pdf, .doc, .docx, .png, .jpg .jpeg formats are required</small><br />
                                                    <div id="divpdf" runat="server" visible="false">
                                                        <a href="/<%=strPdf %>" target="_blank">
                                                            <img src="images/pdf.png" alt="" width="65" height="60"></a><br />
                                                        Check PDF
                                                    </div>
                                                </div>
                                            </div>



                                            <div class="col-sm-6 d-none" id="linkSection">
                                                <div class="mb20">
                                                    <label class="heading-color ff-heading fw500 mb10">Add Link<sup class="text-danger">*</sup> </label>
                                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtLink" placeholder="Enter resource link" MaxLength="200" />
                                                </div>
                                            </div>

                                            <div class="col-md-12">
                                                <div class="text-start">
                                                    <asp:LinkButton ID="btnPortfolio" runat="server" CssClass="ud-btn btn-thm " OnClick="btnPortfolio_Click" Text="Add Portfolio" ValidationGroup="Save">Add Portfolio <i class="fal fa-arrow-right-long"></i></asp:LinkButton>
                                                    <asp:LinkButton runat="server" ID="btnNew" CssClass="ud-btn btn-thm" Visible="false" Text="Add New Portfolio" OnClick="btnNew_Click">Add New Portfolio <i class="fal fa-arrow-right-long"></i></asp:LinkButton>
                                                    <asp:Label ID="lblpdf" runat="server" Visible="false"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div class="ps-widget bgc-white bdrs4 p30 mb30 overflow-hidden position-relative">
                                <div class="packages_table table-responsive">
                                    <table class="table-style3 table at-savesearch">
                                        <thead class="t-head">
                                            <tr>
                                                <th scope="col">Name</th>
                                                <th scope="col">AddedOn</th>
                                                <th scope="col">status</th>
                                                <th scope="col">view Portfolio</th>
                                                <th scope="col">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody class="t-body">


                                            <%=strPortfolio %>
                                        </tbody>
                                    </table>

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
    <script src="js/sweetalert2/sweetalert2.all.min.js"></script>
    <script src="js/my-portfolio.js"></script>
    <script>
        function toggleSections() {
            var ddl = document.getElementById('<%= ddlResourceType.ClientID %>');
            var selectedValue = ddl.value;

            var pdfSection = document.getElementById("pdfUploadSection");
            var linkSection = document.getElementById("linkSection");

            pdfSection.classList.add("d-none");
            linkSection.classList.add("d-none");

            if (selectedValue === "PDF") {
                pdfSection.classList.remove("d-none");
            }
            else if (selectedValue === "Link") {
                linkSection.classList.remove("d-none");
            }
        }
    </script>
</asp:Content>



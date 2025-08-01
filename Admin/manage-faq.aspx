﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin/MasterPage.master" CodeFile="manage-faq.aspx.cs" Inherits="Manage_FAQ" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="page-content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">
                    <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                        <h4 class="mb-sm-0">Manage Faqs</h4>
                        <div class="page-title-right">
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="/Admin/">Dashboard</a></li>
                                <li class="breadcrumb-item"><a href="javascript: void(0);">Faq</a></li>
                                <li class="breadcrumb-item active">Manage Faqs</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-title"><%=Request.QueryString["id"] == null ? "Add " : "Update "%> Faq</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-lg-12">
                                    <label>Question<sup class="text-danger">*</sup></label>
                                    <asp:TextBox runat="server" MaxLength="100" CssClass="form-control mb-2 mr-sm-2" ID="txtQuestion" />
                                    <asp:RequiredFieldValidator ID="req1" runat="server" ControlToValidate="txtQuestion" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="Save" ErrorMessage="Field can't be empty"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-lg-12">
                                    <label>Faq Desc<sup class="text-danger">*</sup></label>
                                    <asp:TextBox runat="server" CssClass="form-control mb-2 mr-sm-2 summernote" TextMode="MultiLine" ID="txtDesc"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDesc" Display="Dynamic" ForeColor="Red" ValidationGroup="Save" ErrorMessage="Field can't be empty"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-lg-12">
                                    <asp:Button runat="server" ID="btnSave" CssClass="btn btn-secondary" Text="Save" ValidationGroup="Save" OnClientClick="tinyMCE.triggerSave(false, true);" OnClick="btnSave_Click" Style="margin-top: 15px;" />
                                    <asp:Button runat="server" ID="btnClear" CssClass="btn btn-outline-secondary" Text="Clear" Visible="false" OnClick="btnClear_Click" Style="margin-top: 15px;" />
                                </div>
                                <div class="col-lg-12 mt-2">
                                    <p style="color: red; font-weight: bold;"><sup></sup></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-title">Manage Faqs</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="table-responsive">
                                        <table class="table nowrap align-middle dt-responsive table-hover" style="width: 100%">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Question</th>
                                                    <th>Added On</th>
                                                    <th class="text-center">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbdy">
                                               <%=strFAQs%>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Question</th>
                                                    <th>Added On</th>
                                                    <th class="text-center">Action</th>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="assets/js/jquery-3.6.0.min.js"></script>
    <script src="assets/js/pages/manage-faqs.js"></script>
</asp:Content>

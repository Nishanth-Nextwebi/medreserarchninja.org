<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="discussion-forum.aspx.cs" Inherits="discussion_forum" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="/js/snackbar/snackbar.min.css" rel="stylesheet" />
    <link href="/css/discussion-forum.css" rel="stylesheet" />
    <style>
        .new-fade .modal:before {
            backdrop-filter: blur(10px);
        }

        .community-post .post-content .entry-content {
            flex: 2;
            width: 558px;
        }

        @media (min-width: 320px) and (max-width: 767px) {


            .community-post .post-content .entry-content {
    flex: 2;
    width: unset !important;
}
            .community-post {
                align-items: start !important;
            }
        }

        @media (min-width: 767px) and (max-width :991px) {

            .community-post .post-content .entry-content {
    flex: 2;
    width: unset !important;
}

            .community-post {
                align-items: start !important;
            }
        }

        ul.cats .badge {
            height: 26px;
            margin-left: 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="breadcumb-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcumb-style1">
                        <div class="breadcumb-list">
                            <a href="Default.aspx">Home</a>
                            <a href="#">Community</a>

                            <a href="#">Forums</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="section-padding">
        <div class="container">

            <div class="row align-items-center wow fadeInUp mt20" style="visibility: visible; animation-name: fadeInUp;">
                <div class="col-md-8 col-xl-6">
                    <div class="main-title">
                        <h2 class="title">Welcome to the    <span class="new-color">MedResearch Ninja Discussion Forum!</span>
                        </h2>
                        <p class="paragraph">
                            This space is designed for students, researchers, and professionals to connect and explore a range of topics related to USMLE, PLAB, and careers in research. Whether you're preparing for exams, considering a research career, or simply curious about the field, this forum is the place for you!

                        </p>
                        <p class="text">
                            Feel free to ask questions, share insights, and engage in discussions about your experiences and interests. Whether you're seeking advice on preparation strategies, exploring career paths in research, or just looking to connect with like-minded individuals, we encourage you to participate and contribute to our vibrant community.

                        </p>
                    </div>
                    <a href="#" class="ud-btn btn-white2 bdrs60 makepost" data-bs-toggle="modal">Make a post<i class="fal fa-arrow-right-long"></i></a>
                </div>
                <div class="col-md-4 col-xl-4 offset-xl-1">
                    <div class="text-center mt30-sm">
                        <img class="w-100 bdrs4" src="new-img/group-chat.png" alt="">
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="our-blog section-padding  bg-light ">
        <div class="container">
            <div class="row">
                <h3 class="mb30">Recent Forum Activity
                </h3>
                <div class="col-lg-8 col-md-6 strForums">
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="columns">
                        <div class="blog-sidebar ms-lg-auto">

                            <div class="price-widget">
                                <div class="navtab-style1">
                                    <nav>
                                        <div class="nav nav-tabs active mb20" id="nav-tab2p" role="tablist">
                                            <button class="nav-link active fw500" id="nav-item1p-tab" data-bs-toggle="tab" data-bs-target="#nav-item1p" type="button" role="tab" aria-controls="nav-item1p" aria-selected="true">Related Topics</button>
                                        </div>
                                    </nav>
                                    <div class="" id="nav-tabContent">
                                        <div class="tab-pane show active" id="nav-item1p" role="tabpanel" aria-labelledby="nav-item1p-tab">
                                            <div class="freelancer-style1  bdr0 hover-box-shadow row ms-0 align-items-start">
                                                <div class="col-xl-12 px-0">
                                                    <div class="">

                                                        <div class="blocktxt strTopics">
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
            </div>


        </div>
    </section>


    <div id="formSection">
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header text-center">
                        <h5 class="modal-title fw-bold" id="exampleModalLabel">Create a Post
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="fourm">
                            <div class="row">
                                <div class="col-lg-12 col-xl-12">
                                    <div class="ui-content mb20">
                                        <div class="form-style1">
                                            <input id="txtTitle" type="text" class="form-control" maxlenght="100" placeholder ="Title">
                                            <span class="spnttl text-danger"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12 col-xl-12">
                                    <div class="ui-content mb20">
                                        <div class="form-style1">
                                            <input id="txtTopic" type="text" class="form-control" maxlenght="100"  placeholder="Subject">
                                            <span class="spnsub text-danger"></span>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-12 col-xl-12">
                                    <div class="ui-content mb20">
                                        <div class="form-style1">
                                            <textarea name="text" id="textarea1" cols="30" rows="3" placeholder="Share your experience or get advice from other professionals."></textarea>
                                            <span class="spndesc text-danger"></span>
                                        </div>
                                    </div>
                                </div>

                                <div class="mt20">
                                    <button class="ud-btn btn-thm default-box-shadow2 btnSubmit" type="button">Submit <i class="fal fa-arrow-right-long"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <div class="new-fade">
        <div class="modal fade" id="exampleModal1" data-bs-backdrop="static" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body text-center p-5">
                        <h2>Login to Continue</h2>
                        <a href="login.aspx" class="ud-btn btn-thm mt-4 default-box-shadow2">Login <i class="fal fa-arrow-right-long"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="/js/snackbar/snackbar.min.js"></script>
    <script src="/js/jquery-3.6.4.min.js"></script>
    <script>
        $(document.body).on("click", ".makepost", function (e) {
            var isLoggedIn = document.cookie.indexOf('med_uid=') !== -1;
            if (!isLoggedIn) {
                $('#exampleModal1').modal('show');
            }
            else {
                $('#exampleModal').modal('show');
            }
        });
        $(document).ready(function () {
            BindDetails();
            $(document.body).on("click", ".btnSubmit", function (e) {
                e.preventDefault();
                var title = $("#txtTitle").val();
                var topic = $("#txtTopic").val();
                var description = $("#textarea1").val();

                $(".spnttl").html("");
                $(".spnsub").html("");
                $(".spndesc").html("");
                var count = 1;

                if (title === "") {
                    count = 0;
                    $(".spnttl").html("Please fill the field.");
                } if (topic === "") {
                    count = 0;
                    $(".spnsub").html("Please fill the field.");
                } if (description === "") {
                    count = 0;
                    $(".spndesc").html("Please fill the field.");
                }
                if (count === 1) {
                    $.ajax({
                        type: 'POST',
                        url: "discussion-forum.aspx/ForumDetails",
                        contentType: 'application/json; charset=utf-8',
                        dataType: "json",
                        //data: "{title: '" + title + "',topic: '" + topic + "',description : '" + description + "'}",
                        data: JSON.stringify({ title: title, topic: topic, description: description }),
                        success: function (response) {
                            if (response.d === "Success") {
                                Snackbar.show({ pos: 'top-right', text: 'Thank you for submitting the forum.you will recieve a mail once your forum is approved', actionTextColor: '#fff', backgroundColor: '#008A3D' });
                                $("#txtTitle").val("");
                                $("#txtTopic").val("");
                                $("#textarea1").val("");
                                $("#formSection").attr("aria-hidden", "true").addClass("hidden");
                               // window.location.reload();
                                BindDetails();
                            } else {
                                Snackbar.show({ pos: 'top-right', text: 'Please try again later.', actionTextColor: '#fff', backgroundColor: '#EA1C1C' });
                            }
                        },
                        error: function () {
                            Snackbar.show({ pos: 'top-right', text: 'Please try again later.', actionTextColor: '#fff', backgroundColor: '#EA1C1C' });
                        }
                    });
                }
            });
            $('.alphaonly').bind('keyup blur', function () {
                var node = $(this);
                node.val(node.val().replace(/[^A-Za-z_\s]/, ''));
            }   // (/[^a-z]/g,''
            );
        });
        function BindDetails() {
            $.ajax({
                type: 'POST',
                url: "discussion-forum.aspx/BindAllForums",
                contentType: 'application/json; charset=utf-8',
                dataType: "json",
                //data: "{title: '" + title + "',topic: '" + topic + "',description : '" + description + "'}",
                data: "{}",
                success: function (response) {
                    if (response.d === "Empty") {
                        $(".strForums").html("<div class='text-center'>No data to show.</div>")
                        $(".strTopics").html("<div class='text-center'>No data to show.</div>")
                    }
                    else if (response.d === "Error") {
                        Snackbar.show({ pos: 'top-right', text: 'There is some problem right now.Please try again later.', actionTextColor: '#fff', backgroundColor: '#EA1C1C' });
                        $(".strForums").html("<div class='text-center'>No data to show.</div>")
                        $(".strTopics").html("<div class='text-center'>No data to show.</div>")
                    }
                    else {
                        var data = $.parseJSON(response.d);
                        $(".strForums").html(data.Forum);
                        $(".strTopics").html(data.Topics);
                    }
                },
                error: function () {
                    Snackbar.show({ pos: 'top-right', text: 'There is some problem right now.Please try again later.', actionTextColor: '#fff', backgroundColor: '#EA1C1C' });
                }
            });

        }
    </script>
</asp:Content>


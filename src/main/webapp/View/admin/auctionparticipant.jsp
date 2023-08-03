<%-- 
    Document   : auctionparticipant
    Created on : Jul 9, 2023, 9:24:56 PM
    Author     : seyedhossein
--%>

<%@page import="java.util.List"%>
<%@page import="DatabaseManager.AuctionManager"%>
<%@page import="Model.AuctionTable"%>
<%@page import="DatabaseManager.AuctionParticipantManager"%>
<%@page import="Model.AuctionParticipantTable"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>auctionparticipant Page</title>
        <link href="/View/admin/assets/plugins/bootstrap/bootstrap.css" rel="stylesheet">
        <link href="/View/admin/assets/font-awesome/css/font-awesome.css" rel="stylesheet">
        <link href="/View/admin/assets/plugins/pace/pace-theme-big-counter.css" rel="stylesheet">
        <link href="/View/admin/assets/css/style.css" rel="stylesheet">
        <link href="/View/admin/assets/css/main-style.css" rel="stylesheet">
        <%
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            if (request.getParameter("auctionid") == null) {
                response.sendRedirect("/admin/auctionmanager");
                return;
            } else if (request.getParameter("auctionid") == "") {
                response.sendRedirect("/admin/auctionmanager");
            }
            int auctionId = Integer.parseInt(request.getParameter("auctionid"));
            AuctionTable auction = AuctionManager.getAuctionById(auctionId);
            List<AuctionParticipantTable> participant = null;
            if (auction != null)
                participant = AuctionParticipantManager.getAuctionAllParticipantById(auction.getId());
        %>
    </head>
    <body>
        <div id="wrapper">
            <%@include file="ConstPageSection/header.jspf" %>

            <div id="page-wrapper" style="text-align: right; direction: rtl;">
                <br/><br/><br/><br/>

                <div class="row" dir="rtl">
                    <!-- Page Header -->
                    <div class="col-lg-12">
                        <h1 class="page-header">شرکت کنندگان مزایده: <%=auction.getArtId().getName()%></h1>
                    </div>
                    <!--End Page Header -->
                </div>
                <div class="row" >

                </div>
                <%
                    if (auction == null) {
                %>
                ERROR
                <%} else {%>
                <div class="row">
                    <div class="col-lg-12">
                        <!--Collapsible Accordion Panel Group   -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                مزایده
                            </div>
                            <div class="panel-body">
                                <div class="panel-group" id="accordion">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" class="collapsed">اطلاعات اثر</a>
                                            </h4>
                                        </div>
                                        <div id="collapseOne" class="panel-collapse collapse" style="height: 0px;">
                                            <div class="panel-body">
                                                <div class="col-lg-12">
                                                    <!--  Blockquotes-->
                                                    <div class="panel panel-default">
                                                        <div class="panel-heading">
                                                            <%=auction.getArtId().getName()%>
                                                        </div>
                                                        <div class="panel-body">
                                                            <h4>آیدی</h4>
                                                            <blockquote>
                                                                <p><%=auction.getArtId().getId()%></p>
                                                            </blockquote>
                                                            <h4>نام اثر</h4>
                                                            <blockquote>
                                                                <p><%=auction.getArtId().getName()%></p>
                                                            </blockquote>
                                                            <h4>تصویر</h4>
                                                            <blockquote>
                                                                <p><a href="<%=auction.getArtId().getPhotoPath() != null ? "/images/arts/" + auction.getArtId().getPhotoPath() : "#"%>"  height="50" width="50">img</a></p>
                                                            </blockquote>
                                                            <h4>توضیحات</h4>
                                                            <blockquote>
                                                                <p><%=auction.getArtId().getDescription()%></p>
                                                            </blockquote>

                                                        </div>
                                                    </div>
                                                    <!-- End Blockquotes-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" class="">اطلاعات مزایده</a>
                                            </h4>
                                        </div>
                                        <div id="collapseTwo" class="panel-collapse collapse in" style="height: auto;">
                                            <div class="panel-body">
                                                <div class="col-lg-12">
                                                    <!--  Blockquotes-->
                                                    <div class="panel panel-default">
                                                        <div class="panel-heading">
                                                            مزایده
                                                        </div>
                                                        <div class="panel-body">
                                                            <h4>آیدی</h4>
                                                            <blockquote>
                                                                <p><%=auction.getId()%></p>
                                                            </blockquote>
                                                            <h4>تاریخ و زمان</h4>
                                                            <blockquote>
                                                                <p><%=dateFormat.format(auction.getStartDate())%></p>
                                                                <p><%=dateFormat.format(auction.getEndDate())%></p>
                                                            </blockquote>
                                                            <h4>وضعیت</h4>
                                                            <blockquote class="pull-right">
                                                                <p><%=auction.getStatus()%></p>
                                                            </blockquote>
                                                        </div>
                                                    </div>
                                                    <!-- End Blockquotes-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree" class="collapsed">شرکت کنندگان</a>
                                            </h4>
                                        </div>
                                        <div id="collapseThree" class="panel-collapse collapse" style="height: 0px;">
                                            <div class="panel-body">
                                                //asd
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--End Collapsible Accordion Panel Group   -->
                    </div>
                </div>
                <%=auction.getId()%>
                <%=participant.size()%>
                <%=participant%>
                <%}%>
            </div>
        </div>
        <script src="/View/admin/assets/plugins/jquery-1.10.2.js"></script>
        <script src="/View/admin/assets/plugins/bootstrap/bootstrap.min.js"></script>
        <script src="/View/admin/assets/plugins/metisMenu/jquery.metisMenu.js"></script>
        <script src="/View/admin/assets/plugins/pace/pace.js"></script>
        <script src="/View/admin/assets/scripts/siminta.js"></script>
    </body>
</html>

<%-- 
    Document   : auctionparticipant
    Created on : Jul 9, 2023, 9:24:56 PM
    Author     : seyedhossein
--%>

<%@page import="java.util.Date"%>
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
        <title>شرکت کنندگان مزایده</title>
        <link href="/View/assets/plugins/bootstrap/bootstrap.css" rel="stylesheet">
        <link href="/View/assets/font-awesome/css/font-awesome.css" rel="stylesheet">
        <link href="/View/assets/plugins/pace/pace-theme-big-counter.css" rel="stylesheet">
        <link href="/View/assets/css/style.css" rel="stylesheet">
        <link href="/View/assets/css/main-style.css" rel="stylesheet">
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
                <%
                    if (auction == null) {
                %>
                ERROR
                <%} else {%>
                <div class="row" dir="rtl">
                    <!-- Page Header -->
                    <div class="col-lg-12">
                        <h1 class="page-header" style="opacity: 50%;">شرکت کنندگان مزایده: <%=auction.getId() %></h1>
                    </div>
                    <!--End Page Header -->
                </div>
                <div class="row" >

                </div>


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
                                                            <h4>قیمت پایه</h4>
                                                            <blockquote>
                                                                <p><%=auction.getLimitPrice()%></p>
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
                                                <div class="col-lg-12">
                                                    <!--    Context Classes  -->
                                                    <div class="panel panel-default">

                                                        <div class="panel-heading">
                                                            Context Classes
                                                        </div>

                                                        <div class="panel-body">
                                                            <div class="table-responsive">
                                                                <table class="table" >
                                                                    <thead>
                                                                        <tr>
                                                                            <th style="text-align: right; direction: rtl;">آیدی</th>
                                                                            <th style="text-align: right; direction: rtl;">کد کاربر</th>
                                                                            <th style="text-align: right; direction: rtl;">نام کاربر</th>
                                                                            <th style="text-align: right; direction: rtl;">تاریخ ثبت</th>
                                                                            <th style="text-align: right; direction: rtl;">قیمت پیشنهادی</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <%
                                                                            Date nowDate = new Date();
                                                                            boolean done = false, winner = true;
                                                                            if (auction.getEndDate().before(nowDate)) {
                                                                                done = true;
                                                                            }
                                                                            for (AuctionParticipantTable partic : participant) {
                                                                                if (done && winner == true) {
                                                                                    winner = false;
                                                                        %>
                                                                        <tr class="success">
                                                                            <td><%=partic.getId()%></td>
                                                                            <td><%=partic.getUserId().getId()%></td>
                                                                            <td><%=partic.getUserId().getFullname() != null ? partic.getUserId().getFullname() : ""%></td>
                                                                            <td><%=dateFormat.format(partic.getPerposedDatetime())%></td>
                                                                            <td><%=partic.getPerposedPrice()%></td>
                                                                        </tr>
                                                                        <%} else {%>
                                                                        <tr>
                                                                            <td><%=partic.getId()%></td>
                                                                            <td><%=partic.getUserId().getId()%></td>
                                                                            <td><%=partic.getUserId().getFullname() != null ? partic.getUserId().getFullname() : ""%></td>
                                                                            <td><%=dateFormat.format(partic.getPerposedDatetime())%></td>
                                                                            <td><%=partic.getPerposedPrice()%></td>
                                                                        </tr>
                                                                        <%}
                                                                            }%>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--  end  Context Classes  -->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--End Collapsible Accordion Panel Group   -->
                    </div>
                </div>
                <%}%>
            </div>
        </div>
        <script src="/View/assets/plugins/jquery-1.10.2.js"></script>
        <script src="/View/assets/plugins/bootstrap/bootstrap.min.js"></script>
        <script src="/View/assets/plugins/metisMenu/jquery.metisMenu.js"></script>
        <script src="/View/assets/plugins/pace/pace.js"></script>
        <script src="/View/assets/scripts/siminta.js"></script>
    </body>
</html>



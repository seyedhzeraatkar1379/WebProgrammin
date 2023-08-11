<%-- 
    Document   : auctiondescription
    Created on : Aug 10, 2023, 1:32:34 PM
    Author     : hossein
--%>

<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="DatabaseManager.AuctionParticipantManager"%>
<%@page import="Model.AuctionParticipantTable"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="DatabaseManager.AuctionManager"%>
<%@page import="Model.AuctionTable"%>
<%@page import="Model.UserTable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        UserTable user = request.getSession().getAttribute("user") != null ? (UserTable) request.getSession().getAttribute("user") : null;
        int aucid = -1;
        if(user == null){
            response.sendRedirect("/user/login");
            return;
        }
        else if (request.getParameter("aucid") != null) {
            aucid = Integer.parseInt(request.getParameter("aucid"));
            if (aucid < 0) {
                response.sendRedirect("/");
                return;
            }
        }
        else
        {
        response.sendRedirect("/");
                return;
        }
        AuctionTable auction = AuctionManager.getAuctionById(aucid);
        if (auction == null) {
            response.sendRedirect("/");
            return;
        }
        SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        Date today = new Date();

    %>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>صفحه اصلی</title>
        <%@include file="constpage/headercssjs.jspf" %>
        <style>

            @font-face{
                font-family: 'Vazir';
                src: url('fonts/Vazir.ttf') format('truetype'),
                    url('fonts/Vazir.woff') format('woff'),
                    url('fonts/Vazir.woff2') format('woff2');
            }


            body * {
                font-family: 'Vazir', sans-serif;
                direction: rtl;
            }

            .col-md-3 {
                margin-bottom: 10px;
            }

            div#navbarNav {
                display: flex;
                justify-content: space-between;
            }
            li.nav-item * {
                display: inline-block;
            }
        </style>
    </head>
    <body>
        <%@include file="constpage/headermenu.jspf" %>
        <!-- قسمت سمت چپ با 4 بخش -->
        <div class="container mt-5">
            <div class="row">

                <div class="col-md-6">
                    <h2>جزئیات مزایده</h2>
                    <!-- بخش توضیحات -->
                    <h4>توضیحات</h4>
                    <p><%=auction.getArtId().getDescription()%></p>
                    <!-- بخش قیمت محصول -->
                    <h4>قیمت پایه مزایده </h4>
                    <p>قیمت محصول: 100,000 تومان</p>
                    <h4>تاریخ برگزاری</h4>
                    <p><%=dateformat.format(auction.getStartDate())%></p>
                    <p><%=dateformat.format(auction.getEndDate())%></p>
                    <%
                        if (today.after(auction.getStartDate())) {
                    %>
                    <!-- بخش لیست نفرات شرکت‌کننده در مزایده -->
                    <h4>لیست نفرات شرکت‌کننده در مزایده</h4>
                    <ul>
                        <%
                            List<AuctionParticipantTable> particList = AuctionParticipantManager.getAuctionAllParticipantById(aucid);
                            if (particList != null) {
                                if (particList.size() > 4) {
                                    particList = particList.subList(0, 3);
                                }
                                int i = 1;
                                for (AuctionParticipantTable partc : particList) {
                        %>
                        <li>نفر <%=i++%> => قیمت <%=partc.getPerposedPrice()%></li>
                            <%}
                                }%>  
                    </ul>
                    <%
                        if (today.before(auction.getEndDate())) {
                    %>
                    <!-- فرم ورود عدد پیشنهادی -->
                    <h4>پیشنهاد خود را وارد کنید</h4>
                    <form action="/user/participate" method="get">
                        <div class="form-group">
                            <input type="number" class="form-control" name="price" placeholder="عدد پیشنهادی خود را وارد کنید">
                        </div>
                        <input type="hidden" class="form-control" name="auctionid" value="<%=auction.getId()%>">
                        <br/>
                        <button type="submit" class="btn btn-primary">ثبت پیشنهاد</button>
                    </form>
                    <%}
                        }%>
                </div>
                <!-- قسمت سمت راست با تصویر محصول -->
                <div class="col-md-6">
                    <img src="/images/arts/<%=auction.getArtId().getPhotoPath()%>" class="img-fluid" alt="تصویر محصول">
                </div>
            </div>
        </div>
        <%@include file="constpage/footer.jspf" %>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            // کد جاوااسکریپت برای ایجاد اسلایدر متحرک
            $(document).ready(function () {
                const carouselItems = $('.carousel-item');
                let currentIndex = 0;

                // تابعی برای نمایش اسلاید بعدی
                function showNextSlide() {
                    $(carouselItems[currentIndex]).removeClass('active');
                    currentIndex = (currentIndex + 1) % carouselItems.length;
                    $(carouselItems[currentIndex]).addClass('active');
                }

                // استفاده از تابع showNextSlide به صورت تکراری برای ایجاد اسلایدر متحرک
                setInterval(showNextSlide, 5000); // هر 5 ثانیه یک اسلاید جدید نمایش داده می‌شود
            });
        </script>
    </body>
</html>


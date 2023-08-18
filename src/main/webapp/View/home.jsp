<%-- 
    Document   : index.jsp
    Created on : Jun 30, 2023, 6:42:16 PM
    Author     : seyedhossein
--%>

<%@page import="Enum.ActiveOrDeactive"%>
<%@page import="DatabaseManager.AuctionManager"%>
<%@page import="java.util.List"%>
<%@page import="Model.AuctionTable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="fa">
    <%
        List<AuctionTable> auctionTodo = AuctionManager.getAuctionActiveToDo();
        List<AuctionTable> auctionDoing = AuctionManager.getAuctionActiveDoing();
        List<AuctionTable> auctionDone = AuctionManager.getAuctionActiveDone();
        %>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>صفحه اصلی</title>
        <link rel="stylesheet" href="/View/css/bootstrap.min.css">
        <%@include file="constpage/headercssjs.jspf" %>
        <!-- اضافه کردن فونت Vazir از طریق CDN -->

        <style>

            @font-face{
                font-family: 'Vazir';
                src: url('View/fonts/Vazir.ttf') format('truetype'),
                    url('View/fonts/Vazir.woff') format('woff'),
                    url('View/fonts/Vazir.woff2') format('woff2');
            }

            /* این قسمت برای ایجاد اسلایدر متحرک است */
            .carousel-item {
                display: none;
            }

            .carousel-item.active {
                display: block;
            }

            @keyframes fadeInOut {
                0% {
                    opacity: 0;
                }
                25% {
                    opacity: 1;
                }
                75% {
                    opacity: 1;
                }
                100% {
                    opacity: 0;
                }
            }


            .carousel-caption {
                text-align: right;
                direction: rtl;
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
        <%@include file="constpage/headerslider.jspf"%>
        <!-- 7 بخش جدید با گروسل و چرخشی -->
        <%
            if (auctionDoing != null)
                if (auctionDoing.size() > 0) {
        %>
        <div class="container mt-5">

            <h2>مزایده های جاری <span><a href="/auctions?type=doing" style="font-size: 15px;">کلیک کنید</a></span></h2>
            <div class="row">
                <%                    int i = 0;
                    for (AuctionTable auc : auctionDoing) {
                        if (i > 3) {
                            break;
                        }
                        if (auc.getStatus() != ActiveOrDeactive.DEACTIVE) {

                %>
                <div class="col-md-3">
                    <div class="card">
                        <img src="<%=auc.getArtId().getPhotoPath() != null ? "/images/arts/" + auc.getArtId().getPhotoPath() : "/View/images/default_art_image.jpg"%>" onerror="this.src='/View/images/default_art_image.jpg'"/>
                        <div class="card-body">
                            <h5 class="card-title"><%=auc.getArtId().getName()%></h5>
                            <p class="card-text"><%=auc.getArtId().getDescription().substring(0, Math.min(auc.getArtId().getDescription().length(), 15))%></p>
                            <a href="/user/auctiondescp?aucid=<%=auc.getId()%>" class="btn btn-primary">شرکت در مزایده</a>
                        </div>
                    </div>
                </div>
                <%                            i++;
                        }
                    }%>
            </div>
        </div>
        <%}%>
        <!-- 7 بخش جدید با گروسل و چرخشی -->
        <%
            if (auctionDone != null)
                if (auctionDone.size() > 0) {

        %>
        <div class="container mt-5">

            <h2>مزایده های تمام شده <span><a href="/auctions?type=done" style="font-size: 15px;">کلیک کنید</a></span></h2>
            <div class="row">
                <%                    int i = 0;
                    for (AuctionTable auc : auctionDone) {
                        if (i > 3) {
                            break;
                        }
                        if (auc.getStatus() != ActiveOrDeactive.DEACTIVE) {

                %>
                <div class="col-md-3">
                    <div class="card">
                        <img src="<%=auc.getArtId().getPhotoPath() != null ? "/images/arts/" + auc.getArtId().getPhotoPath() : "/View/images/default_art_image.jpg"%>" onerror="this.src='/View/images/default_art_image.jpg'"/>
                        <div class="card-body">
                            <h5 class="card-title"><%=auc.getArtId().getName()%></h5>
                            <p class="card-text"><%=auc.getArtId().getDescription().substring(0, Math.min(auc.getArtId().getDescription().length(), 15))%></p>
                            <a href="/user/auctiondescp?aucid=<%=auc.getId()%>" class="btn btn-primary">مشاهده</a>
                        </div>
                    </div>
                </div>
                <%i++;
                        }
                    }%>
            </div>
        </div>
        <%}%>
        <!-- 7 بخش جدید با گروسل و چرخشی -->
        <%
            if (auctionTodo != null)
                if (auctionTodo.size() > 0) {

        %>
        <div class="container mt-5">
            <h2>مزایده های پیش رو <span><a href="/auctions?type=todo" style="font-size: 15px;">کلیک کنید</a></span></h2>
            <div class="row">
                <%                    int i = 0;
                    for (AuctionTable auc : auctionTodo) {
                        if (i > 3) {
                            break;
                        }
                        if (auc.getStatus() != ActiveOrDeactive.DEACTIVE) {
                %>
                <div class="col-md-3">
                    <div class="card">
                        <img src="<%=auc.getArtId().getPhotoPath() != null ? "/images/arts/" + auc.getArtId().getPhotoPath() : "/View/images/default_art_image.jpg"%>" onerror="this.src='/View/images/default_art_image.jpg'"/>
                        <div class="card-body">
                            <h5 class="card-title"><%=auc.getArtId().getName()%></h5>
                            <p class="card-text"><%=auc.getArtId().getDescription().substring(0, Math.min(auc.getArtId().getDescription().length(), 15))%></p>
                            <a href="/user/auctiondescp?aucid=<%=auc.getId()%>" class="btn btn-primary">مشاهده</a>
                        </div>
                    </div>
                </div>
                <%i++;
                        }
                    }%>
            </div>
        </div>
        <%}%>
        <%@include file="constpage/footer.jspf"%>



        <script src="View/js/jquery-3.6.0.min.js"></script>
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


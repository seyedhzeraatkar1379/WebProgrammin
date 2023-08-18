<%-- 
    Document   : auction
    Created on : Aug 10, 2023, 12:09:54 PM
    Author     : hossein
--%>

<%@page import="Enum.ActiveOrDeactive"%>
<%@page import="DatabaseManager.AuctionManager"%>
<%@page import="java.util.List"%>
<%@page import="Model.AuctionTable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="fa">
    <%
        int pageAuc = request.getParameter("page")!=null?Integer.parseInt(request.getParameter("page")):1;
        String AuctionT = request.getParameter("type") != null ? request.getParameter("type") : "";
        String typeAuctionShow = "";
        List<AuctionTable> auctionList = null;
        if (AuctionT == "") {
            response.sendRedirect("/");
            return;
        } else if (AuctionT.compareTo("todo") == 0) {
            typeAuctionShow = "پیش رو";
            auctionList = AuctionManager.getAuctionActiveToDo();
        } else if (AuctionT.compareTo("doing") == 0) {
            typeAuctionShow = "در حال انجام";
            auctionList = AuctionManager.getAuctionActiveDoing();
        } else if (AuctionT.compareTo("done") == 0) {
            typeAuctionShow = "تمام شده";
            auctionList = AuctionManager.getAuctionActiveDone();
        } else {
            response.sendRedirect("/");
            return;
        }
    %>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>مزایده ها: <%=typeAuctionShow%></title>
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
        <%@include file="constpage/headermenu.jspf"%>

        <!-- 7 بخش جدید با گروسل و چرخشی -->
        <div class="container mt-5">
            <h2>مزایده ها <%=typeAuctionShow%> </h2>
            <div class="row">
                <%if (auctionList != null)
                        for (int i = 0 ,j = 0; j < 12 && i < auctionList.size() ; i++)
                            if (auctionList.get(i).getStatus() != ActiveOrDeactive.DEACTIVE) {
                            j++;

                %>
                <div class="col-md-3">
                    <div class="card">
                        <img src="<%=auctionList.get(i).getArtId().getPhotoPath()!=null?"/images/arts/"+auctionList.get(i).getArtId().getPhotoPath():"/View/images/default_art_image.jpg"%>" onerror="this.src='/View/images/default_art_image.jpg'"/>
                        <div class="card-body">
                            <h5 class="card-title">نام: <%=auctionList.get(i).getArtId().getName()%><sub>(id: <%=auctionList.get(i).getArtId().getId()%>)</sub></h5>
                            <p class="card-text">توضیحات: <%=auctionList.get(i).getArtId().getDescription().substring(0, Math.min(auctionList.get(i).getArtId().getDescription().length(), 15))%></p>
                            <%=AuctionT.compareTo("doing") == 0 ? "<a href=\"/user/auctiondescp?aucid=" + auctionList.get(i).getId() + "\" class=\"btn btn-primary\">شرکت در مزایده</a>" : ""%>
                        </div>
                    </div>
                </div>
                <%}%>
            </div>
        </div>

        <%@include file="constpage/footer.jspf"%>



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

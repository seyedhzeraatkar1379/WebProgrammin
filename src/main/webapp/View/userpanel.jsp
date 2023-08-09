<%-- 
    Document   : userpanel
    Created on : Aug 7, 2023, 2:13:34 AM
    Author     : hossein
--%>

<%@page import="Model.UserTable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="fa">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>صفحه اصلی</title>

        <link rel="stylesheet" href="/View/styles1.css">
        <link rel="stylesheet" href="/View/bootstrap.min.css">

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
        <%@include file="headermenu.jspf" %>
        <div class="container">
            <%
                UserTable user = (UserTable) request.getSession().getAttribute("user");
            %>
            <div class="form">
                <h2>تکمیل اطلاعات کاربری</h2>
                <form action="/user/updateuser" method="post">
                    <img src="/View/images/image.jpg" alt="عکس ورود" class="form-image">
                    <label for="id">id:</label>
                    <input type="number" id ="id" value="<%=user.getId()%>" disabled>
                    <label for="email">ایمیل:</label>
                    <input type="text" name="email" value="<%=user.getEmail()%>" disabled>
                    <label for="passwrod">رمز ورود:</label>
                    <input type="text" name ="passwrod" value="***" disabled>
                    <label for="fullname">نام کامل:</label>
                    <input name="fullName" id="fullname" type="text" placeholder="نام" value="<%=user.getFullname() != null ? user.getFullname() : ""%>" />
                    <label for="mobile">شماره موبایل:</label>
                    <input name="phoneNumber" id="mobile" type="tel" placeholder="تلفن" value="<%=user.getPhoneNumber() != null ? user.getPhoneNumber() : ""%>"/>
                    <label for="address">آدرس:</label>
                    <textarea id="address" name="address" required><%=user.getAddress() != null ? user.getAddress() : ""%></textarea>
                    <label for="idcardcode">کد ملی:</label>
                    <input name="idCardCode" type="text" id="idcardcode" placeholder="کد ملی" value="<%=user.getIdCardCode() != null ? user.getIdCardCode() : ""%>"/>

                    <input type="submit" value="ثبت اطلاعات">
                </form>
            </div>
        </div>
        <!-- فوتر با سه بخش -->
        <%@include file="footer.jspf" %>
    </body>
</html>

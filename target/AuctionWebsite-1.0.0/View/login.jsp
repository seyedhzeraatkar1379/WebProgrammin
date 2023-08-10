<%-- 
    Document   : login
    Created on : Jul 21, 2023, 4:06:36 AM
    Author     : hossein
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="fa">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>فرم ورود و عضویت</title>
        <link rel="stylesheet" href="/View/css/bootstrap.min.css">
        <link rel="stylesheet" href="/View/css/styles.css">



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

        <div class="container">
            <div class="form">
                <img src="/View/images/image.jpg" alt="عکس ورود" class="form-image">
                <h2>ورود به حساب کاربری</h2>
                <form action="/user/logincheck" method="post">
                    <label for="username">نام کاربری:</label>
                    <input type="email" id="username" name="enaillogin" required>
                    <label for="password">رمز عبور:</label>
                    <input type="password" id="password" name="passwordlogin" required>
                    <input type="submit" value="ورود">
                </form>
            </div>
            <div class="form">
                <img src="/View/images/image.jpg" alt="عکس عضویت" class="form-image">
                <h2>عضویت در سایت</h2>
                <form method="post" action="/user/register">
                    <label for="email">ایمیل:</label>
                    <input type="email" id="email" name="email" required>
                    <label for="new_password">رمز عبور جدید:</label>
                    <input type="password" id="new_password" name="password" required>
                    <label for="new_confirmpassword">تکرار رمز عبور:</label>
                    <input type="password" id="new_confirmpassword" name="confirmpassword" required>
                    <label for="commitment">تایید قوانین</label>
                    <input type="checkbox" id="commitment" name="commitment" value="1"/>

                    <input type="submit" value="ثبت نام">
                </form>
            </div>
        </div>
        <%@include file="constpage/footer.jspf" %>
    </body>
</html>

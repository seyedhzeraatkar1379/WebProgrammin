<%-- 
    Document   : auctiondescriptionshow
    Created on : Aug 10, 2023, 9:23:43 PM
    Author     : hossein
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fa">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>صفحه اصلی</title>

  <link rel="stylesheet" href="bootstrap.min.css">

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
    <!-- منو -->
	
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
	<div class="container">
        <a class="navbar-brand" href="#">نام سایت</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item active">
                    <a class="nav-link" href="index.html">صفحه اصلی</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="category.html">مزایده ها</a>
                </li>
           
			
            </ul>
			
			       <ul class="navbar-nav">
				   	<li class="nav-item">
							  <img src="images/register.png" class="register" >
                    <a class="nav-link" href="register.html">ورود و عضویت</a>
                </li>
				   
                <li class="nav-item active">
				  <img src="images/user.png" class="register" >
                    <a class="nav-link" href="profile.html">پروفایل کاربری</a>
                </li>
              
            </ul>
        </div></div>
    </nav>

 <!-- قسمت سمت چپ با 4 بخش -->
    <div class="container mt-5">
        <div class="row">
		
            <div class="col-md-6">
                <h2>جزئیات مزایده</h2>
                <!-- بخش توضیحات -->
                <h4>توضیحات</h4>
                <p>اینجا توضیحات کامل درباره محصول قرار می‌گیرد.</p>
                <!-- بخش قیمت محصول -->
                <h4>قیمت پایه مزایده </h4>
                <p>قیمت محصول: 100,000 تومان</p>
                <!-- بخش لیست نفرات شرکت‌کننده در مزایده -->
                <h4>لیست نفرات شرکت‌کننده در مزایده</h4>
                <ul>
                    <li>نفر 1</li>
                    <li>نفر 2</li>
                    <li>نفر 3</li>
                    <li>نفر 4</li>
                </ul>
                <!-- فرم ورود عدد پیشنهادی -->
                <h4>پیشنهاد خود را وارد کنید</h4>
                <form>
                    <div class="form-group">
                        <input type="number" class="form-control" placeholder="عدد پیشنهادی خود را وارد کنید">
                    </div>
                    <button type="submit" class="btn btn-primary">ثبت پیشنهاد</button>
                </form>
            </div>
            <!-- قسمت سمت راست با تصویر محصول -->
            <div class="col-md-6">
                <img src="images/product_image.jpg" class="img-fluid" alt="تصویر محصول">
            </div>
        </div>
    </div>
   <!-- فوتر با سه بخش -->
    <footer class="bg-dark text-light text-center py-3 mt-5">
        <div class="container">
            <!-- بخش توضیحات -->
            <div class="row">
                <div class="col-md-4">
                    <h4>توضیحات</h4>
                    <p>اینجا توضیحات کلی درباره سایت و فعالیت‌های ما قرار می‌گیرد.</p>
                </div>
                <!-- بخش پیوندها -->
                <div class="col-md-4">
                    <h4>پیوندها</h4>
                    <ul class="list-unstyled">
                        <li><a href="#">صفحه اصلی</a></li>
                        <li><a href="#">محصولات</a></li>
                        <li><a href="#">تماس با ما</a></li>
                    </ul>
                </div>
                <!-- بخش اطلاعات تماس -->
                <div class="col-md-4">
                    <h4>اطلاعات تماس</h4>
                    <p>آدرس: تهران، خیابان اصلی، کد پستی 12345</p>
                    <p>تلفن: 021-12345678</p>
                </div>
            </div>
        </div>
		
		        <p>تمامی حقوق محفوظ است - نام سایت ۲۰۲۳</p>
    </footer>
	



    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        // کد جاوااسکریپت برای ایجاد اسلایدر متحرک
        $(document).ready(function() {
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

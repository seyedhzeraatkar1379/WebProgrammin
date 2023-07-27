<%-- 
    Document   : homePage
    Created on : Jun 30, 2023, 8:21:09 PM
    Author     : seyedhossein
--%>

<%@page import="Enum.AdminErrorLogin"%>
<%@page import="Model.AdminTable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        AdminTable admin = (AdminTable) request.getSession().getAttribute("admin");
    %>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <!-- Core CSS - Include with every page -->
        <link href="/View/admin/assets/plugins/bootstrap/bootstrap.css" rel="stylesheet" />
        <link href="/View/admin/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
        <link href="/View/admin/assets/plugins/pace/pace-theme-big-counter.css" rel="stylesheet" />
        <link href="/View/admin/assets/css/style.css" rel="stylesheet" />
        <link href="/View/admin/assets/css/main-style.css" rel="stylesheet" />
        <!-- Page-Level CSS -->
        <link href="/View/admin/assets/plugins/morris/morris-0.4.3.min.css" rel="stylesheet" />
    </head>
    <body>
        <!--  wrapper -->
        <div id="wrapper">
            <%@include file="ConstPageSection/header.jspf" %>
            <!--  page-wrapper -->
            <div id="page-wrapper" >
                <br/><br/><br/><br/>

                <div class="row" dir="rtl">
                    <!-- Page Header -->
                    <div class="col-lg-12">
                        <h1 class="page-header">صفحه اصلی</h1>
                    </div>
                    <!--End Page Header -->
                </div>

                <div class="row">
                    <!--quick info section -->
                    <div class="col-lg-3">
                        <div class="alert alert-danger text-center">
                            <i class="fa fa-calendar fa-3x"></i>&nbsp;<b id="current_date"></b>امروز

                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="alert alert-success text-center">
                            <i class="fa fa-spinner fa-3x"></i>&nbsp;<b>50</b>&nbsp;مزایده های در حال انجام 
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="alert alert-info text-center">
                            <i class="fa fa-check-circle fa-3x"></i>&nbsp;<b>50</b>&nbsp; مزایده های به پایان رسیده
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="alert alert-warning text-center">
                            <i class="fa fa-exclamation-circle	  fa-3x"></i>&nbsp;<b>50</b>&nbsp;مزایده های شروع نشده
                        </div>
                    </div>
                    <!--end quick info section -->
                </div>

                <div class="row">
                    <div class="col-lg-8">
                        <!-- end page-wrapper -->
                        <form action="/admin/changepassword" method="post">
                            <input type="text" placeholder="Current Password..." name="currentPassword"/>
                            <input type="password" placeholder="New Password..." name="newPassword"/>
                            <input type="password" placeholder="Repeat new Password..." name="newPasswordRepeat"/>
                            <input type="submit"/>
                        </form>
                        <%if (request.getParameter("error") != null) {%>
                        <%if (request.getParameter("error").compareTo(Integer.toString(AdminErrorLogin.PasswordIncorrect.ordinal())) == 0) {%>
                        <h3>Current Password invalid</h3>
                        <%} else if (request.getParameter("error").compareTo(Integer.toString(AdminErrorLogin.PasswordNotMatch.ordinal())) == 0) {%>
                        <h3>Password does not Match</h3>
                        <%}
                            }%>
                    </div>

                    <div class="col-lg-4">
                        <div class="panel panel-primary text-center no-boder">
                            <div class="panel-body yellow">
                                <i class="fa fa-user fa-3x"></i>
                                <h3>20,741 </h3>
                            </div>
                            <div class="panel-footer">
                                <span class="panel-eyecandy-title">کاربران
                                </span>
                            </div>
                        </div>
                        <div class="panel panel-primary text-center no-boder">
                            <div class="panel-body red">
                                <i class="fa fa-users fa-3x"></i>
                                <h3>20,741 </h3>
                            </div>
                            <div class="panel-footer">
                                <span class="panel-eyecandy-title">شرکت کنندگان
                                </span>
                            </div>
                        </div>
                        
                    </div>

                </div>




            </div>

        </div>
        <!-- end wrapper -->
        <script>
            var currDate = new Date();
            document.getElementById("current_date").innerHTML = currDate.getFullYear() + "/"+currDate.getMonth() +"/"+ currDate.getDate();
        </script>
        <!-- Core Scripts - Include with every page -->
        <script src="/View/admin/assets/plugins/jquery-1.10.2.js"></script>
        <script src="/View/admin/assets/plugins/bootstrap/bootstrap.min.js"></script>
        <script src="/View/admin/assets/plugins/metisMenu/jquery.metisMenu.js"></script>
        <script src="/View/admin/assets/plugins/pace/pace.js"></script>
        <script src="/View/admin/assets/scripts/siminta.js"></script>
        <!-- Page-Level Plugin Scripts-->
        <script src="/View/admin/assets/plugins/morris/raphael-2.1.0.min.js"></script>
        <script src="/View/admin/assets/plugins/morris/morris.js"></script>
        <script src="/View/admin/assets/scripts/dashboard-demo.js"></script>

    </body>

</html>

<%-- 
    Document   : homePage
    Created on : Jun 30, 2023, 8:21:09 PM
    Author     : seyedhossein
--%>

<%@page import="DatabaseManager.AuctionParticipantManager"%>
<%@page import="DatabaseManager.UserManager"%>
<%@page import="DatabaseManager.AuctionManager"%>
<%@page import="Enum.StatusQuery"%>
<%@page import="Enum.ActiveOrDeactive"%>
<%@page import="DatabaseManager.AdminManager"%>
<%@page import="Model.AdminTable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>پنل ادمین</title>
        <!-- Core CSS - Include with every page -->
        <link href="/View/assets/plugins/bootstrap/bootstrap.css" rel="stylesheet" />
        <link href="/View/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
        <link href="/View/assets/plugins/pace/pace-theme-big-counter.css" rel="stylesheet" />
        <link href="/View/assets/css/style.css" rel="stylesheet" />
        <link href="/View/assets/css/main-style.css" rel="stylesheet" />
        <!-- Page-Level CSS -->
        <link href="/View/assets/plugins/morris/morris-0.4.3.min.css" rel="stylesheet" />
    </head>
    <body>
        <%
            AdminTable adminInfo = ((AdminTable) request.getSession().getAttribute("admin"));
        %>
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
                            <i class="fa fa-calendar fa-3x"></i>&nbsp;<b id="current_date"></b>تاریخ امروز

                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="alert alert-success text-center">
                            <i class="fa fa-spinner fa-3x"></i>&nbsp;<b><%=(int) AuctionManager.getNumberOFAuctionActiveDoing()%></b>&nbsp; در حال انجام
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="alert alert-info text-center">
                            <i class="fa fa-check-circle fa-3x"></i>&nbsp;<b><%=(int) AuctionManager.getNumberOFAuctionActiveDone()%></b>&nbsp; انجام شده
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="alert alert-warning text-center">
                            <i class="fa fa-exclamation-circle	  fa-3x"></i>&nbsp;<b><%=(int) AuctionManager.getNumberOFAuctionActiveToDo()%></b>&nbsp; شروع نشده
                        </div>
                    </div>
                    <!--end quick info section -->
                </div>

                <div class="row">
                    <div class="col-lg-8">
                        <div class="row">

                        </div>
                        <div class="row">
                            <div class="col-lg-6" dir="rtl" style="text-align: center;">
                                <div class="col-lg-12">
                                    <fieldset disabled="disabled" >
                                        <div class="form-group">
                                            <label for="disabledSelect">id</label>
                                            <input class="form-control" id="disabledInput" type="number" placeholder="<%=adminInfo.getId()%>" disabled>
                                        </div>
                                        <div class="form-group">
                                            <label for="disabledSelect">نام</label>
                                            <input class="form-control" id="disabledInput" type="text" placeholder="<%=adminInfo.getFullName()%>" disabled>
                                        </div>
                                        <div class="form-group">
                                            <label for="disabledSelect">نام کاربری</label>
                                            <input class="form-control" id="disabledInput" type="text" placeholder="<%=adminInfo.getUsername()%>" disabled>
                                        </div>
                                        <div class="form-group">
                                            <label for="disabledSelect">ایمیل</label>
                                            <input class="form-control" id="disabledInput" type="text" placeholder="<%=adminInfo.getEmail()%>" disabled>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                            <div class="col-lg-6" dir="rtl" style="text-align: center;">
                                <form action="/admin/changepassword" method="post" >
                                    <div class="form-group col-lg-12">
                                        <label>رمز عبور فعلی</label>
                                        <input class="form-control" type="text" placeholder="رمز عبور فعلی" name="currentPassword">
                                        <!--                                        <p class="help-block">رمز عبور فعلی</p>-->
                                    </div>
                                    <div class="form-group col-lg-12">
                                        <label>رمز عبور جدید</label>
                                        <input class="form-control" type="pasword" placeholder="رمز عبور جدید"  name="newPassword">
                                        <!--                                        <p class="help-block">رمز عبور جدید</p>-->
                                    </div>
                                    <div class="form-group col-lg-12">
                                        <label>تکرار رمز عبور</label>
                                        <input class="form-control" type="pasword" placeholder="تکرار رمز عبور"  name="newPasswordRepeat">
                                        <!--                                        <p class="help-block">تکرار رمز عبور</p>-->
                                    </div>
                                    <div class="form-group col-lg-12">
                                        <label></label>
                                        <button type="submit" class="btn btn-info form-control">تایید</button>
                                    </div>
                                </form>

                            </div>
                        </div>
                        <div class="row">
                            <%if (request.getParameter("status") != null) {%>
                            <div class="alert alert-danger alert-dismissable" style="text-align: right; direction: rtl;">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                <%=(StatusQuery.values()[Integer.parseInt(request.getParameter("status"))].getSize())%>
                            </div>
                            <%}%>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="panel panel-primary text-center no-boder">
                            <div class="panel-body yellow">
                                <i class="fa fa-user fa-3x"></i>
                                <h3><%=(int) UserManager.getNumberOfAllUser()%></h3>
                            </div>
                            <div class="panel-footer">
                                <span class="panel-eyecandy-title">کاربران
                                </span>
                            </div>
                        </div>
                        <div class="panel panel-primary text-center no-boder">
                            <div class="panel-body red">
                                <i class="fa fa-users fa-3x"></i>
                                <h3><%=(int)AuctionParticipantManager.getNumberOfParticipant()%> </h3>
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
            document.getElementById("current_date").innerHTML = currDate.getFullYear() + "/" + currDate.getMonth() + "/" + currDate.getDate();
        </script>
        <!-- Core Scripts - Include with every page -->
        <script src="/View/assets/plugins/jquery-1.10.2.js"></script>
        <script src="/View/assets/plugins/bootstrap/bootstrap.min.js"></script>
        <script src="/View/assets/plugins/metisMenu/jquery.metisMenu.js"></script>
        <script src="/View/assets/plugins/pace/pace.js"></script>
        <script src="/View/assets/scripts/siminta.js"></script>
        <!-- Page-Level Plugin Scripts-->
        <script src="/View/assets/plugins/morris/raphael-2.1.0.min.js"></script>
        <script src="/View/assets/plugins/morris/morris.js"></script>
        <script src="/View/assets/scripts/dashboard-demo.js"></script>

    </body>

</html>

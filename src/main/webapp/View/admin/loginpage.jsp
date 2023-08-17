<%-- 
    Document   : Login
    Created on : Jun 30, 2023, 7:52:58 PM
    Author     : seyedhossein
--%>

<%@page import="Enum.StatusQuery"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ورود/ثبت نام</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Core CSS - Include with every page -->
        <link href="/View/assets/plugins/bootstrap/bootstrap.css" rel="stylesheet" />
        <link href="/View/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
        <link href="/View/assets/plugins/pace/pace-theme-big-counter.css" rel="stylesheet" />
        <link href="/View/assets/css/style.css" rel="stylesheet" />
        <link href="/View/assets/css/main-style.css" rel="stylesheet" />

    </head>

    <body class="body-Login-back">

        <div class="container">

            <div class="row">
                <div class="col-md-4 col-md-offset-4 text-center logo-margin ">
                    <img src="assets/img/logo.png" alt=""/>
                </div>
                <div class="col-md-4 col-md-offset-4">
                    <div class="login-panel panel panel-default">                  
                        <div class="panel-heading">
                            <h3 class="panel-title" style="opacity: 50%;">ورود</h3>
                        </div>
                        <div class="panel-body">
                            <form action="/admin/logincheck" method="post" role="form">
                                <fieldset>
                                    <div class="form-group">
                                        <input class="form-control" placeholder="E-mail" name="username" type="text" autofocus>
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" placeholder="Password" name="password" type="password" value="">
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input name="remember" type="checkbox" value="Remember Me">Remember Me
                                        </label>
                                    </div>
                                    <!-- Change this to a button or input when using this as a form -->
                                    <input type="submit" class="btn btn-lg btn-success btn-block" value="Login">
                                </fieldset>
                            </form>
                            <br/>
                            <%if (request.getParameter("status") != null)
                                if (request.getParameter("status").compareTo(Integer.toString(StatusQuery.USERNAME_PASSWORD_INCORRECT.ordinal())) == 0) {%>
                                <div class="alert alert-danger" alert-dismissable" style="text-align: right; direction: rtl;">
                                    نام کاربری و رمز عبور صحیح نیست.
                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                </div>
                            <%}%>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Core Scripts - Include with every page -->
        <script src="/View/assets/plugins/jquery-1.10.2.js"></script>
        <script src="/View/assets/plugins/bootstrap/bootstrap.min.js"></script>
        <script src="/View/assets/plugins/metisMenu/jquery.metisMenu.js"></script>

    </body>

</html>

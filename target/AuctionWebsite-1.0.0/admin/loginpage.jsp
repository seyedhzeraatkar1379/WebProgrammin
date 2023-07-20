<%-- 
    Document   : Login
    Created on : Jun 30, 2023, 7:52:58 PM
    Author     : seyedhossein
--%>

<%@page import="Enum.AdminErrorLogin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AdminPanel Page</title>
    </head>
    <body>
        <h4>change password<h4>
        <form action="/admin/logincheck" method="post">
            <input type="text" name="username"/>
            <input type="text" name="password"/>
            <input type="submit"/>
        </form>
        <%if(request.getParameter("error") != null)
            if(request.getParameter("error").compareTo(Integer.toString(AdminErrorLogin.UserAndPassNotFound.ordinal()))==0) {%>
            <h3>username/Password Incorrect</h3>
        <%}%>
    </body>
</html>

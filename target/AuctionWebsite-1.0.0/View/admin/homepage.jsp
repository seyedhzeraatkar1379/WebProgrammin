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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
    </head>
    <body>
        <h1>Hello <%=admin.getUsername()%>!</h1>
        <a href="/admin/logout">logout</a>
        <hr/>
        <%/*اصلاح اطلاعات ادمین*/%>
        <!--        <form action="/admin/changeInfo" method="post">
                    <input type="password" placeholder="Current Password..." name="currentPasswordInfo"/>
                    <input type="text" placeholder="FullName" name="fullName" value=""/>
                    <input type="email" placeholder="Email" name="emailAddress" value=""/>
                    <input type="submit"/>
                </form>-->
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
    </body>
</html>


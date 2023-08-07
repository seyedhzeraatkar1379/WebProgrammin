<%-- 
    Document   : userpanel
    Created on : Aug 7, 2023, 2:13:34 AM
    Author     : hossein
--%>

<%@page import="Model.UserTable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
    <%
        UserTable user=(UserTable)request.getSession().getAttribute("user");
    %>
    <form action="/user/updateuser" method="post">
        <input type="text" value="<%=user.getId()%>" disabled>
        <input type="text" value="<%=user.getEmail()%>" disabled>
        <input type="text" value="***" disabled>
        <input name="fullName" type="text" placeholder="نام" value="<%=user.getFullname()!=null?user.getFullname():""%>" />
        <input name="phoneNumber" type="tel" placeholder="تلفن" value="<%=user.getPhoneNumber()!=null?user.getPhoneNumber():""%>"/>
        <input name="address" type="text" placeholder="آدرس" value="<%=user.getAddress()!=null?user.getAddress():""%>"/>
        <input name="idCardCode" type="text" placeholder="کد ملی" value="<%=user.getIdCardCode()!=null?user.getIdCardCode():""%>"/>
        <input type="submit" />
    </form>
</html>

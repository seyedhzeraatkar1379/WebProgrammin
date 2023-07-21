<%-- 
    Document   : login
    Created on : Jul 21, 2023, 4:06:36 AM
    Author     : hossein
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>login</h1>
        <form method="post" action="/logincheck">
            <input type="email" placeholder="Email" name="email"/>
            <input type="password" placeholder="password" name="password"/>
            <input type="submit" />
        </form>
        <h1>register</h1>
        <form method="post" action="/register">
            <input placeholder="Email" type="email" name="email"/>
            <input placeholder="password" type="password" name="password"/>
            <input placeholder="confirm password" type="password1"/>
            <input type="checkbox" name="commitment" value="1"/>
            <input type="submit" />
        </form>   
    </body>
</html>

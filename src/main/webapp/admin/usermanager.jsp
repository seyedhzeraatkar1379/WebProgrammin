<%-- 
    Document   : usermanager
    Created on : Jul 9, 2023, 9:22:55 PM
    Author     : seyedhossein
--%>

<%@page import="Enum.ActiveOrDeactive"%>
<%@page import="java.util.List"%>
<%@page import="DatabaseManager.UserManager"%>
<%@page import="models.UserTable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>usermanager Page</title>
    </head>
    <body>
        <table>
            <tr>
                <th>id</th>
                <th>full name</th>
                <th>email</th>
                <th>phone number</th>
                <th>address</th>
                <th>id card</th>
                <th>commitment letter path</th>
                <th>user status</th>
                    <%--<th>id card photo</th>--%>
            </tr>
            <%
                List<UserTable> users = UserManager.getAllUser();
                if (users != null) {
                    for (UserTable user : users) {
            %>
            <tr>
                <td><%=user.getId()%></td>
                <td><%=user.getFullname()%></td>
                <td><%=user.getEmail()%></td>
                <td><%=user.getPhoneNumber()%></td>
                <td><%=user.getAddress()%></td>
                <td><%=user.getIdCardCode()%></td>
                <td><%=user.getCommitmentLeterPath()%></td>
                <td><%=user.getUserStatus()%></td>
                <td><a href="/admin/removeuser?userid=<%=user.getId()%>">rm</a></td>
                <%if (user.getUserStatus() == ActiveOrDeactive.ACTIVE) {%>
                <td><a href="/admin/changeuserstatus?userid=<%=user.getId()%>&status=<%=ActiveOrDeactive.DEACTIVE.ordinal()%>">enable/disable</a></td>
                <%} else {%>
                <td><a href="/admin/changeuserstatus?userid=<%=user.getId()%>&status=<%=ActiveOrDeactive.ACTIVE.ordinal()%>">enable/disable</a></td>
            </tr>
            <%}
                    }
                }%>
        </table>
        
    </body>
</html>

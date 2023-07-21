<%-- 
    Document   : artmanager
    Created on : Jul 2, 2023, 11:12:31 PM
    Author     : seyedhossein
--%>

<%@page import="Enum.StatusQuery"%>
<%@page import="DatabaseManager.ArtInfoManager"%>
<%@page import="java.util.List"%>
<%@page import="Model.ArtinfoTable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        List<ArtinfoTable> Arts = ArtInfoManager.getAllArt();
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Art Page</title>
    </head>
    <body>
        <h1>مدیریت آثار هنری!</h1>
        <h3>افزودن</h3>
        <form action="/admin/insertart" method="post" enctype="multipart/form-data">
            <input type="text" placeholder="name" name="nameart" />
            <input type="text" placeholder="description" name="descriptionart" />
            <input type="file" name="photoart" />
            <input type="submit" value="submit" />
        </form>
        <%if (request.getParameter("statusinsert") != null) {
                if (request.getParameter("statusinsert").compareTo(Integer.toString(StatusQuery.SUCCESS.ordinal())) == 0) {
        %>
        <h5 style="color: green;">Success</h5>
        <%} else {%>
        <h5 style="color: red;">Faild Insert</h5>
        <%}
            }%>
        <table>
            <tr>
                <th>id</th>
                <th>name</th>
                <th>description</th>
                <th>image</th>
                <th>edit</th>
                <th>remove</th>
            </tr>
            <%for (ArtinfoTable i : Arts) {%>
            <tr>
                <td><%=i.getId()%></td>
                <td><%=i.getName()%></td>
                <td><%=i.getDescription()%></td>
                <td><img src="<%=i.getPhotoPath() %>"  height="50" width="50"/><%=i.getPhotoPath()%></td>
                <td><a href="/admin/removeart?artid=<%=i.getId()%>">rm</a></td>
            </tr>
            <%}%>
        </table>

    </body>
</html>

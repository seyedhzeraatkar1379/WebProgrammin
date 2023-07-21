<%-- 
    Document   : auctionmanager
    Created on : Jul 9, 2023, 9:21:46 PM
    Author     : seyedhossein
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Model.AdminTable"%>
<%@page import="java.util.List"%>
<%@page import="Model.AuctionTable"%>
<%@page import="DatabaseManager.AuctionManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Auction Page</title>
        <%
            SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        %>
    </head>
    <body>
        <%-- // insert Auction
                    //  art Id OR art name
                    // can you show art table id when click in textbox when clicked record set id //can you use AJAX
        --%>
        <h1>افزودن مزایده جدید</h1>
        <form method="post" action="/admin/insertaucion">
            <input placeholder="art id" type="number" name="artId"/>
            <input type="number" name="adminId" value="<%=((AdminTable) request.getSession().getAttribute("admin")).getId()%>" disabled/>
            <input type="datetime-local" name="startDate"/>
            <input type="datetime-local" name="endDate"/>
            <input placeholder="status" value="1" name="status" type="checkbox"/>
            <input type="submit"/>
        </form>
        <%--  Update Auction when click in select record set Auction Id this Form input --%>
        <h1>آپدیت مزایده</h1>
        <form action="/admin/updateauction" method="post">
            <input type="number" placeholder="Auction Id" name="auctionId" disabled/>
            <input type="number" name="adminId" value="<%=((AdminTable) request.getSession().getAttribute("admin")).getId()%>" disabled/>
            <input type="text" placeholder="Art Id" name="artId" />
            <input type="datetime-local" placeholder="Start Date" name="startDate" />
            <input type="datetime-local" placeholder="End Date" name="endDate" />
            <input type="checkbox" placeholder="Status" name="status" />
            <input type="submit" />
        </form>

        <%--show all auction--%>
        <table>
            <tr>
                <th>id</th>
                <th>Art name</th>
                <th>start date</th>
                <th>end date</th>
                <th>status</th>
                <th>remove</th>
            </tr>
            <%
                List<AuctionTable> allAuction = AuctionManager.getAllAuction();
                for (AuctionTable i1 : allAuction) {
            %>
            <tr>
                <td><%=i1.getId()%></td>
                <td><%=i1.getArtId().getName()%></td>
                <td><%=dateformat.format(i1.getStartDate())%></td>
                <td><%=dateformat.format(i1.getEndDate())%></td>
                <td><%=i1.getStatus()%></td>
                <td><a href="/admin/removeauction?auctionid=<%=i1.getId()%>">rm</a></td>
            </tr>
            <%}%>
        </table>
        <%--show all toDo auction--%>
        <table>
            <tr>
                <th>id</th>
                <th>Art name</th>
                <th>start date</th>
                <th>end date</th>
                <th>status</th>
                <th>remove</th>
            </tr>
            <%
                List<AuctionTable> toDoAuction = AuctionManager.getAuctionActiveToDo();
                for (AuctionTable i2 : toDoAuction) {
            %>
            <tr>
                <td><%=i2.getId()%></td>
                <td><%=i2.getArtId().getName()%></td>
                <td><%=dateformat.format(i2.getStartDate())%></td>
                <td><%=dateformat.format(i2.getEndDate())%></td>
                <td><%=i2.getStatus()%></td>
                <td><a href="/admin/removeauction?auctionid=<%=i2.getId()%>">rm</a></td>
            </tr>
            <%}%>
        </table>

        <%--show all doing auction--%>
        <table>
            <tr>
                <th>id</th>
                <th>Art name</th>
                <th>start date</th>
                <th>end date</th>
                <th>status</th>
                <th>remove</th>
            </tr>
            <%
                List<AuctionTable> doingAuction = AuctionManager.getAuctionActiveDoing();
                for (AuctionTable i3 : doingAuction) {
            %>
            <tr>
                <td><%=i3.getId()%></td>
                <td><%=i3.getArtId().getName()%></td>
                <td><%=dateformat.format(i3.getStartDate())%></td>
                <td><%=dateformat.format(i3.getEndDate())%></td>
                <td><%=i3.getStatus()%></td>
                <td><a href="/admin/removeauction?auctionid=<%=i3.getId()%>">rm</a></td>
            </tr>
            <%}%>
        </table>
        <%--show all done auction--%>
        <table>
            <tr>
                <th>id</th>
                <th>Art name</th>
                <th>start date</th>
                <th>end date</th>
                <th>status</th>
                <th>remove</th>
            </tr>
            <%
                List<AuctionTable> doneAuction = AuctionManager.getAuctionActiveDone();
                for (AuctionTable i4 : doneAuction) {
            %>
            <tr>
                <td><%=i4.getId()%></td>
                <td><%=i4.getArtId().getName()%></td>
                <td><%=dateformat.format(i4.getStartDate())%></td>
                <td><%=dateformat.format(i4.getEndDate())%></td>
                <td><%=i4.getStatus()%></td>
                <td><a href="/admin/removeauction?auctionid=<%=i4.getId()%>">rm</a></td>
            </tr>
            <%}%>
        </table>
    </body>
</html>

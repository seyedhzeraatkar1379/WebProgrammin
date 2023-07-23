<%-- 
    Document   : auctionparticipant
    Created on : Jul 9, 2023, 9:24:56 PM
    Author     : seyedhossein
--%>

<%@page import="java.util.List"%>
<%@page import="DatabaseManager.AuctionManager"%>
<%@page import="Model.AuctionTable"%>
<%@page import="DatabaseManager.AuctionParticipantManager"%>
<%@page import="Model.AuctionParticipantTable"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>auctionparticipant Page</title>
    </head>
    <body>
        <%
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        %>

        <%--
        //  Show Auction
        --%>
        <h1>قابلیت سزچ بر اساس مزایده ها</h1>
        <h1>قابلیت سزچ بر اساس کد کاربر و نام کاربر</h1>
        <h1>قابلیت سزچ بر اساس تاریخ شروع مزایده وپایان مزایده و وضعیت مزایده</h1>
        <h1>وضعیت مزایده (درحال برگزاریو تمام شده و آینده)</h1>
        <hr/>
        <h1>در حال برگزاری</h1>
        <%
            List<AuctionTable> auctions = AuctionManager.getAuctionActiveDoing() ;
            if (auctions != null) {
                for (AuctionTable auction : auctions) {
        %>
        <table>
            <tr>
                <th>auction id</th>
                <th>Art name</th>
                <th>start date</th>
                <th>end date</th>
                <th>status</th>
            </tr>
            <tr>
                <td><%=auction.getId()%></td>
                <td><%=auction.getArtId().getName()%></td>
                <td><%=dateFormat.format(auction.getStartDate())%></td>
                <td><%=dateFormat.format(auction.getEndDate())%></td>
                <td><%=auction.getStatus()%></td>          

            </tr>
        </table>
        <%
                    List<AuctionParticipantTable> participants = AuctionParticipantManager.getAuctionAllParticipantById(auction.getId());
                    if (participants != null) {%>
        <table>
            <tr>
                <th>participant id</th>
                <th>purposed price</th>
                <th>purposed date time</th>
                <th>status</th>
                <th>user id</th>
                <th>user name</th>
                <th>remove</th>
            </tr>
            <%
                    for (AuctionParticipantTable part : participants) {
            %>
            <tr>
                <td><%=part.getId()%></td>
                <td><%=part.getPerposedPrice() %></td>
                <td><%=part.getPerposedDatetime() %></td>
                <td><%=part.getStatusCollateral() %></td>
                <td><%=part.getUserId().getId() %></td>
                <td><%=part.getUserId().getFullname() %></td>
                <td><a href="/admin/removeparticipant?id="<%=part.getId()%>">rem</a></td>
            </tr>
            <%}%>
        </table>
        <%
                    }%>
        <%
                }
            }%>

        <h1>شروع نشده</h1>

        <%
            List<AuctionTable> auctions1 = AuctionManager.getAuctionActiveToDo() ;
            if (auctions1 != null) {
                for (AuctionTable auction : auctions1) {
        %>
        <table>
            <tr>
                <th>auction id</th>
                <th>Art name</th>
                <th>start date</th>
                <th>end date</th>
                <th>status</th>
            </tr>
            <tr>
                <td><%=auction.getId()%></td>
                <td><%=auction.getArtId().getName()%></td>
                <td><%=dateFormat.format(auction.getStartDate())%></td>
                <td><%=dateFormat.format(auction.getEndDate())%></td>
                <td><%=auction.getStatus()%></td>          
            </tr>
        </table>
        <%
                    List<AuctionParticipantTable> participants = AuctionParticipantManager.getAuctionAllParticipantById(auction.getId());
                    if (participants != null) {%>
        <table>
            <tr>
                <th>participant id</th>
                <th>purposed price</th>
                <th>purposed date time</th>
                <th>status</th>
                <th>user id</th>
                <th>user name</th>
                <th>remove</th>
            </tr>
            <%
                    for (AuctionParticipantTable part : participants) {
            %>
            <tr>
                <td><%=part.getId()%></td>
                <td><%=part.getPerposedPrice() %></td>
                <td><%=part.getPerposedDatetime() %></td>
                <td><%=part.getStatusCollateral() %></td>
                <td><%=part.getUserId().getId() %></td>
                <td><%=part.getUserId().getFullname() %></td>
                <td><a href="/admin/removeparticipant?id="<%=part.getId()%>">rem</a></td>

            </tr>
            <%}%>
        </table>
        <%
                    }%>
        <%
                }
            }%>

        <h1>تمام شده</h1>

        <%@include file="auctionwinner.jspf" %>

    </body>
</html>

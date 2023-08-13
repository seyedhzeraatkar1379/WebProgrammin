<%-- 
    Document   : auctionmanager
    Created on : Jul 9, 2023, 9:21:46 PM
    Author     : seyedhossein
--%>

<%@page import="Enum.StatusQuery"%>
<%@page import="DatabaseManager.ArtInfoManager"%>
<%@page import="Model.ArtinfoTable"%>
<%@page import="Enum.ActiveOrDeactive"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Model.AdminTable"%>
<%@page import="java.util.List"%>
<%@page import="Model.AuctionTable"%>
<%@page import="DatabaseManager.AuctionManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fa">
    <%
        int tablePageTodo = 1, numberOfRecordTodo = 10, tablePageDoing = 1, numberOfRecordDoing = 10, tablePageDone = 1, numberOfRecordDone = 10;
//        String filterAuction = "";
//        if (request.getParameter("search") != null) {
//            filterAuction = request.getParameter("search");
//        }
//        String filterString = "";
//        if (filterAuction != "") {
//            filterString = "&search=" + filterAuction;
//        }
        if (request.getParameter("PGTodo") != null) {
            tablePageTodo = Integer.parseInt(request.getParameter("PGTodo"));
        }
        if (request.getParameter("NRTodo") != null) {
            numberOfRecordTodo = Integer.parseInt(request.getParameter("NRTodo"));
        }
        if (request.getParameter("PGDoing") != null) {
            tablePageDoing = Integer.parseInt(request.getParameter("PGDoing"));
        }
        if (request.getParameter("NRDoing") != null) {
            numberOfRecordDoing = Integer.parseInt(request.getParameter("NRDoing"));
        }
        if (request.getParameter("PGDone") != null) {
            tablePageDone = Integer.parseInt(request.getParameter("PGDone"));
        }
        if (request.getParameter("NRDone") != null) {
            numberOfRecordDone = Integer.parseInt(request.getParameter("NRDone"));
        }
        List<ArtinfoTable> artListDosntInAuction = ArtInfoManager.getArtDosntInAuction();
        //List<AuctionTable> auctions = filterAuction == "" ? AuctionManager.getAllAuction() : AuctionManager.getAllAuctionByArtName(filterString);
    %>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Auction Page</title>
        <%
            SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        %>
        <!-- Core CSS - Include with every page -->
        <link href="/View/admin/assets/plugins/bootstrap/bootstrap.css" rel="stylesheet">
        <link href="/View/admin/assets/font-awesome/css/font-awesome.css" rel="stylesheet">
        <link href="/View/admin/assets/plugins/pace/pace-theme-big-counter.css" rel="stylesheet">
        <link href="/View/admin/assets/css/style.css" rel="stylesheet">
        <link href="/View/admin/assets/css/main-style.css" rel="stylesheet">

    </head>

    <body onload="SelectDefaultValue()">
        <!--  wrapper -->
        <div id="wrapper">
            <%@include file="ConstPageSection/header.jspf" %>

            <!--  page-wrapper -->
            <div id="page-wrapper" style="text-align: right; direction: rtl;">
                <br/><br/><br/><br/>

                <div class="row" dir="rtl">
                    <!-- Page Header -->
                    <div class="col-lg-12">
                        <h1 class="page-header">مدیریت مزایده ها</h1>
                    </div>
                    <!--End Page Header -->
                </div>
                <div class="row" >
                    <!-- Page Header -->
                    <form method="post" action="/admin/insertaucion" role="form">
                        <div class="row" >
                            <div class="col-md-6" style="float:right;">
                                <div class="form-group col-md-6" style="float:right;">
                                    <label>آیدی ادمین</label>
                                    <input  class="form-control" type="number" name="adminId" value="<%=((AdminTable) request.getSession().getAttribute("admin")).getId()%>" disabled/>
                                </div>
                                <div class="form-group col-md-6" style="float:right;">
                                    <label>آیدی اثر</label>
                                    <select class="form-control" id="cars" name="artId">
                                        <%for (ArtinfoTable art : artListDosntInAuction) {%>
                                        <option value="<%=art.getId()%>"><%="id: " + art.getId() + "name: " + art.getName()%></option>
                                        <%}%>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group col-md-6" style="float:right;">
                                    <label >تاریخ شروع</label>
                                    <input class="form-control" type="datetime-local" name="startDate"/>
                                </div>
                                <div class="form-group col-md-6" style="float:right;">
                                    <label>تاریخ پایان</label>
                                    <input class="form-control" type="datetime-local" name="endDate"/>
                                </div>
                            </div>
                            <div class="col-md-6" style="float:right;">
                                <div class="form-group col-md-6" style="float:right;">

                                    <label>قیمت پایه</label>
                                    <input class="form-control" placeholder="قیمت پایه" name="limitStatus" type="text"/>
                                </div>
                                <div class="form-group col-md-6" style="float:right;">
                                    <label>وضعیت</label>
                                    <input placeholder="status" value="1" name="status" type="checkbox"/>
                                </div>
                            </div>
                            <div class="col-md-offset-4" style="text-align: right;">
                                <div class="col-md-12">
                                    <button class="btn btn-primary" type="submit">افزودن</button>
                                </div>
                            </div>
                        </div>

                    </form>
                    <!--End Page Header -->
                </div>
                <br/>
                <%if (request.getParameter("statusins") != null)
                        if (!request.getParameter("statusins").isEmpty()) {
                %>
                <div class="alert <%=Integer.parseInt(request.getParameter("statusins")) == StatusQuery.SUCCESS.ordinal() ? "alert-success" : "alert-danger"%> alert-dismissable">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                    <%=StatusQuery.values()[Integer.parseInt(request.getParameter("statusins"))]%>.
                </div>
                <%}%>
                <br/>
                <div class="row" >
                    <!-- Advanced Tables -->
                    <div class="col-lg-12">
                        <!-- Advanced Tables -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                مزایده پیش رو
                            </div>
                            <div class="panel-body">
                                <div class="table-responsive">
                                    <div id="dataTables-example_wrapper" class="dataTables_wrapper form-inline" role="grid">
                                        <div class="row">
                                            <div class="col-sm-6">

                                            </div>
                                            <div class="col-sm-6">
                                                <div class="dataTables_length" id="dataTables-example_length">
                                                    <label>
                                                        <select id="NumberOfRecordTodo" name="dataTables-example_length" aria-controls="dataTables-example" class="form-control input-sm">
                                                            <option value="10">10</option>
                                                            <option value="25">25</option>
                                                            <option value="50">50</option>
                                                            <option value="100">100</option>
                                                        </select>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <table class="table table-striped table-bordered table-hover dataTable no-footer" id="dataTables-example" aria-describedby="dataTables-example_info">
                                            <thead>
                                                <tr role="row">
                                                    <th style="text-align: right;" class="sorting_asc" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        آیدی
                                                    </th>
                                                    <th style="text-align: right;"  tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        آیدی اثر
                                                    </th>
                                                    <th style="text-align: right;"  tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        نام اثر
                                                    </th>
                                                    <th style="text-align: right;"  tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        قیمت پایه
                                                    </th>
                                                    <th style="text-align: right;"  tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        تاریخ شروع
                                                    </th>
                                                    <th style="text-align: right;"  tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        تاریخ پایان
                                                    </th>
                                                    <th style="text-align: right;" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        وضعیت نمایش
                                                    </th>
                                                    <th style="text-align: right;"  tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        حذف
                                                    </th>
                                                    <th style="text-align: right;" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        تغییر وضعیت
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    List<AuctionTable> toDoAuction = AuctionManager.getAuctionActiveToDo();
                                                    if (toDoAuction != null)
                                                        if (toDoAuction.size() > numberOfRecordTodo * (tablePageTodo - 1))
                                                            for (int i = (numberOfRecordTodo * (tablePageTodo - 1)), j = 1; j <= numberOfRecordTodo && i < toDoAuction.size(); i++, j++) {
                                                %>
                                                <tr>
                                                    <td><%=toDoAuction.get(i).getId()%></td>
                                                    <td><%=toDoAuction.get(i).getArtId().getId()%></td>
                                                    <td><%=toDoAuction.get(i).getArtId().getName()%></td>
                                                    <td><%=toDoAuction.get(i).getLimitPrice()%></td>
                                                    <td><%=dateformat.format(toDoAuction.get(i).getStartDate())%></td>
                                                    <td><%=dateformat.format(toDoAuction.get(i).getEndDate())%></td>
                                                    <td><i class="<%=toDoAuction.get(i).getStatus() == ActiveOrDeactive.ACTIVE ? "fa fa-eye" : "fa fa-eye-slash"%>"></i></td>
                                                    <td><a href="/admin/removeauction?datetype=1&auctionid=<%=toDoAuction.get(i).getId()%>&PGTodo=<%=tablePageTodo%>&NRTodo=<%=numberOfRecordTodo%>&PGDoing=<%=tablePageDoing%>&NRDoing=<%=numberOfRecordDoing%>&PGDone=<%=tablePageDone%>&NRDone=<%=numberOfRecordDone%>"><i class="fa fa-trash-o"></i></a></td>
                                                    <td><a href="/admin/changestatusauction?auctionid=<%=toDoAuction.get(i).getId()%>&PGTodo=<%=tablePageTodo%>&NRTodo=<%=numberOfRecordTodo%>&PGDoing=<%=tablePageDoing%>&NRDoing=<%=numberOfRecordDoing%>&PGDone=<%=tablePageDone%>&NRDone=<%=numberOfRecordDone%>"><i class="fa fa-refresh"></i></a></td>
                                                </tr>
                                                <%}%>
                                        </table>
                                        <div class="row">
                                            <div class="col-sm-6">
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="dataTables_paginate paging_simple_numbers" id="dataTables-example_paginate">
                                                    <ul class="pagination">
                                                        <%if (tablePageTodo > 1) {%>
                                                        <li class="paginate_button previous" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_previous"><a href="/admin/auctionmanager?PGTodo=<%=tablePageTodo - 1%>&NRTodo=<%=numberOfRecordTodo%>&PGDoing=<%=tablePageDoing%>&NRDoing=<%=numberOfRecordDoing%>&PGDone=<%=tablePageDone%>&NRDone=<%=numberOfRecordDone%>">Previous</a></li>
                                                            <%}
                                                                if (toDoAuction != null) {
                                                                    for (int i = 0; i < Math.ceil((double) toDoAuction.size() / numberOfRecordTodo); i++) {

                                                                        if (tablePageTodo == i + 1) {
                                                            %>
                                                        <li class="paginate_button active" aria-controls="dataTables-example" tabindex="0"><a href="#"><%=i + 1%></a></li>
                                                            <%} else {%>
                                                        <li class="paginate_button" aria-controls="dataTables-example" tabindex="0"><a href="/admin/auctionmanager?PGTodo=<%=i + 1%>&NRTodo=<%=numberOfRecordTodo%>&PGDoing=<%=tablePageDoing%>&NRDoing=<%=numberOfRecordDoing%>&PGDone=<%=tablePageDone%>&NRDone=<%=numberOfRecordDone%>"><%=i + 1%></a></li>
                                                            <%}
                                                                }

                                                                if (tablePageTodo < Math.ceil((double) toDoAuction.size() / numberOfRecordTodo)) {
                                                            %>
                                                        <li class="paginate_button next" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_next">
                                                            <a href="/admin/auctionmanager?PGTodo=<%=tablePageTodo + 1%>&NRTodo=<%=numberOfRecordTodo%>&PGDoing=<%=tablePageDoing%>&NRDoing=<%=numberOfRecordDoing%>&PGDone=<%=tablePageDone%>&NRDone=<%=numberOfRecordDone%>">Next</a>
                                                        </li>
                                                        <%}
                                                            }%>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <%if (request.getParameter("datetype") != null && request.getParameter("statusrmv") != null)
                                                if (Integer.parseInt(request.getParameter("datetype")) == 1) {
                                        %>
                                        <div class="alert <%=Integer.parseInt(request.getParameter("statusrmv")) == StatusQuery.SUCCESS.ordinal() ? "alert-success" : "alert-danger"%> alert-dismissable">
                                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                            <%=StatusQuery.values()[Integer.parseInt(request.getParameter("statusrmv"))]%>.
                                        </div>
                                        <%}%>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <!--End Advanced Tables -->
                    </div>
                    <!--End Advanced Tables -->

                </div>
                <div class="row" >
                    <!-- Advanced Tables -->
                    <div class="col-lg-12">
                        <!-- Advanced Tables -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                مزایده ها درحال انجام
                            </div>
                            <div class="panel-body">
                                <div class="table-responsive">
                                    <div id="dataTables-example_wrapper" class="dataTables_wrapper form-inline" role="grid">
                                        <div class="row">
                                            <div class="col-sm-6">

                                            </div>
                                            <div class="col-sm-6">
                                                <div class="dataTables_length" id="dataTables-example_length">
                                                    <label>
                                                        <select id="NumberOfRecordDoing" name="dataTables-example_length" aria-controls="dataTables-example" class="form-control input-sm">
                                                            <option value="10">10</option>
                                                            <option value="25">25</option>
                                                            <option value="50">50</option>
                                                            <option value="100">100</option>
                                                        </select>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <table class="table table-striped table-bordered table-hover dataTable no-footer" id="dataTables-example" aria-describedby="dataTables-example_info">
                                            <thead>
                                                <tr role="row">
                                                    <th style="text-align: right;" class="sorting_asc" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        آیدی
                                                    </th>
                                                    <th style="text-align: right;"  tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        آیدی اثر
                                                    </th>
                                                    <th style="text-align: right;"  tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        نام اثر
                                                    </th>
                                                    <th style="text-align: right;"  tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        قیمت پایه
                                                    </th>
                                                    <th style="text-align: right;"  tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        تاریخ شروع
                                                    </th>
                                                    <th style="text-align: right;"  tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        تاریخ پایان
                                                    </th>
                                                    <th style="text-align: right;" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        وضعیت نمایش
                                                    </th>
                                                    <th style="text-align: right;"  tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        حذف
                                                    </th>
                                                    <th style="text-align: right;" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        تغییر وضعیت
                                                    </th>
                                                    <th style="text-align: right;" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        اطلاعات بیشتر
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    List<AuctionTable> doingAuction = AuctionManager.getAuctionActiveDoing();
                                                    if (doingAuction != null)
                                                        if (doingAuction.size() > numberOfRecordDoing * (tablePageDoing - 1))
                                                            for (int i = (numberOfRecordDoing * (tablePageDoing - 1)), j = 1; j <= numberOfRecordDoing && i < doingAuction.size(); i++, j++) {
                                                %>
                                                <tr>
                                                    <td><%=doingAuction.get(i).getId()%></td>
                                                    <td><%=doingAuction.get(i).getArtId().getId()%></td>
                                                    <td><%=doingAuction.get(i).getArtId().getName()%></td>
                                                    <td><%=doingAuction.get(i).getLimitPrice()%></td>
                                                    <td><%=dateformat.format(doingAuction.get(i).getStartDate())%></td>
                                                    <td><%=dateformat.format(doingAuction.get(i).getEndDate())%></td>
                                                    <td><i class="<%=doingAuction.get(i).getStatus() == ActiveOrDeactive.ACTIVE ? "fa fa-eye" : "fa fa-eye-slash"%>"></i></td>
                                                    <td><a href="/admin/removeauction?datetype=2&auctionid=<%=doingAuction.get(i).getId()%>&PGTodo=<%=tablePageTodo%>&NRTodo=<%=numberOfRecordTodo%>&PGDoing=<%=tablePageDoing%>&NRDoing=<%=numberOfRecordDoing%>&PGDone=<%=tablePageDone%>&NRDone=<%=numberOfRecordDone%>"><i class="fa fa-trash-o"></i></a></td>
                                                    <td><a href="/admin/changestatusauction?auctionid=<%=doingAuction.get(i).getId()%>&PGTodo=<%=tablePageTodo%>&NRTodo=<%=numberOfRecordTodo%>&PGDoing=<%=tablePageDoing%>&NRDoing=<%=numberOfRecordDoing%>&PGDone=<%=tablePageDone%>&NRDone=<%=numberOfRecordDone%>"><i class="fa fa-refresh"></i></a></td>
                                                    <td><a href="/admin/auctionparticipantmanager?auctionid=<%=doingAuction.get(i).getId()%>"><i class="fa fa-eye"></i></a></td>
                                                </tr>
                                                <%}%>
                                        </table>
                                        <div class="row">
                                            <div class="col-sm-6">
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="dataTables_paginate paging_simple_numbers" id="dataTables-example_paginate">
                                                    <ul class="pagination">
                                                        <%if (tablePageDoing > 1) {%>
                                                        <li class="paginate_button previous" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_previous">
                                                            <a href="/admin/auctionmanager?PGTodo=<%=tablePageTodo%>&NRTodo=<%=numberOfRecordTodo%>&PGDoing=<%=tablePageDoing - 1%>&NRDoing=<%=numberOfRecordDoing%>&PGDone=<%=tablePageDone%>&NRDone=<%=numberOfRecordDone%>">
                                                                Previous
                                                            </a>
                                                        </li>
                                                        <%}
                                                            if (doingAuction != null) {
                                                                for (int i = 0; i < Math.ceil((double) doingAuction.size() / numberOfRecordDoing); i++) {
                                                                    if (tablePageDoing == i + 1) {
                                                        %>
                                                        <li class="paginate_button active" aria-controls="dataTables-example" tabindex="0"><a href="#"><%=i + 1%></a></li>
                                                            <%} else {%>
                                                        <li class="paginate_button" aria-controls="dataTables-example" tabindex="0"><a href="/admin/auctionmanager?PGTodo=<%=tablePageTodo%>&NRTodo=<%=numberOfRecordTodo%>&PGDoing=<%=i + 1%>&NRDoing=<%=numberOfRecordDoing%>&PGDone=<%=tablePageDone%>&NRDone=<%=numberOfRecordDone%>"><%=i + 1%></a></li>
                                                            <%}
                                                                }

                                                                if (tablePageDoing < Math.ceil((double) doingAuction.size() / numberOfRecordDoing)) {
                                                            %>
                                                        <li class="paginate_button next" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_next">
                                                            <a href="/admin/auctionmanager?PGTodo=<%=tablePageTodo%>&NRTodo=<%=numberOfRecordTodo%>&PGDoing=<%=tablePageDoing + 1%>&NRDoing=<%=numberOfRecordDoing%>&PGDone=<%=tablePageDone%>&NRDone=<%=numberOfRecordDone%>">
                                                                Next
                                                            </a>
                                                        </li>
                                                        <%}
                                                            }%>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <%if (request.getParameter("datetype") != null && request.getParameter("statusrmv") != null)
                                                if (Integer.parseInt(request.getParameter("datetype")) == 2) {
                                        %>
                                        <div class="alert <%=Integer.parseInt(request.getParameter("statusrmv")) == StatusQuery.SUCCESS.ordinal() ? "alert-success" : "alert-danger"%> alert-dismissable">
                                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                            <%=StatusQuery.values()[Integer.parseInt(request.getParameter("statusrmv"))]%>.
                                        </div>
                                        <%}%>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <!--End Advanced Tables -->
                    </div>
                    <!--End Advanced Tables -->

                </div>
                <div class="row" >
                    <!-- Advanced Tables -->
                    <div class="col-lg-12">
                        <!-- Advanced Tables -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                مزایده های پایان یافته
                            </div>
                            <div class="panel-body">
                                <div class="table-responsive">
                                    <div id="dataTables-example_wrapper" class="dataTables_wrapper form-inline" role="grid">
                                        <div class="row">
                                            <div class="col-sm-6">

                                            </div>
                                            <div class="col-sm-6">
                                                <div class="dataTables_length" id="dataTables-example_length">
                                                    <label>
                                                        <select id="NumberOfRecordDone" name="dataTables-example_length" aria-controls="dataTables-example" class="form-control input-sm">
                                                            <option value="10">10</option>
                                                            <option value="25">25</option>
                                                            <option value="50">50</option>
                                                            <option value="100">100</option>
                                                        </select>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <table class="table table-striped table-bordered table-hover dataTable no-footer" id="dataTables-example" aria-describedby="dataTables-example_info">
                                            <thead>
                                                <tr role="row">
                                                    <th style="text-align: right;" class="sorting_asc" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        آیدی
                                                    </th>
                                                    <th style="text-align: right;"  tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        آیدی اثر
                                                    </th>
                                                    <th style="text-align: right;"  tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        نام اثر
                                                    </th>
                                                    <th style="text-align: right;"  tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        قیمت پایه
                                                    </th>
                                                    <th style="text-align: right;"  tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        تاریخ شروع
                                                    </th>
                                                    <th style="text-align: right;"  tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        تاریخ پایان
                                                    </th>
                                                    <th style="text-align: right;" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        وضعیت نمایش
                                                    </th>
                                                    <th style="text-align: right;"  tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        حذف
                                                    </th>
                                                    <th style="text-align: right;" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        تغییر وضعیت
                                                    </th>
                                                    <th style="text-align: right;" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                                        اطلاعات بیشتر
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    List<AuctionTable> doneAuction = AuctionManager.getAuctionActiveDone();
                                                    if (doneAuction != null)
                                                        if (doneAuction.size() > numberOfRecordDone * (tablePageDone - 1))
                                                            for (int i = (numberOfRecordDone * (tablePageDone - 1)), j = 1; j <= numberOfRecordDone && i < doneAuction.size(); i++, j++) {
                                                %>
                                                <tr>
                                                    <td><%=doneAuction.get(i).getId()%></td>
                                                    <td><%=doneAuction.get(i).getArtId().getId()%></td>
                                                    <td><%=doneAuction.get(i).getArtId().getName()%></td>
                                                    <td><%=doneAuction.get(i).getLimitPrice()%></td>
                                                    <td><%=dateformat.format(doneAuction.get(i).getStartDate())%></td>
                                                    <td><%=dateformat.format(doneAuction.get(i).getEndDate())%></td>
                                                    <td><i class="<%=doneAuction.get(i).getStatus() == ActiveOrDeactive.ACTIVE ? "fa fa-eye" : "fa fa-eye-slash"%>"></i></td>
                                                    <td><a href="/admin/removeauction?datetype=3&auctionid=<%=doneAuction.get(i).getId()%>&PGTodo=<%=tablePageTodo%>&NRTodo=<%=numberOfRecordTodo%>&PGDoing=<%=tablePageDoing%>&NRDoing=<%=numberOfRecordDoing%>&PGDone=<%=tablePageDone%>&NRDone=<%=numberOfRecordDone%>"><i class="fa fa-trash-o"></i></a></td>
                                                    <td><a href="/admin/changestatusauction?auctionid=<%=doneAuction.get(i).getId()%>&PGTodo=<%=tablePageTodo%>&NRTodo=<%=numberOfRecordTodo%>&PGDoing=<%=tablePageDoing%>&NRDoing=<%=numberOfRecordDoing%>&PGDone=<%=tablePageDone%>&NRDone=<%=numberOfRecordDone%>"><i class="fa fa-refresh"></i></a></td>
                                                    <td><a href="/admin/auctionparticipantmanager?auctionid=<%=doneAuction.get(i).getId()%>"><i class="fa fa-eye"></i></a></td>
                                                </tr>
                                                <%}%>
                                        </table>

                                        <div class="row">
                                            <div class="col-sm-6">
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="dataTables_paginate paging_simple_numbers" id="dataTables-example_paginate">
                                                    <ul class="pagination">
                                                        <%if (tablePageDone > 1) {%>
                                                        <li class="paginate_button previous" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_previous">
                                                            <a href="/admin/auctionmanager?PGTodo=<%=tablePageTodo%>&NRTodo=<%=numberOfRecordTodo%>&PGDoing=<%=tablePageDoing%>&NRDoing=<%=numberOfRecordDoing%>&PGDone=<%=tablePageDone - 1%>&NRDone=<%=numberOfRecordDone%>">
                                                                Previous
                                                            </a>
                                                        </li>
                                                        <%}
                                                            if (doneAuction != null) {
                                                                for (int i = 0; i < Math.ceil((double) doneAuction.size() / numberOfRecordDone); i++) {
                                                                    if (tablePageDone == i + 1) {
                                                        %>
                                                        <li class="paginate_button active" aria-controls="dataTables-example" tabindex="0"><a href="#"><%=i + 1%></a></li>
                                                            <%} else {%>
                                                        <li class="paginate_button" aria-controls="dataTables-example" tabindex="0"><a href="/admin/auctionmanager?PGTodo=<%=tablePageTodo%>&NRTodo=<%=numberOfRecordTodo%>&PGDoing=<%=tablePageDoing%>&NRDoing=<%=numberOfRecordDoing%>&PGDone=<%=i + 1%>&NRDone=<%=numberOfRecordDone%>"><%=i + 1%></a></li>
                                                            <%}
                                                                }

                                                                if (tablePageDone < Math.ceil((double) doneAuction.size() / numberOfRecordDone)) {
                                                            %>
                                                        <li class="paginate_button next" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_next">
                                                            <a href="/admin/auctionmanager?PGTodo=<%=tablePageTodo%>&NRTodo=<%=numberOfRecordTodo%>&PGDoing=<%=tablePageDoing%>&NRDoing=<%=numberOfRecordDoing%>&PGDone=<%=tablePageDone + 1%>&NRDone=<%=numberOfRecordDone%>">
                                                                Next
                                                            </a>
                                                        </li>
                                                        <%}
                                                            }%>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <%if (request.getParameter("datetype") != null && request.getParameter("statusrmv") != null)
                                                if (Integer.parseInt(request.getParameter("datetype")) == 3) {
                                        %>
                                        <div class="alert <%=Integer.parseInt(request.getParameter("statusrmv")) == StatusQuery.SUCCESS.ordinal() ? "alert-success" : "alert-danger"%> alert-dismissable">
                                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                            <%=StatusQuery.values()[Integer.parseInt(request.getParameter("statusrmv"))]%>.
                                        </div>
                                        <%}%>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <!--End Advanced Tables -->
                    </div>
                    <!--End Advanced Tables -->

                </div>


            </div>
            <!-- end page-wrapper -->

        </div>
        <!-- end wrapper -->
        <script>
            function SelectDefaultValue()
            {
                let currentUrl = window.location;
                let thisloc = new URL(currentUrl);
                let NRTodo = <%=numberOfRecordTodo%>;
                let NRDone = <%=numberOfRecordDone%>;
                let NRDoing = <%=numberOfRecordDoing%>;
                var comboBoxTodo = document.getElementById("NumberOfRecordTodo");
                var comboBoxDone = document.getElementById("NumberOfRecordDone");
                var comboBoxDoing = document.getElementById("NumberOfRecordDoing");
                for (let i = 0; i < comboBoxTodo.options.length; i++) {
                    if (comboBoxTodo.options[i].value == NRTodo)
                    {
                        comboBoxTodo.selectedIndex = i;
                        break;
                    }
                }
                for (let i = 0; i < comboBoxDone.options.length; i++) {
                    if (comboBoxDone.options[i].value == NRDone)
                    {
                        comboBoxDone.selectedIndex = i;
                        break;
                    }
                }
                for (let i = 0; i < comboBoxDoing.options.length; i++) {
                    if (comboBoxDoing.options[i].value == NRDoing)
                    {
                        comboBoxDoing.selectedIndex = i;
                        break;
                    }
                }
                comboBoxTodo.addEventListener("change", function () {
                    console.log("1");
                    setShowNumberOfRecord("Todo");
                });
                comboBoxDoing.addEventListener("change", function () {
                    console.log("2");
                    setShowNumberOfRecord("Doing");
                });
                comboBoxDone.addEventListener("change", function () {
                    console.log("3");
                    setShowNumberOfRecord("Done");
                });
                //console.log(NR);
            }
            function setShowNumberOfRecord()
            {
                console.log("4");
                let currentUrl = window.location;
                let thisloc = new URL(currentUrl);
                let PGTodo = <%=tablePageTodo%>;
                let NRTodo = document.getElementById("NumberOfRecordTodo").value;
                let PGDoing = <%=tablePageDoing%>;
                let NRDoing = document.getElementById("NumberOfRecordDoing").value;
                let PGDone = <%=tablePageDone%>;
                let NRDone = document.getElementById("NumberOfRecordDone").value;

                //currentUrl.set
                if (PGTodo == null)
                {
                    PGTodo = "1";
                }
                if (PGDoing == null)
                {
                    PGDoing = "1";
                }
                if (PGDone == null)
                {
                    PGDone = "1";
                }
                location.replace(thisloc.protocol + "//" + thisloc.host + "/admin/auctionmanager" + "?PGTodo=" + PGTodo + "&NRTodo=" + NRTodo + "&PGDoing=" + PGDoing + "&NRDoing=" + NRDoing + "&PGDone=" + PGDone + "&NRDone=" + NRDone);
                console.log("5");
            }
        </script>
        <!-- Core Scripts - Include with every page -->
        <script src="/View/admin/assets/plugins/jquery-1.10.2.js"></script>
        <script src="/View/admin/assets/plugins/bootstrap/bootstrap.min.js"></script>
        <script src="/View/admin/assets/plugins/metisMenu/jquery.metisMenu.js"></script>
        <script src="/View/admin/assets/plugins/pace/pace.js"></script>
        <script src="/View/admin/assets/scripts/siminta.js"></script>




    </body>
</html>



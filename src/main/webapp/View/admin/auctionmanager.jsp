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
    <%
        int tablePageTodo = 1, numberOfRecordTodo = 10,tablePageDoing = 1, numberOfRecordDoing = 10,tablePageDone = 1, numberOfRecordDone = 10;
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
                        <div class="row">
                            <div class="col-md-offset-6">
                                <div class="form-group col-md-6" style="text-align: right;">
                                    <label>آیدی اثر</label>
                                    <input class="form-control" placeholder="art id" type="number" name="artId"/>
                                </div>
                                <div class="form-group col-md-6" style="text-align: right;">
                                    <label>آیدی ادمین</label>
                                    <input  class="form-control" type="number" name="adminId" value="<%=((AdminTable) request.getSession().getAttribute("admin")).getId()%>" disabled/>
                                </div>

                            </div>
                            <div class="col-md-offset-6">

                                <div class="form-group col-md-6" style="text-align: right;">
                                    <label>تاریخ پایان</label>
                                    <input class="form-control" type="datetime-local" name="endDate"/>
                                </div>
                                <div class="form-group col-md-6" style="text-align: right;">
                                    <label >تاریخ شروع</label>
                                    <input class="form-control" type="datetime-local" name="startDate"/>
                                </div>
                            </div>
                            <div class="col-md-offset-2" style="text-align: right;">
                                <div class="col-md-12">

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
                                                    for (AuctionTable i2 : toDoAuction) {
                                                %>
                                                <tr>
                                                    <td><%=i2.getId()%></td>
                                                    <td><%=i2.getArtId().getId()%></td>
                                                    <td><%=i2.getArtId().getName()%></td>
                                                    <td><%=dateformat.format(i2.getStartDate())%></td>
                                                    <td><%=dateformat.format(i2.getEndDate())%></td>
                                                    <td><%=i2.getStatus()%></td>
                                                    <td><a href="/admin/removeauction?auctionid=<%=i2.getId()%>">rm</a></td>
                                                    <td><a href="/admin/changestatusauction?auctionid=<%=i2.getId()%>">change</a></td>
                                                </tr>
                                                <%}%>
                                        </table>
                                        <div class="row">
                                            <div class="col-sm-6">
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="dataTables_paginate paging_simple_numbers" id="dataTables-example_paginate">
                                                    <ul class="pagination">
                                                        <li class="paginate_button previous disabled" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_previous">
                                                            <a href="#">
                                                                Previous
                                                            </a>
                                                        </li>
                                                        <li class="paginate_button active" aria-controls="dataTables-example" tabindex="0">
                                                            <a href="#">
                                                                1
                                                            </a>
                                                        </li>
                                                        <li class="paginate_button next" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_next">
                                                            <a href="#">
                                                                Next
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
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
                                                        مشاهده کاربران
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    List<AuctionTable> doingAuction = AuctionManager.getAuctionActiveDoing();
                                                    for (AuctionTable i3 : doingAuction) {
                                                %>
                                                <tr>
                                                    <td><%=i3.getId()%></td>
                                                    <td><%=i3.getArtId().getId()%></td>
                                                    <td><%=i3.getArtId().getName()%></td>
                                                    <td><%=dateformat.format(i3.getStartDate())%></td>
                                                    <td><%=dateformat.format(i3.getEndDate())%></td>
                                                    <td><%=i3.getStatus()%></td>
                                                    <td><a href="/admin/removeauction?auctionid=<%=i3.getId()%>">rm</a></td>
                                                    <td><a href="/admin/changestatusauction?auctionid=<%=i3.getId()%>">change</a></td>
                                                    <td></td>
                                                </tr>
                                                <%}%>
                                        </table>
                                        <div class="row">
                                            <div class="col-sm-6">
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="dataTables_paginate paging_simple_numbers" id="dataTables-example_paginate">
                                                    <ul class="pagination">
                                                        <li class="paginate_button previous disabled" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_previous">
                                                            <a href="#">
                                                                Previous
                                                            </a>
                                                        </li>
                                                        <li class="paginate_button active" aria-controls="dataTables-example" tabindex="0">
                                                            <a href="#">
                                                                1
                                                            </a>
                                                        </li>
                                                        <li class="paginate_button next" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_next">
                                                            <a href="#">
                                                                Next
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
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
                                                        مشاهده کاربران
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    List<AuctionTable> doneAuction = AuctionManager.getAuctionActiveDone();
                                                    for (AuctionTable i4 : doneAuction) {
                                                %>
                                                <tr>
                                                    <td><%=i4.getId()%></td>
                                                    <td><%=i4.getArtId().getId()%></td>
                                                    <td><%=i4.getArtId().getName()%></td>
                                                    <td><%=dateformat.format(i4.getStartDate())%></td>
                                                    <td><%=dateformat.format(i4.getEndDate())%></td>
                                                    <td><%=i4.getStatus()%></td>
                                                    <td><a href="/admin/removeauction?auctionid=<%=i4.getId()%>">rm</a></td>
                                                    <td><a href="/admin/changestatusauction?auctionid=<%=i4.getId()%>">change</a></td>
                                                    <td></td>
                                                </tr>
                                                <%}%>
                                        </table>
                                        <div class="row">
                                            <div class="col-sm-6">
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="dataTables_paginate paging_simple_numbers" id="dataTables-example_paginate">
                                                    <ul class="pagination">
                                                        <li class="paginate_button previous disabled" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_previous">
                                                            <a href="#">
                                                                Previous
                                                            </a>
                                                        </li>
                                                        <li class="paginate_button active" aria-controls="dataTables-example" tabindex="0">
                                                            <a href="#">
                                                                1
                                                            </a>
                                                        </li>
                                                        <li class="paginate_button next" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_next">
                                                            <a href="#">
                                                                Next
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
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
                let NRTodo = <%=numberOfRecordTodo %>;
                let NRDone = <%=numberOfRecordDone %>;
                let NRDoing = <%=numberOfRecordDoing %>;
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
                location.replace(thisloc.protocol + "//" + thisloc.host + "/admin/auctionmanager" + "?PGTodo=" + PGTodo + "&NRTodo=" + NRTodo +"&PGDoing=" + PGDoing + "&NRDoing=" + NRDoing + "&PGDone=" + PGDone + "&NRDone=" + NRDone);
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



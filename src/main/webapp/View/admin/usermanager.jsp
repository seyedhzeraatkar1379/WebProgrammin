<%-- 
    Document   : usermanager
    Created on : Jul 9, 2023, 9:22:55 PM
    Author     : seyedhossein
--%>

<%@page import="Enum.ActiveOrDeactive"%>
<%@page import="java.util.List"%>
<%@page import="DatabaseManager.UserManager"%>
<%@page import="Model.UserTable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <%
        int tablePage = 1, numberOfRecord = 10;
        String filterUser = "";
        if (request.getParameter("search") != null) {
            filterUser = request.getParameter("search");
        }
        String filterString = "";
        if (filterUser != "") {
            filterString = "&search=" + filterUser;
        }
        if (request.getParameter("PG") != null) {
            tablePage = Integer.parseInt(request.getParameter("PG"));
        }
        if (request.getParameter("NR") != null) {
            numberOfRecord = Integer.parseInt(request.getParameter("NR"));
        }
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>usermanager Page</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Core CSS - Include with every page -->
        <link href="/View/admin/assets/plugins/bootstrap/bootstrap.css" rel="stylesheet" type="text/css" />
        <link href="/View/admin/assets/font-awesome/css/font-awesome.css" rel="stylesheet"type="text/css" />
        <link href="/View/admin/assets/plugins/pace/pace-theme-big-counter.css" rel="stylesheet" type="text/css"/>
        <link href="/View/admin/assets/css/style.css" rel="stylesheet" type="text/css"/>
        <link href="/View/admin/assets/css/main-style.css" rel="stylesheet" type="text/css"/>

    </head>
    <body onload="SelectDefaultValue()">
        <div id="wrapper">
            <%@include file="ConstPageSection/header.jspf" %>

            <!--  page-wrapper -->
            <div id="page-wrapper">

                <div class="row" dir="rtl" >
                    <!-- Page Header -->
                    <br/><br/><br/><br/>
                    <div class="col-lg-12">
                        <h1 class="page-header">مدیریت کاربران</h1>
                    </div>
                    <div class="table-responsive">
                        <div id="dataTables-example_wrapper" class="dataTables_wrapper form-inline" role="grid">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="dataTables_length" id="dataTables-example_length">
                                        <label >
                                            <select id="NumberOfRecord" name="dataTables-example_length" aria-controls="dataTables-example" class="form-control input-sm">
                                                <option value="10">10</option>
                                                <option value="25">25</option>
                                                <option value="50">50</option>
                                                <option value="100">100</option>
                                            </select>
                                        </label>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div id="dataTables-example_filter" class="dataTables_filter">
                                        <label>
                                            Search:<input onkeydown="if (event.keyCode == 13)
                                                        searchEvent()" type="search" class="form-control input-sm" aria-controls="dataTables-example" id="searchinput">
                                        </label>
                                        <%if (filterUser != "") {%>
                                        <a href="/admin/usermanager?PG=1&NR=<%=numberOfRecord%>">نمایش تمام کاربران</a>
                                        <%}%>
                                    </div>
                                </div>
                            </div>
                            <table  class="table table-striped table-bordered table-hover dataTable no-footer" id="dataTables-example" aria-describedby="dataTables-example_info" >
                                <thead >
                                    <tr role="row" >
                                        <th style="text-align: right;" class="sorting_asc" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 100px; " aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                            &nbsp;کد کاربر&nbsp;
                                        </th>
                                        <th style="text-align: right;" class="" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 219px;" aria-label="Browser: activate to sort column ascending">
                                            نام
                                        </th>
                                        <th style="text-align: right;" class="" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 201px;" aria-label="Platform(s): activate to sort column ascending">
                                            ایمیل
                                        </th>
                                        <th style="text-align: right;" class="" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 143px;" aria-label="Engine version: activate to sort column ascending">
                                            شماره تماس
                                        </th>
                                        <th style="text-align: right;" class="" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 102px;" aria-label="CSS grade: activate to sort column ascending">
                                            آدرس
                                        </th>
                                        <th style="text-align: right;" class="" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 102px;" aria-label="CSS grade: activate to sort column ascending">
                                            کد ملی
                                        </th>
                                        <th style="text-align: right;" class="" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 102px;" aria-label="CSS grade: activate to sort column ascending">
                                            تایید قوانین
                                        </th>
                                        <th style="text-align: right;" class="" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 102px;" aria-label="CSS grade: activate to sort column ascending">
                                            فعال/غیرفعال
                                        </th>
                                        <th style="text-align: right;" class="" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 102px;" aria-label="CSS grade: activate to sort column ascending">
                                            حذف
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        System.out.println(numberOfRecord);
                                        System.out.println(tablePage);
                                        List<UserTable> users;
                                        if (request.getParameter("search") != null) {
                                            users = UserManager.getAllUser(filterUser);
                                        } else {
                                            users = UserManager.getAllUser();
                                        }
                                        if (users != null)
                                            if (users.size() > numberOfRecord * (tablePage - 1)) {
                                                for (int i = (numberOfRecord * (tablePage - 1)), j = 1; j <= numberOfRecord && i < users.size(); i++, j++) {
                                    %>
                                    <tr class="gradeA odd">
                                        <td class="sorting_1"><%=users.get(i).getId()%></td>
                                        <td class=" "><%=users.get(i).getFullname()%></td>
                                        <td class=" "><%=users.get(i).getEmail()%></td>
                                        <td class="center "><%=users.get(i).getPhoneNumber()%></td>
                                        <td class="center "><%=users.get(i).getAddress()%></td>
                                        <td class=" "><%=users.get(i).getIdCardCode()%></td>
                                        <%if (users.get(i).getCommitmentLeterPath() == ActiveOrDeactive.ACTIVE) { %>
                                        <td ><i class="fa fa-check"></i></td>
                                            <%} else {%>
                                        <td ><i class="fa fa-close"></i></td>
                                            <%}
                                                if (users.get(i).getUserStatus() == ActiveOrDeactive.ACTIVE) {%>
                                        <td><a href="/admin/changeuserstatus?PG=<%=tablePage%>&NR=<%=numberOfRecord%>&userid=<%=users.get(i).getId()%>&status=<%=ActiveOrDeactive.DEACTIVE.ordinal()%>"><i class="fa fa-thumbs-o-down"></i></a></td>
                                                <%} else {%>
                                        <td><a href="/admin/changeuserstatus?PG=<%=tablePage%>&NR=<%=numberOfRecord%>&userid=<%=users.get(i).getId()%>&status=<%=ActiveOrDeactive.ACTIVE.ordinal()%>"><i class="fa fa-thumbs-o-up"></i></a></td>
                                                <%}%>  
                                        <td><a href="/admin/removeuser?userid=<%=users.get(i).getId()%>"><i class="fa fa-trash-o"></i></a></td>
                                    </tr>
                                    <%
                                                }
                                            }%>
                                </tbody>
                            </table>
                            <div class="row">
                                <div class="col-sm-6">
                                </div>
                                <div class="col-sm-6">
                                    <div class="dataTables_paginate paging_simple_numbers" id="dataTables-example_paginate"><ul class="pagination">

                                            <%if (tablePage > 1) {%>
                                            <li class="paginate_button previous" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_previous"><a href="/admin/usermanager?PG=<%=tablePage - 1%>&NR=<%=numberOfRecord%><%=filterString%>">Previous</a></li>
                                                <%}
                                                    if (users != null) {
                                                        for (int i = 0; i < users.size() / numberOfRecord + 1; i++) {
                                                            if (tablePage == i + 1) {
                                                %>
                                            <li class="paginate_button active" aria-controls="dataTables-example" tabindex="0"><a href="#"><%=i + 1%></a></li>
                                                <%} else {%>
                                            <li class="paginate_button" aria-controls="dataTables-example" tabindex="0"><a href="/admin/usermanager?PG=<%=i + 1%>&NR=<%=numberOfRecord%><%=filterString%>"><%=i + 1%></a></li>
                                                <%}
                                                    }

                                                    if (tablePage < users.size() / numberOfRecord + 1) {
                                                %>
                                            <li class="paginate_button next" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_next">
                                                <a href="/admin/usermanager?PG=<%=tablePage + 1%>&NR=<%=numberOfRecord%><%=filterString%>">Next</a>
                                            </li>
                                            <%}
                                                }%>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--End Page Header -->
                </div>



            </div>
            <!-- end page-wrapper -->
        </div>
        <script>
            function SelectDefaultValue()
            {
                let currentUrl = window.location;
                let thisloc = new URL(currentUrl);
                let NR = <%=numberOfRecord%>;
                var comboBox = document.getElementById("NumberOfRecord");
                for (let i = 0; i < comboBox.options.length; i++) {
                    if (comboBox.options[i].value == NR)
                    {
                        comboBox.selectedIndex = i;
                        break;
                    }
                }
                comboBox.addEventListener("change", function () {
                    setShowNumberOfRecord();
                });
                //console.log(NR);
            }
            function setShowNumberOfRecord()
            {
                let currentUrl = window.location;
                let thisloc = new URL(currentUrl);
                let PG = <%=tablePage%>;
                let NR = document.getElementById("NumberOfRecord").value;
                let filter1 = "<%=filterString%>";
                //currentUrl.set
                if (PG == null)
                {
                    PG = "1";
                }
                //console.log(thisloc.protocol+"//"+thisloc.host+thisloc.pathname+"?PG="+PG+"&NR="+NR);
                //console.log(<%=filterString%> + t);

                location.replace(thisloc.protocol + "//" + thisloc.host + "/admin/usermanager" + "?PG=" + PG + "&NR=" + NR + filter1);
            }
            function searchEvent()
            {
                let currentUrl = window.location;
                let thisloc = new URL(currentUrl);
                let PG = <%=tablePage%>;
                let NR = <%=numberOfRecord%>;

                location.replace(thisloc.protocol + "//" + thisloc.host + thisloc.pathname + "?PG=" + PG + "&NR=" + NR + "&search=" + document.getElementById("searchinput").value);
            }
        </script>
        <script src="/View/admin/assets/plugins/jquery-1.10.2.js"></script>
        <script src="/View/admin/assets/plugins/bootstrap/bootstrap.min.js"></script>
        <script src="/View/admin/assets/plugins/metisMenu/jquery.metisMenu.js"></script>
        <script src="/View/admin/assets/plugins/pace/pace.js"></script>
        <script src="/View/admin/assets/scripts/siminta.js"></script>

    </body>
</html>


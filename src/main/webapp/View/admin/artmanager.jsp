<%-- 
    Document   : artmanager
    Created on : Jul 2, 2023, 11:12:31 PM
    Author     : seyedhossein
--%>

<%@page import="java.io.File"%>
<%@page import="Enum.StatusQuery"%>
<%@page import="DatabaseManager.ArtInfoManager"%>
<%@page import="java.util.List"%>
<%@page import="Model.ArtinfoTable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <%
        int tablePage = 1, numberOfRecord = 10;
        String filterArt = "";
        if (request.getParameter("search") != null) {
            filterArt = request.getParameter("search");
        }
        String filterString = "";
        if (filterArt != "") {
            filterString = "&search=" + filterArt;
        }
        if (request.getParameter("PG") != null) {
            tablePage = Integer.parseInt(request.getParameter("PG"));

        }
        if (request.getParameter("NR") != null) {
            numberOfRecord = Integer.parseInt(request.getParameter("NR"));

        }
        List<ArtinfoTable> arts = (filterArt == null ? ArtInfoManager.getAllArt() : ArtInfoManager.getAllArt(filterArt));
    %>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>آثار</title>
        <!-- Core CSS - Include with every page -->
        <link href="/View/assets/plugins/bootstrap/bootstrap.css" rel="stylesheet" />
        <link href="/View/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
        <link href="/View/assets/plugins/pace/pace-theme-big-counter.css" rel="stylesheet" />
        <link href="/View/assets/css/style.css" rel="stylesheet" />
        <link href="/View/assets/css/main-style.css" rel="stylesheet" />

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
                        <h1 class="page-header" style="opacity: 50%;">مدیریت آثار هنری</h1>
                    </div>
                    <!--End Page Header -->
                </div>
                <div class="row" >
                    <div class="col-lg-12">

                        <form action="/admin/insertart" method="post" enctype="multipart/form-data" role="form">
                            <div class="row" dir="rtl">
                                <div class="form-group col-lg-offset-6">
                                    <label>نام اثر</label>
                                    <input class="form-control" type="text" placeholder="نام" name="nameart" />
                                    <p class="help-block"></p>
                                </div>
                                <div class="form-group col-lg-offset-6">
                                    <label>توضیحات</label>
                                    <input class="form-control" type="text" placeholder="توضیحات" name="descriptionart" />
                                    <p class="help-block"></p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6"></div>
                                <div class="form-group col-lg-3">
                                    <label>تصویر</label>
                                    <input type="file" name="photoart" >
                                </div>
                                <div class="form-group col-lg-3">
                                    <button type="submit" class="btn btn-primary ">افزودن</button>
                                </div>
                            </div>
                        </form>
                        <%if (request.getParameter("statusinsert") != null) {
                                if (request.getParameter("statusinsert").compareTo(Integer.toString(StatusQuery.SUCCESS.ordinal())) == 0) {
                        %>
                        <div class="alert alert-success alert-dismissable">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                            <%=StatusQuery.values()[Integer.parseInt(request.getParameter("statusinsert"))].getSize() %>
                        </div>
                        <%} else {%>
                        <div class="alert alert-danger alert-dismissable">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                            <%=StatusQuery.values()[Integer.parseInt(request.getParameter("statusinsert"))].getSize() %>
                        </div>
                        <%}
                            }%>
                    </div>

                </div>
                <hr/>
                <div class="row" >
                    <div class="col-lg-12">
                        <!-- Advanced Tables -->
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                آثار
                            </div>
                            <div class="panel-body">
                                <div class="table-responsive">
                                    <div id="dataTables-example_wrapper" class="dataTables_wrapper form-inline" role="grid">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="dataTables_length" id="dataTables-example_length">
                                                    <label>
                                                        <select id="NumberOfRecord" name="dataTables-example_length" aria-controls="dataTables-example" class="form-control input-sm">
                                                            <option value="10">
                                                                10
                                                            </option>
                                                            <option value="25">
                                                                25
                                                            </option>
                                                            <option value="50">
                                                                50
                                                            </option>
                                                            <option value="100">
                                                                100
                                                            </option>
                                                        </select> 
                                                        records per page
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div id="dataTables-example_filter" class="dataTables_filter">
                                                    <label>
                                                        Search:
                                                        <input onkeydown="if (event.keyCode == 13)
                                                                    searchEvent()" type="search" class="form-control input-sm" aria-controls="dataTables-example" id="searchinput">
                                                    </label>
                                                    <%if (filterArt != "") {%>
                                                    <a href="/admin/artmanager?PG=1&NR=<%=numberOfRecord%>">نمایش تمام آثار</a>
                                                    <%}%>
                                                </div>
                                            </div>
                                        </div>
                                        <br/>
                                        <table class="table table-striped table-bordered table-hover dataTable no-footer" id="dataTables-example" aria-describedby="dataTables-example_info">
                                            <thead>
                                                <tr role="row">
                                                    <th dir="rtl" style="text-align: right;" class="sorting_asc" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-label="Rendering engine: activate to sort column ascending" aria-sort="ascending">
                                                        id
                                                    </th>
                                                    <th dir="rtl" style="text-align: right;" class="" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 219px;" aria-label="Browser: activate to sort column ascending">
                                                        نام اثر
                                                    </th>
                                                    <th dir="rtl" style="text-align: right;" class="" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 201px;" aria-label="Platform(s): activate to sort column ascending">
                                                        توضیحات
                                                    </th>
                                                    <th dir="rtl" style="text-align: right;" class="" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 143px;" aria-label="Engine version: activate to sort column ascending">
                                                        تصویر
                                                    </th>
                                                    <th dir="rtl" style="text-align: right;" class="" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 102px;" aria-label="CSS grade: activate to sort column ascending">
                                                        حذف
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    if (arts != null)
                                                        if (arts.size() > numberOfRecord * (tablePage - 1)) {
                                                        File f = null;
                                                            for (int i = (numberOfRecord * (tablePage - 1)), j = 1; j <= numberOfRecord && i < arts.size(); i++, j++) {
                                                            f = new File(request.getServletContext().getRealPath("/images/arts/") + arts.get(i).getPhotoPath());
                                                %>
                                                <tr class="gradeA odd">
                                                    <td class="sorting_1"><%=arts.get(i).getId()%></td>
                                                    <td><%=arts.get(i).getName()%></td>
                                                    <td><%=arts.get(i).getDescription()%></td>
                                                    <td class="center "><a href="<%=f.exists() && !f.isDirectory() ? "/images/arts/" + arts.get(i).getPhotoPath() : ""%>"  height="50" width="50"><i class="fa fa-file"></i></a></td>
                                                    <td><a href="/admin/removeart?artid=<%=arts.get(i).getId()%>"><i class="fa fa-trash-o"></i></a></td>
                                                </tr>
                                                <%}
                                                        }%>
                                            </tbody>
                                        </table>
                                        <%if (request.getParameter("status") != null) {
                                                if (request.getParameter("status").compareTo("2") == 0) {%>
                                        <h1>مزایده مربوط به این اثر را پاک کنید</h1>
                                        <%}
                                            }%>
                                        <div class="row">

                                            <div class="col-sm-6">
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="dataTables_paginate paging_simple_numbers" id="dataTables-example_paginate">
                                                    <ul class="pagination">
                                                        <%if (tablePage > 1) {%>
                                                        <li class="paginate_button previous" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_previous"><a href="/admin/artmanager?PG=<%=tablePage - 1%>&NR=<%=numberOfRecord%><%=filterString%>">Previous</a></li>
                                                            <%}
                                                                if (arts != null) {
                                                                    for (int i = 0; i < Math.ceil((double) arts.size() / numberOfRecord); i++) {

                                                                        if (tablePage == i + 1) {
                                                            %>
                                                        <li class="paginate_button active" aria-controls="dataTables-example" tabindex="0"><a href="#"><%=i + 1%></a></li>
                                                            <%} else {%>
                                                        <li class="paginate_button" aria-controls="dataTables-example" tabindex="0"><a href="/admin/artmanager?PG=<%=i + 1%>&NR=<%=numberOfRecord%><%=filterString%>"><%=i + 1%></a></li>
                                                            <%}
                                                                }

                                                                if (tablePage < Math.ceil((double) arts.size() / numberOfRecord)) {
                                                            %>
                                                        <li class="paginate_button next" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_next">
                                                            <a href="/admin/artmanager?PG=<%=tablePage + 1%>&NR=<%=numberOfRecord%><%=filterString%>">Next</a>
                                                        </li>
                                                        <%}
                                                            }%>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <%if (request.getParameter("statusrmv") != null)
                                                if (!request.getParameter("statusrmv").isEmpty()) {
                                        %>
                                        <div class="alert <%=Integer.parseInt(request.getParameter("statusrmv")) == StatusQuery.SUCCESS.ordinal() ? "alert-success" : "alert-danger"%> alert-dismissable">
                                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                            <%=StatusQuery.values()[Integer.parseInt(request.getParameter("statusrmv"))].getSize() %>.
                                        </div>
                                        <%}%>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <!--End Advanced Tables -->
                    </div>
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

                location.replace(thisloc.protocol + "//" + thisloc.host + "/admin/artmanager" + "?PG=" + PG + "&NR=" + NR + filter1);
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
        <!-- Core Scripts - Include with every page -->
        <script src="/View/assets/plugins/jquery-1.10.2.js"></script>
        <script src="/View/assets/plugins/bootstrap/bootstrap.min.js"></script>
        <script src="/View/assets/plugins/metisMenu/jquery.metisMenu.js"></script>
        <script src="/View/assets/plugins/pace/pace.js"></script>
        <script src="/View/assets/scripts/siminta.js"></script>

    </body>

</html>


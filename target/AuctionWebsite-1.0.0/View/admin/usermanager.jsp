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
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>usermanager Page</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Core CSS - Include with every page -->
        <%@include file="head.jspf" %>
    </head>
    <body>
        <div id="wrapper">
            <%@include file="header.jspf" %>
            <!--  page-wrapper -->
            <div id="page-wrapper">

                <div class="row" dir="rtl">
                    <!-- Page Header -->
                    <br/><br/><br/><br/>
                    <div class="col-lg-12">
                        <h1 class="page-header">مدیریت کاربران</h1>
                    </div>
                    <div class="table-responsive">
                        <div id="dataTables-example_wrapper" class="dataTables_wrapper form-inline" role="grid"><div class="row"><div class="col-sm-6"><div class="dataTables_length" id="dataTables-example_length"><label><select name="dataTables-example_length" aria-controls="dataTables-example" class="form-control input-sm"><option value="10">10</option><option value="25">25</option><option value="50">50</option><option value="100">100</option></select> records per page</label></div></div><div class="col-sm-6"><div id="dataTables-example_filter" class="dataTables_filter"><label>Search:<input type="search" class="form-control input-sm" aria-controls="dataTables-example"></label></div></div></div><table class="table table-striped table-bordered table-hover dataTable no-footer" id="dataTables-example" aria-describedby="dataTables-example_info">
                                <thead>
                                    <tr role="row">
                                        <th class="sorting_asc" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 167px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column ascending">
                                            id
                                        </th>
                                        <th class="sorting" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 219px;" aria-label="Browser: activate to sort column ascending">
                                            full name    
                                        </th>
                                        <th class="sorting" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 201px;" aria-label="Platform(s): activate to sort column ascending">
                                            email
                                        </th>
                                        <th class="sorting" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 143px;" aria-label="Engine version: activate to sort column ascending">
                                            phone number
                                        </th>
                                        <th class="sorting" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 102px;" aria-label="CSS grade: activate to sort column ascending">
                                            address
                                        </th>
                                        <th class="sorting" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 102px;" aria-label="CSS grade: activate to sort column ascending">
                                            id card
                                        </th>
                                        <th class="sorting" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 102px;" aria-label="CSS grade: activate to sort column ascending">
                                            commitment status
                                        </th>
                                        <th class="sorting" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 102px;" aria-label="CSS grade: activate to sort column ascending">
                                            user status
                                        </th>
                                        <th class="sorting" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" style="width: 102px;" aria-label="CSS grade: activate to sort column ascending">
                                            edit
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                    List<UserTable> users = UserManager.getAllUser();
                                    if (users != null) {
                                        for (UserTable user : users) {
                                    %>
                                    <tr class="gradeA odd">
                                        <td class="sorting_1"><%=user.getId()%></td>
                                        <td class=" "><%=user.getFullname()%></td>
                                        <td class=" "><%=user.getEmail()%></td>
                                        <td class="center "><%=user.getPhoneNumber()%></td>
                                        <td class="center "><%=user.getAddress()%></td>
                                        <td class=" "><%=user.getIdCardCode()%></td>
                                        <td class=" "><%=user.getCommitmentLeterPath()%></td>
                                        <td class=" "><%=user.getUserStatus()%></td>
                                        <%if (user.getUserStatus() == ActiveOrDeactive.ACTIVE) {%>
                                        <td><a href="/admin/changeuserstatus?userid=<%=user.getId()%>&status=<%=ActiveOrDeactive.DEACTIVE.ordinal()%>"><i class="fa fa-edit"></i></a></td>
                                        <%} else {%>
                                        <td><a href="/admin/changeuserstatus?userid=<%=user.getId()%>&status=<%=ActiveOrDeactive.ACTIVE.ordinal()%>"><i class="fa fa-edit"></i></a></td>
                                    </tr>
                                    <%}
                                            }
                                        }%>
                                </tbody>
                            </table>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="dataTables_info" id="dataTables-example_info" role="alert" aria-live="polite" aria-relevant="all">
                                        number of record
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="dataTables_paginate paging_simple_numbers" id="dataTables-example_paginate"><ul class="pagination">
                                            <li class="paginate_button previous disabled" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_previous"><a href="#">Previous</a></li>
                                            <li class="paginate_button active" aria-controls="dataTables-example" tabindex="0"><a href="#">1</a></li>
                                            <li class="paginate_button next" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_next">
                                                <a href="#">Next</a>
                                            </li>
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
        <script src="/View/admin/assets/plugins/jquery-1.10.2.js"></script>
        <script src="/View/admin/assets/plugins/bootstrap/bootstrap.min.js"></script>
        <script src="/View/admin/assets/plugins/metisMenu/jquery.metisMenu.js"></script>
        <script src="/View/admin/assets/plugins/pace/pace.js"></script>
        <script src="/View/admin/assets/scripts/siminta.js"></script>

    </body>
</html>


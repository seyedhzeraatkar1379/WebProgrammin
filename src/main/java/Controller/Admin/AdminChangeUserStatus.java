package Controller.Admin;

import DatabaseManager.UserManager;
import Enum.StatusQuery;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminChangeUserStatus", urlPatterns = {"/admin/changeuserstatus"})
public class AdminChangeUserStatus
        extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int pageNumber = 1, numberOfRecord = 10;
        if (request.getParameter("PG") != null) {
            pageNumber = Integer.parseInt(request.getParameter("PG"));
        }
        if (request.getParameter("NR") != null) {
            numberOfRecord = Integer.parseInt(request.getParameter("NR"));
        }
        if (request.getParameter("userid") != null) {
            UserManager.changeUserStatus(Integer.parseInt(request.getParameter("userid")));
            response.sendRedirect("/admin/usermanager?PG=" + pageNumber + "&NR=" + numberOfRecord + "&status=" + StatusQuery.SUCCESS.ordinal());
            return;
        } else {
            response.sendRedirect("/admin/usermanager?PG=" + pageNumber + "&NR=" + numberOfRecord + "&status=" + StatusQuery.PARAMETER_NOT_VALID.ordinal());
            return;
        }
    }
}

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
        if (request.getParameter("userid") != null) {

            UserManager.changeUserStatus(Integer.parseInt(request.getParameter("userid")));
            response.sendRedirect("/admin/usermanager?status=" + StatusQuery.SUCCESS.ordinal());
            return;
        } else {
            response.sendRedirect("/admin/usermanager?status=" + StatusQuery.PARAMETER_NOT_VALID.ordinal());
            return;
        }
    }
}

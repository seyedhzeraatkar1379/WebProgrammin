package Controller.Admin;

import DatabaseManager.UserManager;
import Enum.StatusQuery;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminRemoveUser", urlPatterns = {"/admin/removeuser"})
public class AdminRemoveUser
        extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        if (request.getParameter("userid") != null) {
            int userId = Integer.parseInt(request.getParameter("userid"));
            UserManager.removeUser(userId);
            response.sendRedirect("/admin/usermanager?status=" + StatusQuery.SUCCESS.ordinal());
            return;
        } else {
            response.sendRedirect("/admin/usermanager?status=" + StatusQuery.PARAMETER_NOT_VALID.ordinal());
            return;
        }
    }
}

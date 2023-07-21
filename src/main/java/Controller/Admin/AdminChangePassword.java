package Controller.Admin;




import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Enum.AdminErrorLogin;
import DatabaseManager.AdminManager;
import Model.AdminTable;
@WebServlet(name = "AdminChangePassword", urlPatterns = {"/admin/changepassword"})
public class AdminChangePassword
        extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AdminTable admin = (AdminTable) request.getSession().getAttribute("admin");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String newPasswordRepeat = request.getParameter("newPasswordRepeat");
        if (newPassword.compareTo(newPasswordRepeat) == 0) {
            if (admin.getPassword().compareTo(currentPassword) == 0) {
                AdminManager.updatePasswordAdminByUsername(admin.getUsername(), newPassword);
                request.getSession().invalidate();
                response.sendRedirect("/admin/login");
            } else {
                response.sendRedirect("/admin/home?error=" + AdminErrorLogin.PasswordIncorrect.ordinal());
            }
        } else {
            response.sendRedirect("/admin/home?error=" + AdminErrorLogin.PasswordNotMatch.ordinal());
        }
    }
}

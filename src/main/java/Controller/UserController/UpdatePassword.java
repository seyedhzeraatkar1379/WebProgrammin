/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.UserController;

import DatabaseManager.UserManager;
import Enum.StatusQuery;
import Model.UserTable;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author hossein
 */
@WebServlet(name = "UpdatePassword", urlPatterns = {"/user/updatepass"})
public class UpdatePassword extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserTable user = (UserTable) request.getSession().getAttribute("user");
        String currentCorctPassword = user.getPassword();
        String currentPasswordInp = request.getParameter("currpasswrod") != null ? request.getParameter("currpasswrod") : "";
        String newPasswordInp = request.getParameter("newpasswrod") != null ? request.getParameter("newpasswrod") : "";
        String newPasswordRetInp = request.getParameter("newpasswrodret") != null ? request.getParameter("newpasswrodret") : "";
        if (currentPasswordInp != "" && newPasswordInp != "") {
            if (currentCorctPassword.compareTo(currentPasswordInp) == 0) {
                if (newPasswordInp.compareTo(newPasswordRetInp) == 0) {
                    if (newPasswordInp.compareTo(currentCorctPassword) != 0) {
                        UserManager.updatePassword(user.getId(),newPasswordInp);
                        request.getSession().invalidate();
                        response.sendRedirect("/user/login");
                        return;
                    } else {
                        response.sendRedirect("/user/userpanel?statuschangepass=" + StatusQuery.PASSWORD_EQUAL_NEWPASS.ordinal());
                        return;
                    }
                } else {
                    response.sendRedirect("/user/userpanel?statuschangepass=" + StatusQuery.NEW_PASSWORD_RETRY_INCORRECT.ordinal());
                    return;
                }
            } else {
                response.sendRedirect("/user/userpanel?statuschangepass=" + StatusQuery.PASSWORD_INCORRECT.ordinal());
                return;
            }
        } else {
            response.sendRedirect("/user/userpanel?statuschangepass=" + StatusQuery.PARAMETER_NOT_VALID.ordinal());
            return;
        }
    }
}

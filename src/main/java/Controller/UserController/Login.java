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
@WebServlet(name = "LoginControll", urlPatterns = {"/user/logincheck"})
public class Login extends HttpServlet {

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        if (request.getParameter("enaillogin") != null && request.getParameter("passwordlogin") != null) {
            if (!request.getParameter("enaillogin").isEmpty() && !request.getParameter("passwordlogin").isEmpty()) {
                UserTable user = UserManager.loginUser(request.getParameter("enaillogin"), request.getParameter("passwordlogin"));
                if (user != null) {
                    request.getSession().setAttribute("user", user);
                    response.sendRedirect("/");
                    return;
                }else{
                    response.sendRedirect("/login?statuslogin="+StatusQuery.USERNAME_PASSWORD_INCORRECT.ordinal());
                    return;
                }
            }
            else{
                response.sendRedirect("/login?statuslogin="+StatusQuery.PARAMETER_NOT_VALID.ordinal());
                    return;
            }
        }
        response.sendRedirect("/login?statuslogin=" + StatusQuery.FAILD.ordinal());
    }

}

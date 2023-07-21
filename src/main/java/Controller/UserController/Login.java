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
@WebServlet(name = "LoginControll", urlPatterns = {"/logincheck"})
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
        if (request.getParameter("email") != null && request.getParameter("password") != null) {
            if (!request.getParameter("email").isEmpty() && !request.getParameter("password").isEmpty()) {
                UserTable user = UserManager.loginUser(request.getParameter("email"), request.getParameter("password"));
                if (user != null) {
                    request.getSession().setAttribute("user", user);
                    response.sendRedirect("/");
                    return;
                }
            }
        }
        response.sendRedirect("/login?status=" + StatusQuery.FAILD.ordinal());
    }

}

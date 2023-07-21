/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.UserController;

import DatabaseManager.UserManager;
import Enum.StatusQuery;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author hossein
 */
@WebServlet(name = "Register", urlPatterns = {"/register"})
public class Register extends HttpServlet {

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
        if (request.getParameter("email") != null && request.getParameter("password") != null && request.getParameter("commitment") != null) {
            if (request.getParameter("commitment").compareTo("1") == 0) {
                if (UserManager.registerUserlv1(request.getParameter("email"), request.getParameter("password"))) {
                    response.sendRedirect("/login?status=" + StatusQuery.SUCCESS.ordinal());
                    return;
                }
                response.sendRedirect("/login?registerstatus=" + StatusQuery.RECORD_EXIST.ordinal());
                return;
            }
        }
        response.sendRedirect("/login?registerstatus=" + StatusQuery.PARAMETER_NOT_VALID.ordinal());
    }

}

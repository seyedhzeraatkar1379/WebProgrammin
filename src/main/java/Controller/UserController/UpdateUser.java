/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.UserController;

import DatabaseManager.UserManager;
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
@WebServlet(name = "UpdateUser", urlPatterns = {"/user/updateuser"})
public class UpdateUser extends HttpServlet {



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
        UserTable user = (UserTable)request.getSession().getAttribute("user");
        user.setPhoneNumber(request.getParameter("phoneNumber")!=null?request.getParameter("phoneNumber"):"");
        user.setAddress(request.getParameter("address")!=null?request.getParameter("address"):"");
        user.setFullname(request.getParameter("fullName")!=null?request.getParameter("fullName"):"");
        user.setIdCardCode(request.getParameter("idCardCode")!=null?request.getParameter("idCardCode"):"");
        UserManager.updateUser(user);
        response.sendRedirect("/user/userpanel");
    }
}

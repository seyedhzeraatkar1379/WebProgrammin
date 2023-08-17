/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin;

import DatabaseManager.ContactUsManager;
import Model.ContactusTable;
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
@WebServlet(name = "AdminUpdateSiteInfo", urlPatterns = {"/admin/updatesiteinfo"})
public class AdminUpdateSiteInfo extends HttpServlet {


   
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
        String email = request.getParameter("email")!=null?request.getParameter("email"):"";
        String telphone = request.getParameter("email")!=null?request.getParameter("telphone"):"";
        String address = request.getParameter("email")!=null?request.getParameter("address"):"";
        ContactusTable contmodel = new ContactusTable();
        contmodel.setEmail(email);
        contmodel.setTellPhone(telphone);
        contmodel.setAddress(address);
        ContactUsManager.insertOrUpdate(contmodel);
        response.sendRedirect("/admin/home");
    }
}

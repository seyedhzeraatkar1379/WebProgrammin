/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin;

import DatabaseManager.AuctionManager;
import Enum.StatusQuery;
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
@WebServlet(name = "AdminChangeAuctionStatus", urlPatterns = {"/admin/changestatusauction"})
public class AdminChangeAuctionStatus extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getParameter("auctionid") != null) {
            if (!request.getParameter("auctionid").isEmpty()) {
                if (AuctionManager.changeAuctionStatus(Integer.parseInt(request.getParameter("auctionid")))) {
                    response.sendRedirect("/admin/auctionmanager?status=" + StatusQuery.SUCCESS.ordinal());
                    return;
                } else {
                    response.sendRedirect("/admin/auctionmanager?status=" + StatusQuery.FAILD.ordinal());
                    return;
                }
            }
        }
        response.sendRedirect("/admin/auctionmanager?status=" + StatusQuery.PARAMETER_NOT_VALID.ordinal());
    }

}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.UserController;

import DatabaseManager.AuctionParticipantManager;
import Enum.ActiveOrDeactive;
import Enum.ParticipateStatus;
import Model.AuctionParticipantTable;
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
@WebServlet(name = "ParticipateAuction", urlPatterns = {"/user/participate"})
public class ParticipateAuction extends HttpServlet {

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
        UserTable user = ((UserTable) request.getSession().getAttribute("user"));
        int auctionId = request.getParameter("auctionid") != null ? Integer.parseInt(request.getParameter("auctionid")) : -1;
        String price =request.getParameter("price") != null ? request.getParameter("price") : "";
        if(auctionId != -1 && price != "")
        {
            AuctionParticipantTable partic = new AuctionParticipantTable();
            partic.setStatusCollateral(ActiveOrDeactive.ACTIVE);
            partic.setPerposedPrice(price);
            ParticipateStatus status = AuctionParticipantManager.insertOrUpdateAuctionParticipant(partic, auctionId, user.getId());
            if(status == ParticipateStatus.SUCCESS_INSERT)
            {
                response.sendRedirect("/user/auctiondescp?aucid="+auctionId+"&status=SuccessInsert");
                return;
            }
            if(status == ParticipateStatus.SUCCESS_UPDATE)
            {
                response.sendRedirect("/user/auctiondescp?aucid="+auctionId+"&status=SuccessUpdate");
                return;
            }
            else
            {
                response.sendRedirect("/user/auctiondescp?aucid="+auctionId+"&status="+status.toString());
                return;
            }
        }
        response.sendRedirect("/user/auctiondescp?aucid="+auctionId+"&status=faild");
    }

}

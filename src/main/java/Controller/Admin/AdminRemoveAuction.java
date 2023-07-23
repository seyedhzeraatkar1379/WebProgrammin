package Controller.Admin;

import DatabaseManager.AuctionManager;
import Enum.StatusQuery;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminRemoveAuction", urlPatterns = {"/admin/removeauction"})
public class AdminRemoveAuction
        extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("auctionid") != null) {
            if (AuctionManager.removeAuction(Integer.parseInt(request.getParameter("auctionid")))) {
                response.sendRedirect("/admin/auctionmanager?status=" + StatusQuery.SUCCESS.ordinal());
                return;
            } else {
                response.sendRedirect("/admin/auctionmanager?status=" + StatusQuery.FAILD_DEPENDENCY.ordinal());
                return;
            }
        } else {
            response.sendRedirect("/admin/auctionmanager?status=" + StatusQuery.PARAMETER_NOT_VALID.ordinal());
            return;
        }
    }
}

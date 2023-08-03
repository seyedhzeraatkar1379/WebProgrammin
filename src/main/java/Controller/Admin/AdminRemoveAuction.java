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
        String PGTodo  = request.getParameter("PGTodo") != null ? "&PGTodo="+request.getParameter("PGTodo") : "";
        String NRTodo  = request.getParameter("NRTodo") != null ? "&NRTodo="+request.getParameter("NRTodo") : "";
        String PGDoing = request.getParameter("PGDoing") != null ? "&PGDoing="+request.getParameter("PGDoing") : "";
        String NRDoing = request.getParameter("NRDoing") != null ? "&NRDoing="+request.getParameter("NRDoing") : "";
        String PGDone  = request.getParameter("PGDone") != null ? "&PGDone="+request.getParameter("PGDone") : "";
        String NRDone  = request.getParameter("NRDone") != null ? "&NRDone="+request.getParameter("NRDone") : "";
        if (request.getParameter("auctionid") != null) {
            if (AuctionManager.removeAuction(Integer.parseInt(request.getParameter("auctionid")))) {
                response.sendRedirect("/admin/auctionmanager?status=" + StatusQuery.SUCCESS.ordinal()+PGTodo+NRTodo+PGDoing+NRDoing+PGDone+NRDone);
                return;
            } else {
                response.sendRedirect("/admin/auctionmanager?status=" + StatusQuery.FAILD_DEPENDENCY.ordinal()+PGTodo+NRTodo+PGDoing+NRDoing+PGDone+NRDone);
                return;
            }
        } else {
            response.sendRedirect("/admin/auctionmanager?status=" + StatusQuery.PARAMETER_NOT_VALID.ordinal()+PGTodo+NRTodo+PGDoing+NRDoing+PGDone+NRDone);
            return;
        }
    }
}

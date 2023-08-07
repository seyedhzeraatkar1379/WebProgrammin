package Controller.Admin;

import DatabaseManager.ArtInfoManager;
import DatabaseManager.AuctionManager;
import Enum.ActiveOrDeactive;
import Enum.StatusQuery;
import java.io.IOException;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Model.AdminTable;
import Model.AuctionTable;

@WebServlet(name = "AdminInsertAuction", urlPatterns = {"/admin/insertaucion"})
public class AdminInsertAuction
        extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        if (request.getSession().getAttribute("admin") != null && request.getParameter("artId") != null && request.getParameter("startDate") != null && request.getParameter("endDate") != null) {
            int artId = Integer.parseInt(request.getParameter("artId"));
            int adminId = ((AdminTable) request.getSession().getAttribute("admin")).getId().intValue();
            String startDate = request.getParameter("startDate").replace('T', ' ');
            String endDate = request.getParameter("endDate").replace('T', ' ');
            String status = request.getParameter("status");
            AuctionTable auction = new AuctionTable();
            try {
                auction.setStartDate((new SimpleDateFormat("yyyy-MM-dd HH:mm")).parse(startDate));
                auction.setEndDate((new SimpleDateFormat("yyyy-MM-dd HH:mm")).parse(endDate));
                if (!auction.getStartDate().before(auction.getEndDate())) {
                    response.sendRedirect("/admin/auctionmanager?statusins=" + StatusQuery.PARAMETER_NOT_VALID.ordinal());
                    return;
                }
            } catch (Exception ex) {
                ex.printStackTrace();
                response.sendRedirect("/admin/auctionmanager?statusins=" + StatusQuery.PARAMETER_NOT_VALID.ordinal());
                return;
            }
            if (status != null) {
                auction.setStatus(ActiveOrDeactive.ACTIVE);
            } else {
                auction.setStatus(ActiveOrDeactive.DEACTIVE);
            }
            if (AuctionManager.insertAuction(auction, adminId, artId)) {
                response.sendRedirect("/admin/auctionmanager?statusins=" + StatusQuery.SUCCESS.ordinal());
                return;
            }
        } else {

            response.sendRedirect("/admin/auctionmanager?statusins=" + StatusQuery.PARAMETER_NOT_VALID.ordinal());
            return;
        }
        response.sendRedirect("/admin/auctionmanager?statusins=" + StatusQuery.FAILD.ordinal());
        return;
    }
}

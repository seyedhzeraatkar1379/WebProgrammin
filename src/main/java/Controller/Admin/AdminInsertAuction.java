package Controller.Admin;


/*    */ import DatabaseManager.AuctionManager;
/*    */ import Enum.ActiveOrDeactive;
/*    */ import Enum.StatusQuery;
/*    */ import java.io.IOException;
/*    */ import java.text.SimpleDateFormat;
/*    */ import javax.servlet.ServletException;
/*    */ import javax.servlet.annotation.WebServlet;
/*    */ import javax.servlet.http.HttpServlet;
/*    */ import javax.servlet.http.HttpServletRequest;
/*    */ import javax.servlet.http.HttpServletResponse;
/*    */ import Model.AdminTable;
/*    */ import Model.AuctionTable;
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ @WebServlet(name = "AdminInsertAuction", urlPatterns = {"/admin/insertaucion"})
/*    */ public class AdminInsertAuction
/*    */   extends HttpServlet
/*    */ {
/*    */   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
/* 43 */     if (request.getSession().getAttribute("admin") != null && request.getParameter("startDate") != null && request.getParameter("endDate") != null) {
/* 44 */       int artId = Integer.parseInt(request.getParameter("artId"));
/* 45 */       int adminId = ((AdminTable)request.getSession().getAttribute("admin")).getId().intValue();
/* 46 */       String startDate = request.getParameter("startDate").replace('T', ' ');
/* 47 */       String endDate = request.getParameter("endDate").replace('T', ' ');
/* 48 */       String status = request.getParameter("status");
/* 49 */       AuctionTable auction = new AuctionTable();
/*    */       try {
/* 51 */         auction.setStartDate((new SimpleDateFormat("yyyy-MM-dd HH:mm")).parse(startDate));
/* 52 */         auction.setEndDate((new SimpleDateFormat("yyyy-MM-dd HH:mm")).parse(endDate));
/* 53 */       } catch (Exception ex) {
/* 54 */         ex.printStackTrace();
/* 55 */         response.sendRedirect("/admin/auctionmanager?status=" + StatusQuery.PARAMETER_NOT_VALID.ordinal());
/*    */       } 
/* 57 */       if (status != null) {
/* 58 */         auction.setStatus(ActiveOrDeactive.ACTIVE);
/*    */       } else {
/* 60 */         auction.setStatus(ActiveOrDeactive.DEACTIVE);
/*    */       } 
/* 62 */       if (AuctionManager.insertAuction(auction, adminId, artId)) {
/* 63 */         response.sendRedirect("/admin/auctionmanager?status=" + StatusQuery.SUCCESS.ordinal());
/*    */       }
/*    */     }
/*    */     else {
/*    */       
/* 68 */       response.sendRedirect("/admin/auctionmanager?status=" + StatusQuery.PARAMETER_NOT_VALID.ordinal());
/*    */     } 
/*    */   }
/*    */ }


/* Location:              C:\Users\hossein\Desktop\classes\!\Controller\Admin\AdminInsertAuction.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.0.0
 */
package Controller.Admin;

/*    */ import DatabaseManager.AuctionManager;
/*    */ import Enum.StatusQuery;
/*    */ import java.io.IOException;
/*    */ import javax.servlet.ServletException;
/*    */ import javax.servlet.annotation.WebServlet;
/*    */ import javax.servlet.http.HttpServlet;
/*    */ import javax.servlet.http.HttpServletRequest;
/*    */ import javax.servlet.http.HttpServletResponse;
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
/*    */ @WebServlet(name = "AdminRemoveAuction", urlPatterns = {"/admin/removeauction"})
/*    */ public class AdminRemoveAuction
/*    */   extends HttpServlet
/*    */ {
/*    */   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
/* 36 */     if (request.getParameter("auctionid") != null) {
/* 37 */       if (AuctionManager.removeAuction(Integer.parseInt(request.getParameter("auctionid")))) {
/* 38 */         response.sendRedirect("/admin/auctionmanager?status=" + StatusQuery.SUCCESS.ordinal());
/*    */       } else {
/* 40 */         response.sendRedirect("/admin/auctionmanager?status=" + StatusQuery.FAILD.ordinal());
/*    */       } 
/*    */     } else {
/* 43 */       response.sendRedirect("/admin/auctionmanager?status=" + StatusQuery.PARAMETER_NOT_VALID.ordinal());
/*    */     } 
/*    */   }
/*    */ }


/* Location:              C:\Users\hossein\Desktop\classes\!\Controller\Admin\AdminRemoveAuction.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.0.0
 */
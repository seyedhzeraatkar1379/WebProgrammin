package Controller.Admin;

/*    */ import DatabaseManager.UserManager;
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
/*    */ 
/*    */ @WebServlet(name = "AdminChangeUserStatus", urlPatterns = {"/admin/changeuserstatus"})
/*    */ public class AdminChangeUserStatus
/*    */   extends HttpServlet
/*    */ {
/*    */   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
/* 37 */     if (request.getParameter("userid") != null) {
/*    */       
/* 39 */       UserManager.changeUserStatus(Integer.parseInt(request.getParameter("userid")));
/* 40 */       response.sendRedirect("/admin/usermanager?status=" + StatusQuery.SUCCESS.ordinal());
/*    */     } else {
/*    */       
/* 43 */       response.sendRedirect("/admin/usermanager?status=" + StatusQuery.PARAMETER_NOT_VALID.ordinal());
/*    */     } 
/*    */   }
/*    */ }


/* Location:              C:\Users\hossein\Desktop\classes\!\Controller\Admin\AdminChangeUserStatus.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.0.0
 */
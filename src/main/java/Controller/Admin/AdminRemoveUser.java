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
/*    */ @WebServlet(name = "AdminRemoveUser", urlPatterns = {"/admin/removeuser"})
/*    */ public class AdminRemoveUser
/*    */   extends HttpServlet
/*    */ {
/*    */   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
/* 35 */     if (request.getParameter("userid") != null) {
/*    */       
/* 37 */       int userId = Integer.parseInt(request.getParameter("userid"));
/* 38 */       UserManager.removeUser(userId);
/* 39 */       response.sendRedirect("/admin/usermanager?status=" + StatusQuery.SUCCESS.ordinal());
/*    */     } else {
/*    */       
/* 42 */       response.sendRedirect("/admin/usermanager?status=" + StatusQuery.PARAMETER_NOT_VALID.ordinal());
/*    */     } 
/*    */   }
/*    */ }


/* Location:              C:\Users\hossein\Desktop\classes\!\Controller\Admin\AdminRemoveUser.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.0.0
 */
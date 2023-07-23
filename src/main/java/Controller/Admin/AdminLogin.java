package Controller.Admin;

 import DatabaseManager.AdminManager;
 import Enum.AdminErrorLogin;
 import java.io.IOException;
 import javax.servlet.ServletException;
 import javax.servlet.annotation.WebServlet;
 import javax.servlet.http.HttpServlet;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpServletResponse;
 import javax.servlet.http.HttpSession;
 import Model.AdminTable;
 
 
 @WebServlet(urlPatterns = {"/admin/logincheck"}, name = "AdminLoginPage")
 public class AdminLogin
   extends HttpServlet
 {
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     String username = request.getParameter("username");
     String password = request.getParameter("password");
     
     AdminTable admin;
     
     if ((admin = AdminManager.AdminLogin(username, password)) != null) {
       HttpSession session = request.getSession();
       session.setAttribute("admin", admin);
       session.setMaxInactiveInterval(1200);
       response.sendRedirect("/admin/home");
       return;
     } else {
       
       response.sendRedirect("/admin/login?error=" + AdminErrorLogin.UserAndPassNotFound.ordinal());
       return;
     } 
   }
 }

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package Controller.UserController.Filter;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author hossein
 */
@WebFilter(filterName = "LoginFilter", urlPatterns = {"/user/*"})
public class Login implements Filter {

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        System.out.println(req.getRequestURI());
        if(req.getSession().getAttribute("user") == null)
        {
            if(req.getRequestURI().compareTo("/user/logincheck") == 0 || req.getRequestURI().compareTo("/user/register") == 0 || req.getRequestURI().compareTo("/user/login") == 0)
            {
                chain.doFilter(request, response);
            }
            else{
                res.sendRedirect("/user/login");
                return;
            }
        }
        else
        {
            if (req.getRequestURI().compareTo("/user/logincheck") == 0 || req.getRequestURI().compareTo("/user/register") == 0 || req.getRequestURI().compareTo("/user/login") == 0) {
                res.sendRedirect("/user/userpanel");
                return;
            }
            else
                chain.doFilter(request, response);
        }
        
    }

}

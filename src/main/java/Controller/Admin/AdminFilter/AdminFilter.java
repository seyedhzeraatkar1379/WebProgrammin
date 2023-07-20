package Controller.Admin.AdminFilter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebFilter(urlPatterns = {"/admin/*"})
public class AdminFilter
        implements Filter {

    public void init(FilterConfig arg0) throws ServletException {
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        HttpServletResponse httpServletResponse = (HttpServletResponse) response;

        if (httpServletRequest.getSession().getAttribute("admin") != null) {
            if (httpServletRequest.getRequestURI().compareTo("/admin/login") == 0 || httpServletRequest.getRequestURI().compareTo("/admin/logincheck") == 0) {
                httpServletResponse.sendRedirect("/admin/home");
            } else {
                chain.doFilter(request, response);
            }
        } else if (httpServletRequest.getRequestURI().compareTo("/admin/login") == 0 || httpServletRequest.getRequestURI().compareTo("/admin/logincheck") == 0) {
            chain.doFilter(request, response);
        } else {
            httpServletResponse.sendRedirect("/admin/login");
        }
    }

    public void destroy() {
    }
}

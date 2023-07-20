package Controller.Admin;

import DatabaseManager.ArtInfoManager;
import Enum.StatusQuery;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminRemoveArt", urlPatterns = {"/admin/removeart"})
public class AdminRemoveArt
        extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("artid") == null) {
            response.sendRedirect("/admin/artmanager?error=" + StatusQuery.FAILD.ordinal());
        } else {
            int artId = Integer.parseInt(request.getParameter("artid"));
            ArtInfoManager.removeArtById(artId);
            response.sendRedirect("/admin/artmanager?error=" + StatusQuery.SUCCESS.ordinal());
        }
    }
}

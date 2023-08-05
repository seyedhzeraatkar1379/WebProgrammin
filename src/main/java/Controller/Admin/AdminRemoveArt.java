package Controller.Admin;

import DatabaseManager.ArtInfoManager;
import Enum.StatusQuery;
import Model.ArtinfoTable;
import java.io.File;
import java.io.IOException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.io.FilenameUtils;

@WebServlet(name = "AdminRemoveArt", urlPatterns = {"/admin/removeart"})
public class AdminRemoveArt
        extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("artid") == null) {
            response.sendRedirect("/admin/artmanager?status=" + StatusQuery.PARAMETER_NOT_VALID.ordinal());
            return;
        } else {
            ArtinfoTable art = ArtInfoManager.getArtInfo(Integer.parseInt(request.getParameter("artid")));
            if (art != null) {
                if (art.getPhotoPath() != null) {
                    if (!art.getPhotoPath().isEmpty()) {
                        ServletContext servletContext = getServletContext();
                        File photo = new File(servletContext.getRealPath("/images/arts/") + art.getPhotoPath());
                        if(photo.exists())
                        {
                            photo.delete();
                        }
                    }
                }
                if (ArtInfoManager.removeArtById(art.getId())) {
                    response.sendRedirect("/admin/artmanager?statusrmv=" + StatusQuery.SUCCESS.ordinal());
                    return;
                }
            }
        }
        response.sendRedirect("/admin/artmanager?statusrmv=" + StatusQuery.FAILD_DEPENDENCY.ordinal());
        return;

    }
}

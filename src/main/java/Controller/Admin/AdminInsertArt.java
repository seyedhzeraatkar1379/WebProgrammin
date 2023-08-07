package Controller.Admin;

import Controller.Admin.AdminInsertArt;
import DatabaseManager.ArtInfoManager;
import Enum.StatusQuery;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Model.ArtinfoTable;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

@WebServlet(name = "insertArt", urlPatterns = {"/admin/insertart"})
public class AdminInsertArt
        extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String FaildUrl = "/admin/artmanager?statusinsert=" + StatusQuery.FAILD.ordinal();
        if (ServletFileUpload.isMultipartContent(request)) {
            ArtinfoTable newArt = new ArtinfoTable();
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletContext servletContext = getServletContext();
            File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
            factory.setRepository(repository);
            ServletFileUpload upload = new ServletFileUpload(factory);
            String pathartsImg = "";
            try {
                List<FileItem> items = upload.parseRequest(request);
                if (items.get(0).getFieldName().compareTo("nameart") == 0) {
                    if (items.get(1).getFieldName().compareTo("descriptionart") == 0) {
                        if (items.get(2).getFieldName().compareTo("photoart") == 0) {
                            if (items.get(0).getSize() != 0) {
                                newArt.setName(items.get(0).getString("UTF-8"));
                                newArt.setDescription(items.get(1).getString("UTF-8"));
                                if (ArtInfoManager.insertArt(newArt)) {
                                    if (!items.get(2).isFormField() && items.get(2).getSize() != 0) {
                                        //must be changed <-> (hosseinz)
                                        File path = new File(servletContext.getRealPath("/images/arts"));
                                        if (!path.exists()) {
                                            path.mkdir();
                                        }
                                        pathartsImg =  newArt.getName() + "-" + Integer.toString(newArt.getId())+"." + FilenameUtils.getExtension(items.get(2).getName());
                                        File uploadedFile = new File(path +"/"+ pathartsImg );
                                        if (!uploadedFile.exists()) {
                                            items.get(2).write(uploadedFile);
                                            newArt.setPhotoPath(pathartsImg);
                                            ArtInfoManager.updateArt(newArt);
                                            response.sendRedirect("/admin/artmanager?statusinsert=" + StatusQuery.SUCCESS.ordinal());
                                            return;
                                        }
                                    }
                                    response.sendRedirect("/admin/artmanager?statusinsert=" + StatusQuery.SUCCESS_IMAGE_FAILD.ordinal());
                                    return;
                                }
                            }
                        }
                    }
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        response.sendRedirect(FaildUrl);
        return;
    }
}

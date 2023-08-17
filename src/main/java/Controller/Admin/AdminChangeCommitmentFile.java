/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin;

import Enum.StatusQuery;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

/**
 *
 * @author hossein
 */
@WebServlet(name = "AdminChangeCommitmentFile", urlPatterns = {"/admin/changecommitment"})
public class AdminChangeCommitmentFile extends HttpServlet {

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //commitment
        if (ServletFileUpload.isMultipartContent(request)) {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletContext servletContext = getServletContext();
            File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
            factory.setRepository(repository);
            ServletFileUpload upload = new ServletFileUpload(factory);
            try {
                List<FileItem> items = upload.parseRequest(request);
                if (items.get(0).getFieldName().compareTo("commitment") == 0) {
                    File path = new File(servletContext.getRealPath("/file"));
                    if (!path.exists()) {
                        path.mkdir();
                    }
                    File uploadedFile = new File(path + "/commitment." + FilenameUtils.getExtension(items.get(0).getName()));//only pdf
                    if (!uploadedFile.exists()) {
                        items.get(0).write(uploadedFile);
                        response.sendRedirect("/admin/home?statuschangecommitment=" + StatusQuery.SUCCESS.ordinal());
                        return;
                    }else{
                        uploadedFile.delete();
                        items.get(0).write(uploadedFile);
                        response.sendRedirect("/admin/home?statuschangecommitment=" + StatusQuery.SUCCESS.ordinal());
                        return;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("/admin/home?statuschangecommitment=" + StatusQuery.FAILD.ordinal());
                return;
            }
        }
        response.sendRedirect("/admin/home?statuschangecommitment=" + StatusQuery.FAILD.ordinal());
        return;

    }
}

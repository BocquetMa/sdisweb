package servlet;

import database.DaoGrade;
import jakarta.servlet.ServletContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.util.ArrayList;
import model.Grade;

/**
 *
 * @author ts1sio
 */
@WebServlet(name = "ServletGrade", urlPatterns = {"/ServletGrade"})
public class ServletGrade extends HttpServlet {

    Connection cnx ;
            
    @Override
    public void init()
    {     
        ServletContext servletContext=getServletContext();
        cnx = (Connection)servletContext.getAttribute("connection");     
    }
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ServletGrade</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ServletGrade at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    
        String url = request.getRequestURI().toLowerCase(); 
     
        String[] args = url.split("/");  
       
        // Récup et affichage les eleves 
        if(args[3].equals("lister"))
        {              
            ArrayList<Grade> lesGrades = DaoGrade.getLesGrades(cnx);
            request.setAttribute("pLesGrades", lesGrades);
            getServletContext().getRequestDispatcher("/vues/grade/listerGrade.jsp").forward(request, response);
        }
        
        if(args[3].equals("consulter"))
        {  
            int idGrade = Integer.parseInt((String)request.getParameter("idGrade"));
            System.out.println( "Grade à afficher = " + idGrade);
            Grade g = DaoGrade.getGradeById(cnx, idGrade);
            request.setAttribute("pGrade", g);
            getServletContext().getRequestDispatcher("/vues/grade/consulterGrade.jsp").forward(request, response);       
        }

    }

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
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
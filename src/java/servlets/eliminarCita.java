/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.BD;

public class eliminarCita extends HttpServlet {

    private Connection con;
    private Statement set;
    private ResultSet rs;

    @Override
    public void init(ServletConfig cfg) throws ServletException {
        con = BD.getConexion();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession s = request.getSession();

        String tis = (String) s.getAttribute("tis");
        String numColegiado;
        String fecha;
        String hora;
        String dato = request.getParameter("cita");
        int indice1 = dato.indexOf(".");
        int indice2 = dato.indexOf(",");
        SimpleDateFormat p = new SimpleDateFormat("HH:mm");

        if (indice1 != -1 && indice2 != -1) {
            try {
                fecha = dato.substring(0, indice1);
                hora = dato.substring(indice1 + 1, indice2);
                numColegiado = dato.substring(indice2 + 1);
                
                hora = p.format(p.parse(hora));
                
                set = con.createStatement();
                set.executeUpdate("Delete from cita where tis = " + tis + " and numColegiado = " + numColegiado + " and fecha = \"" + fecha + "\" and hora = \"" + hora + "\"");
                /*try (PrintWriter out = response.getWriter()) {
                    out.println("<!DOCTYPE html>");
                    out.println("<html>");
                    out.println("<head>");
                    out.println("<title>Servlet eliminarCita</title>");
                    out.println("</head>");
                    out.println("<body>");
                    out.println("<h1>Fecha " + fecha + " hora " + hora + " numcolegiado" + numColegiado + "</h1>");
                    out.println("</body>");
                    out.println("</html>");
                }*/
            } catch (SQLException ex) {
                Logger.getLogger(eliminarCita.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ParseException ex) {
                Logger.getLogger(eliminarCita.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            response.sendRedirect("bajaCita");
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
        processRequest(request, response);
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

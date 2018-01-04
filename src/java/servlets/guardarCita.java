/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.BD;

public class guardarCita extends HttpServlet {

    private Connection con;
    private Statement set;
    private ResultSet rs;

    @Override
    public void init(ServletConfig cfg) throws ServletException {
        con = BD.getConexion();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession s = request.getSession();

        String tis = (String) s.getAttribute("tis");
        String numColegiado = (String) s.getAttribute("numColegiado");

        String p = request.getParameter("cita");

        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
        Date fe;

        int num = Integer.parseInt(p);

        if (num > 4) {//si es de la tabla con las horas de "mañana"
            fe = f.parse((String) s.getAttribute("f2"));
        } else {//si no, es de la tabla con las horas de "hoy"
            fe = f.parse((String) s.getAttribute("f1"));
        }
        String fecha = f.format(fe);

        String hora;
        switch (num) {
            case 1:
            case 5:
                hora = "09:15";
                break;
            case 2:
            case 6:
                hora = "09:30";
                break;
            case 3:
            case 7:
                hora = "09:45";
                break;
            default:
                hora = "10:00";
                break;
        }

        set = con.createStatement();
        set.executeUpdate("insert into cita values (" + tis + "," + numColegiado + ",\"" + fecha + "\",\"" + hora + "\")");
        /*
        try (PrintWriter out = response.getWriter()) {
            
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ServletVisualizar</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>tis: " + tis + "</h1>");
            out.println("<h1>numcolegiado: " + numColegiado + "</h1>");
        }*/
        response.sendRedirect("bajaCita");
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(guardarCita.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(guardarCita.class.getName()).log(Level.SEVERE, null, ex);
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(guardarCita.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(guardarCita.class.getName()).log(Level.SEVERE, null, ex);
        }
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

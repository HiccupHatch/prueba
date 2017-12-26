/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.text.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.BD;

/**
 *
 * @author Hiccup
 */
public class loginPaciente extends HttpServlet {

    private Connection con;
    private Statement set;
    private ResultSet rs;

    @Override
    public void init(ServletConfig cfg) throws ServletException {
        con = BD.getConexion();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        response.setContentType("text/html;charset=UTF-8");

        String tis = request.getParameter("TIS");

        String date = request.getParameter("fecha");
        
        boolean existe=false;
        
        try {
            set = con.createStatement();
            rs = set.executeQuery("SELECT * FROM paciente WHERE tis = " + tis + "");
            if (rs.next()) {
                String fecha = rs.getString("fechaNac");
                if (fecha.equals(date)) {
                    existe = true;
                    request.getRequestDispatcher("opcionesPac.html").forward(request, response);
                }
            }
            rs.close();
            set.close();
        } catch (SQLException ex1) {
            System.out.println("No lee de la tabla Paciente. " + ex1);
        }
        if(existe){
            request.getRequestDispatcher("opcionesPac.html").forward(request, response);
        }else{
            request.getRequestDispatcher("loginPaciente.jsp").forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(loginPaciente.class.getName()).log(Level.SEVERE, null, ex);
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
            System.err.println("potato0");
            Logger.getLogger(loginPaciente.class.getName()).log(Level.SEVERE, null, ex);
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

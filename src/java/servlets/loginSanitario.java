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
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.BD;

public class loginSanitario extends HttpServlet {

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
        
        String numColegiado = request.getParameter("nColegiado");
        
        boolean existe=false;
        HttpSession s = request.getSession();
        try {
            set = con.createStatement();
            rs = set.executeQuery("SELECT * FROM sanitario WHERE numColegiado = " + numColegiado + "");
            if (rs.next()) {
                    existe = true;
            }
            rs.close();
            set.close();
        } catch (SQLException ex1) {
            System.out.println("No lee de la tabla Paciente. " + ex1);
        }
        if(existe){
            //request.getRequestDispatcher("citasSanitario").forward(request, response);
            s.setAttribute("numColegiado", numColegiado);
            response.sendRedirect("citasSanitario");
        }else{
            //request.getRequestDispatcher("loginSanitario").forward(request, response);
            response.sendRedirect("loginSanitario");
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

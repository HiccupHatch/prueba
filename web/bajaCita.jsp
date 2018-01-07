<%-- 
    Document   : bajaCita
    Created on : 04-ene-2018, 11:31:04
    Author     : Hiccup
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="utils.BD"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="css/estilo.css" media="screen" />
    </head>
    <body>
        <header>
            <div id="a" >
                <h1><a href="index.html">OsaVito</a></h1> <div id="logout"> <a href="loginPaciente"><input type="button" value="Cerrar sesión" name="logout" /></a> </div>
            </div>
        </header>
        
        <p>A continuación se muestran las citas pasadas y las futuras.
        <p></p>
        <%!
            private Connection con;
            private Statement set, set2, set3;
            private ResultSet rs, rs2, rs3;

            public void jspInit() {
                con = BD.getConexion();
            }
        %>
        <%
            String tis = (String) session.getAttribute("tis");
            set = con.createStatement();
            rs = set.executeQuery("SELECT * FROM cita where tis = " + tis + " order by fecha");
            String numColegiado;
            
            Calendar calendario = Calendar.getInstance();
            int minutos;
            int horas;
            
            minutos = calendario.get(Calendar.MINUTE);
            horas = calendario.get(Calendar.HOUR);
            Date hoy = calendario.getTime();

            SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat p = new SimpleDateFormat("HH:mm");
            Date horahoy = p.parse(horas + ":" + minutos);
            boolean primeravez = true;
            String fechabd, horabd;
            while (rs.next()) {
                fechabd = rs.getString("fecha");
                horabd = rs.getString("hora");

                Date date1 = f.parse(fechabd);
                Date hora1 = p.parse(horabd);
        %><table id="1"> 
            <%if (date1.before(hoy) || (date1.equals(hoy) && hora1.before(horahoy))) {//fecha pasada u hoy pero todavía no ha llegado la hora de la cita
            %><tr>
                <td> <%= fechabd%>, <%=horabd%></td>
            </tr>
            <%} else {//todavía no ha pasado la cita
                if (primeravez) {
                    primeravez = false;
            %>
        </table>
        <form name="form" id="form" method="post" action="eliminarCita">
            <table id="2"> 
                <%}numColegiado = rs.getString("numColegiado");%>
                <tr><td><input type="radio" name="cita" value="<%=fechabd%>.<%=horabd%>,<%=numColegiado%>" id = "cita" checked="checked" /><%=fechabd%>, <%=horabd%></td>
              <%}
            }
            %></table>
            <p><input type="submit" value="Confirmar" id="confirmar" name ="cita"/>
        </form>
        
            <footer>
            <div id="b">
                <p>Copyright ® Osavito </p>
                <p>Información de contacto: <a href="mailto:osavito@osavito.com">
                osavito@osavito.com</a>.</p>
            </div>
        </footer>
    </body>    
</html>

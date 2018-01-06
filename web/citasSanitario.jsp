<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="utils.BD"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%!
            private Connection con;
            private Statement set, set2, set3;
            private ResultSet rs, rs2, rs3;

            public void jspInit() {
                con = BD.getConexion();
            }
        %>
        <%
            String numColegiado = (String) session.getAttribute("numColegiado");
            set = con.createStatement();
            rs = set.executeQuery("SELECT * FROM cita where numColegiado = " + numColegiado + " order by fecha");
            SimpleDateFormat p = new SimpleDateFormat("HH:mm");
            SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
            
            Calendar calendario = Calendar.getInstance();
            int minutos;
            int horas;
            
            minutos = calendario.get(Calendar.MINUTE);
            horas = calendario.get(Calendar.HOUR);
            Date hoy = calendario.getTime();
            Date horahoy = p.parse(horas + ":" + minutos);
            %>
            <table id ="1">Estas son sus citas
        <%while (rs.next()) {
            String dia = rs.getString("fecha");
            Date fechabd = f.parse(dia);
            String hora = rs.getString("hora");
            Date horabd = p.parse(hora);
            
            String tis = rs.getString("tis");
            set2 = con.createStatement();
            rs2 = set2.executeQuery("Select nombre from paciente where tis = "+ tis);
            String nombrePaci = null;
            while(rs2.next()){
                nombrePaci = rs2.getString("nombre");
            }      
            if(fechabd.after(hoy) || (fechabd.equals(hoy) && horabd.after(horahoy))){//solo las citas posteriores%>
    <tr><td>Día: <%=dia%>. Hora: <%=hora%> Paciente: <%=tis%>, <%=nombrePaci%></td></tr>
            <%}
        }%>
        </table>
    </body>
</html>

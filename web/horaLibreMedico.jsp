<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="utils.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>OSAVITO DEL GRUPO 08</title>
        <link rel="stylesheet" type="text/css" href="css/estilo.css" media="screen" />
    </head>
    <body>
        <header>
            <div id="a">
                <h1><a href="index.html">OsaVito</a></h1>
            </div>
        </header>

        <%!
            private Connection con;
            private Statement set, set2, set3, set4;
            private ResultSet rs, rs2, rs3, rs4;

            public void jspInit() {
                con = BD.getConexion();
            }

        %>
        <%
            String numColegiado = (String) session.getAttribute("numColegiado");
            String tis = (String) session.getAttribute("tis");
            set = con.createStatement();
            rs = set.executeQuery("SELECT * FROM cita where numColegiado = " + numColegiado);
            String fecha = (String) session.getAttribute("fecha");

            SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");

            SimpleDateFormat f2 = new SimpleDateFormat("dd-MM-yyyy");

            java.util.Date date1 = f.parse(fecha);

            Calendar cal = new GregorianCalendar();
            cal.setTime(date1);
            if (cal.get(Calendar.DAY_OF_WEEK) == 6) {//si el día escogido es viernes
                cal.add(Calendar.DAY_OF_MONTH, 3);//el siguiente día será lunes
            } else {
                cal.add(Calendar.DAY_OF_MONTH, 1);
            }
            java.util.Date nextDay = cal.getTime();
            
            session.setAttribute("f1", f.format(date1));
            session.setAttribute("f2", f.format(nextDay));
            /*
            cal.setTime(date1);
            if(cal.get(Calendar.DAY_OF_WEEK) == 2){//si el día escogido es lunes (domigno -> 1, lunes -> 2) 
                cal.add(Calendar.DAY_OF_MONTH, -3);//el día anterior será viernes
            }else{
                cal.add(Calendar.DAY_OF_MONTH, -1);
            }
            java.util.Date prevDay = cal.getTime();
             */
            //Comprobamos qué horas se puede escoger hoy
            boolean mas15 = false, mas30 = false, mas45 = false;
            Calendar calendario = Calendar.getInstance();
            int minutos;
            minutos = calendario.get(Calendar.MINUTE);
            if (minutos > 15) {
                mas15 = true;
                if (minutos > 30) {
                    mas30 = true;
                    if (minutos > 45) {
                        mas45 = true;
                    }
                }
            }

            boolean h1 = false, h2 = false, h3 = false, h4 = false; //Los buleanos para saber si el día elegido el médico está ocupado
            boolean m1 = false, m2 = false, m3 = false, m4 = false;
            //hacemos el select * para hoy
            set = con.createStatement();
            rs = set.executeQuery("SELECT * FROM cita where numColegiado = " + numColegiado + " and fecha = \"" + f.format(date1).toString() + "\"");
            while (rs.next()) {
                if (rs.getString("hora").equals("09:15")) {
                    h1 = true;
                }
                if (rs.getString("hora").equals("09:30")) {
                    h2 = true;
                }
                if (rs.getString("hora").equals("09:45")) {
                    h3 = true;
                }
                if (rs.getString("hora").equals("10:00")) {
                    h4 = true;
                }
            }

            set2 = con.createStatement();
            rs2 = set2.executeQuery("SELECT * FROM cita where numColegiado = " + numColegiado + " and fecha = \"" + f.format(nextDay) + "\"");
            while (rs2.next()) {
                if (rs2.getString("hora").equals("09:15")) {
                    m1 = true;
                }
                if (rs2.getString("hora").equals("09:30")) {
                    m2 = true;
                }
                if (rs2.getString("hora").equals("09:45")) {
                    m3 = true;
                }
                if (rs2.getString("hora").equals("10:00")) {
                    m4 = true;
                }
            }
            
            boolean p1 = false, p2 = false, p3 = false, p4 = false;
            boolean p5 = false, p6 = false, p7 = false, p8 = false;
            set3 = con.createStatement();
            rs3 = set3.executeQuery("SELECT * FROM cita where tis = " + tis + " and fecha = \"" + f.format(date1).toString() + "\"");
            while (rs3.next()) {
                if (rs3.getString("hora").equals("09:15")) {
                    p1 = true;
                }
                if (rs3.getString("hora").equals("09:30")) {
                    p2 = true;
                }
                if (rs3.getString("hora").equals("09:45")) {
                    p3 = true;
                }
                if (rs3.getString("hora").equals("10:00")) {
                    p4 = true;
                }
            }
            
            set4 = con.createStatement();
            rs4 = set4.executeQuery("SELECT * FROM cita where tis = " + tis + " and fecha = \"" + f.format(nextDay) + "\"");
            while (rs4.next()) {
                if (rs4.getString("hora").equals("09:15")) {
                    p1 = true;
                }
                if (rs4.getString("hora").equals("09:30")) {
                    p2 = true;
                }
                if (rs4.getString("hora").equals("09:45")) {
                    p3 = true;
                }
                if (rs4.getString("hora").equals("10:00")) {
                    p4 = true;
                }
            }
        %>
        <h3>Buenos días <%=session.getAttribute("nombre")%></h3>
        <h3>Éstas son las horas libres del sanitario <%=session.getAttribute("nombreCol")%> con número de colegiado <%=session.getAttribute("numColegiado")%> </h3>
        <h3>Cerca del día <%=f.format(date1)%></h3>
        <%if (h1 && h2 && h3 && h4 && m1 && m2 && m3 && m4) {%>
        <h2> No hay citas disponibles para el día seleccionado y el siguiente, elija cita para otro día </h2>
        <%} else {%>
        <form name="form" id="form" method="post" action="guardarCita">
            <table id="1"><%=f.format(date1)%>
                <tr><td><input type="radio" name="cita" value="<%=1%>" id = "cita" checked="checked" />09:15</td>
                    <td><input type="radio" name="cita" value="2" id = "cita" checked="checked" />09:30<td/></tr>
                <tr><td><input type="radio" name="cita" value="3" id = "cita" checked="checked" />09:45</td>
                    <td><input type="radio" name="cita" value="4" id = "cita" checked="checked" />10:00<td/></tr>
            </table>

            <table id ="2"><%=f.format(nextDay)%>
                <tr><td><input type="radio" name="cita" value="5" id = "cita" checked="checked" />09:15</td>
                    <td><input type="radio" name="cita" value="6" id = "cita" checked="checked" />09:30<td/></tr>
                <tr><td><input type="radio" name="cita" value="7" id = "cita" checked="checked" />09:45</td>
                    <td><input type="radio" name="cita" value="8" id = "cita" checked="checked" />10:00<td/></tr>
            </table>
            <p><input type="submit" value="Confirmar" id="confirmar" name ="cita"/>
        </form>
        
        <%}%>
    </body>
</html>

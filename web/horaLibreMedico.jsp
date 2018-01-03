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
            private Statement set, set2, set3;
            private ResultSet rs, rs2, rs3;

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

            java.util.Date date1 = f.parse(fecha);

            Calendar cal = new GregorianCalendar();
            cal.setTime(date1);
            if (cal.get(Calendar.DAY_OF_WEEK) == 6) {//si el día escogido es viernes
                cal.add(Calendar.DAY_OF_MONTH, 3);//el siguiente día será lunes
            } else {
                cal.add(Calendar.DAY_OF_MONTH, 1);
            }
            java.util.Date nextDay = cal.getTime();

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
            set2 = con.createStatement();
            rs2 = set2.executeQuery("SELECT * FROM cita where numColegiado = " + numColegiado + "and fecha =" + date1);
            while (rs2.next()) {
                if (rs2.getString("hora").equals("09:15")) {
                    h1 = true;
                }
                if (rs2.getString("hora").equals("09:30")) {
                    h2 = true;
                }
                if (rs2.getString("hora").equals("09:45")) {
                    h3 = true;
                }
                if (rs2.getString("hora").equals("10:00")) {
                    h4 = true;
                }
            }
            
            set = con.createStatement();
            rs = set.executeQuery("SELECT * FROM cita where numColegiado = " + numColegiado + "and fecha =" + nextDay);
            while (rs.next()) {
                if (rs.getString("hora").equals("09:15")) {
                    m1 = true;
                }
                if (rs.getString("hora").equals("09:30")) {
                    m2 = true;
                }
                if (rs.getString("hora").equals("09:45")) {
                    m3 = true;
                }
                if (rs.getString("hora").equals("10:00")) {
                    m4 = true;
                }
            }
        %>
        <h2>Buenos días <%=session.getAttribute("nombre")%></h2>
        <h2>Éstas son las horas libres del sanitario <%=session.getAttribute("nombreCol")%></h2>
        <h2>Cerca del día <%=fecha%></h2>
        <%if(h1 && h2 && h3 && h4 && m1 && m2 && m3 && m4){%>
        <h2> No hay citas disponibles para el día seleccionado y el siguiente, elija cita para otro día </h2>
        <%}
else{%>
        <table><%=f.format(date1)%>
        
        <tr><td>1</td> <td>2<td/></tr>
        <tr><td>3</td> <td>4<td/></tr>
        </table>
        
        <table><%=f.format(nextDay)%>
        
        <tr><td>1</td> <td>2<td/></tr>
        <tr><td>3</td> <td>4<td/></tr>
        </table>
         
        <%
        %>
        <form name="elegirHora" id="horaLibre" method="post" action="horaCita">
            <p>Hora:
                <select id="hora" name="hora" required="">
                    
                    <option value="<%="09:00"%>"><%=f.format(date1)%>, 09:00</option>
                    
                    <option value="<%="09:00"%>"><%="09:00"%></option>
                </select>
            <p><input type="submit" value="Escoger" id ="confirmar" name ="horaLibre"/>
        </form>
        <%}%>
    </body>
</html>

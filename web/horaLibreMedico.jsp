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
            if(cal.get(Calendar.DAY_OF_WEEK) == 6){//si el día escogido es viernes
                cal.add(Calendar.DAY_OF_MONTH, 3);//el siguiente día será lunes
            }else{
                cal.add(Calendar.DAY_OF_MONTH, 1);
            }
            java.util.Date nextDay = cal.getTime();

            cal.setTime(date1);
            if(cal.get(Calendar.DAY_OF_WEEK) == 2){//si el día escogido es lunes (domigno -> 1, lunes -> 2) 
                cal.add(Calendar.DAY_OF_MONTH, -3);//el día anterior será viernes
            }else{
                cal.add(Calendar.DAY_OF_MONTH, -1);
            }
            java.util.Date prevDay = cal.getTime();

            boolean citaa = false, citah = false, citam = false;

            boolean citaap = false, citahp = false, citamp = false;
            //las siguientes variables son para saber si alguna hora está asignada para ese sanitario, true sería hora ocupada
            boolean q = false, w = false, e = false, r = false, t = false, y = false, u = false, i = false;
            boolean qq = false, ww = false, ee = false, rr = false, tt = false, yy = false, uu = false, ii = false;
            boolean qqq = false, www = false, eee = false, rrr = false, ttt = false, yyy = false, uuu = false, iii = false;
            //las siguientes variables son para saber si alguna hora está asignada para ese paciente, true sería hora ocupada
            boolean q1 = false, w1 = false, e1 = false, r1 = false, t1 = false, y1 = false, u1 = false, i1 = false;
            boolean qq1 = false, ww1 = false, ee1 = false, rr1 = false, tt1 = false, yy1 = false, uu1 = false, ii1 = false;
            boolean qqq1 = false, www1 = false, eee1 = false, rrr1 = false, ttt1 = false, yyy1 = false, uuu1 = false, iii1 = false;

        %>
        <h1>Buenos días <%=session.getAttribute("nombre")%></h1>
        <h1>Éstas son las horas libres del sanitario <%=session.getAttribute("nombreCol")%></h1>
        <h2>Cerca del día <%=fecha%></h2>
        <form name="elegirHora" id="horaLibre" method="post" action="horaCita">
            <p>Hora:
                <select id="hora" name="hora" required="">
                    <%while (rs.next()) {
                            String fecha2 = rs.getString("fecha");
                            java.util.Date date2 = f.parse(fecha2);

                            if (prevDay.equals(date2)) {
                                citaa = true;//con esto sabemos que hay alguna cita para el día anterior
                                if (rs.getString("hora").equals("09:00")) {
                                    q = true;
                                }
                                if (rs.getString("hora").equals("09:15")) {
                                    w = true;
                                }
                                if (rs.getString("hora").equals("09:30")) {
                                    e = true;
                                }
                                if (rs.getString("hora").equals("09:45")) {
                                    r = true;
                                }
                                if (rs.getString("hora").equals("10:00")) {
                                    t = true;
                                }
                                if (rs.getString("hora").equals("10:15")) {
                                    y = true;
                                }
                                if (rs.getString("hora").equals("10:30")) {
                                    u = true;
                                }
                                if (rs.getString("hora").equals("10:45")) {
                                    i = true;
                                }
                            }
                            if (date1.equals(date2)) {
                                citah = true;//con esto sabemos que hay alguna cita para el día en concreto
                                if (rs.getString("hora").equals("09:00")) {
                                    qq = true;
                                }
                                if (rs.getString("hora").equals("09:15")) {
                                    ww = true;
                                }
                                if (rs.getString("hora").equals("09:30")) {
                                    ee = true;
                                }
                                if (rs.getString("hora").equals("09:45")) {
                                    rr = true;
                                }
                                if (rs.getString("hora").equals("10:00")) {
                                    tt = true;
                                }
                                if (rs.getString("hora").equals("10:15")) {
                                    yy = true;
                                }
                                if (rs.getString("hora").equals("10:30")) {
                                    uu = true;
                                }
                                if (rs.getString("hora").equals("10:45")) {
                                    ii = true;
                                }
                            }

                            if (nextDay.equals(date2)) {
                                citam = true;//con esto sabemos que hay alguna cita para el día siguiente
                                if (rs.getString("hora").equals("09:00")) {
                                    qqq = true;
                                }
                                if (rs.getString("hora").equals("09:15")) {
                                    www = true;
                                }
                                if (rs.getString("hora").equals("09:30")) {
                                    eee = true;
                                }
                                if (rs.getString("hora").equals("09:45")) {
                                    rrr = true;
                                }
                                if (rs.getString("hora").equals("10:00")) {
                                    ttt = true;
                                }
                                if (rs.getString("hora").equals("10:15")) {
                                    yyy = true;
                                }
                                if (rs.getString("hora").equals("10:30")) {
                                    uuu = true;
                                }
                                if (rs.getString("hora").equals("10:45")) {
                                    iii = true;
                                }
                            }
                        }
                        java.util.Date today = Calendar.getInstance().getTime();
                        String reportDate = f.format(today);
                        java.util.Date hoy = f.parse(reportDate);
                        if(!prevDay.equals(hoy)){//si día escogido es mañana, comprobar si hay hoy disponible tras hora actual
                            
                        }
                        if (!q && !q1) {
                            Calendar cal1 = new GregorianCalendar();
                            cal.setTime(date1);
                            cal.add(Calendar.DAY_OF_MONTH, 1);
                            java.util.Date todayDay = cal1.getTime();
                            java.util.Date todayDate = new java.util.Date();

                    %>
                    <option value="<%="09:00"%>"><%=f.format(prevDay)%>, 09:00</option>
                    <%}%>
                    <option value="<%="09:00"%>"><%="09:00"%></option>
                </select>
            <p><input type="submit" value="Escoger" id ="confirmar" name ="horaLibre"/>
        </form>
    </body>
</html>

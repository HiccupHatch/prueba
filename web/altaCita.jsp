<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="utils.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>OSAVITO DEL GRUPO 08</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="js/validacion.js"></script>
    </head>
    <body>
        <%!
            private Connection con;
            private Statement set, set2, set3;
            private ResultSet rs, rs2, rs3;

            public void jspInit() {
                con = BD.getConexion();
            }

            ;             
        %>
        <%
            String tis = (String) session.getAttribute("tis");
            int numColegiado;
            set = con.createStatement();
            rs = set.executeQuery("SELECT numColegiado FROM sanipac where tis = " + tis);

        %>
        <form name="asignarPaciente" id="altaCita" method="post" action="horaCita">Elija un sanitario, <%=session.getAttribute("nombre")%>:
            <p>Sanitario: <select id="info" name="info" required="">
                    <%while (rs.next()) {
                            numColegiado = rs.getInt("numColegiado");
                            set2 = con.createStatement();
                            rs2 = set2.executeQuery("Select * From sanitario where numColegiado =" + numColegiado);
                            if (rs2.next()) {
                                String tipo;
                                switch (rs2.getString("tipoSani")) {
                                    case "ME":
                                        tipo = "Medicina";
                                        break;
                                    case "EN":
                                        tipo = "Enfermería";
                                        break;
                                    default: tipo = "Obstetricia";
                                        break;
                                }

                    %>
                    <option value="<%=numColegiado%>"><%=tipo%>, <%=rs2.getString("nombre")%></option>
                    <%      }
                        }%>
                </select>
            <p>Fecha: <input type="date" id="fecha" name="fecha" required="">
            <%--<p>Hora: <input type="time" id="hora" name="hora" step="900" min="09:00" max="10:00" required="">--%>
            <p><input type="submit" value="Siguiente" id ="confirmar" name ="altaCita"/>
        </form>
        <a href="opcionesPac"><input type="button" value="Cancelar" name="Cancelar" />
    </body>
</html>

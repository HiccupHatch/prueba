<%-- 
    Document   : opcionesPac
    Created on : 28-dic-2017, 15:09:06
    Author     : Hiccup
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>OSAVITO DEL GRUPO 08</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="css/estilo.css" media="screen" />
        <script src="js/logout.js"></script>
    </head>
    <body>
         <header>
            <div id="a">
                <h1><a href="index.html">OsaVito</a></h1>
            </div>
        </header>
        
        <form>Elija la acci&oacuten que desea realizar, <%=session.getAttribute("nombre")%>:
            <p><a href="seleccionarSanitario"><input type="button" value="Solicitar cita" name="btnAlta" /> </a>
            <p><a href="bajaCita.html"><input type="button" value="Eliminar cita" name="btnBaja" /> </a>
            
        </form>
        <input type="button" value="Logout" name="logout" />
    </body>
</html>

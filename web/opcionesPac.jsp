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
            <div id="a" >
                <h1><a href="index.html">OsaVito</a></h1> <div id="logout"> Cerrar sesi&oacuten </div>
            </div>
        </header>
        
        <form>Elija la acci&oacuten que desea realizar, <%=session.getAttribute("nombre")%>:
            <p><a href="seleccionarSanitario"><input type="button" value="Solicitar cita" name="btnAlta" /> </a>
            <p><a href="bajaCita.html"><input type="button" value="Eliminar cita" name="btnBaja" /> </a>
            <p><a href="loginPaciente"><input type="button" value="Cerrar sesión" name="logout" /></a>
        </form>
        
        <footer>
            <div id="b">
                <p>Osavito footer</p>
                <p>Información de contacto: <a href="mailto:osavito@gmail.com">
                osavito@gmail.com</a>.</p>
            </div>
        </footer>
    </body>
</html>

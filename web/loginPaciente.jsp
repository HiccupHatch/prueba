<%-- 
    Document   : loginPaciente
    Created on : 26-dic-2017, 10:52:21
    Author     : Hiccup
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>OSAVITO DEL GRUPO 08</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        <script src="js/baseDeDatos.js"></script>
    </head>
    <body>
        <section>
            <form name="fLoginPac" id="fLoginPac" method="post" action="loginPaciente">
                Paciente (TIS): <input type="text" name="TIS" id="TIS" pattern="[0-9]{8}" maxlength="8" required=""/>
                Fecha nacimiento: <input type="date" name="fecha" id="fecha" required=""/>
                <input type="submit" value="Confirmar" id ="confirmar" name ="confirmarPac"/>
            </form>
        </section>
    </body>
</html>

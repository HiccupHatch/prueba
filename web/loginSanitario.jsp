<%-- 
    Document   : loginSanitario
    Created on : 28-dic-2017, 10:49:38
    Author     : Hiccup
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>OSAVITO DEL GRUPO 08</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <section>
            <form name="fLoginPac" id="fLoginPac" method="get" action="">
                Nº colegiado: <input type="number" name="nColegiado" id="nColegiado" required=""/>
                Fecha nacimiento: <input type="date" name="fecha" id="fecha" required=""/>
                <input type="submit" value="Confirmar" name ="confirmarSan"/>
            </form>
        </section>
    </body>
</html>
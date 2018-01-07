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
        <link rel="stylesheet" type="text/css" href="css/estilo.css" media="screen" />
    </head>
    <body>
         <header>
            <div id="a">
                <h1><a href="index.html">OsaVito</a></h1>
            </div>
        </header>
        
        <section>
            <form name="fLoginPac" id="fLoginPac" method="get" action="sLoginSanitario">
                Nº colegiado: <input type="number" name="nColegiado" pattern="[0-9]{9}" maxlength="9" id="nColegiado" required=""/>
                <input type="submit" value="Confirmar" name ="confirmarSan"/>
            </form>
        </section>
        
        <footer>
            <div id="b">
                <p>Copyright ® Osavito </p>
                <p>Información de contacto: <a href="mailto:osavito@osavito.com">
                osavito@osavito.com</a>.</p>
            </div>
        </footer>
    </body>
</html>
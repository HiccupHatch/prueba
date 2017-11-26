window.addEventListener('load', iniciar, false);

function iniciar() {
    var boton = document.getElementById("confirmarPac");
    boton.addEventListener('click', go, false);
}

function go() {
    if (window.document.getElementById('contraseña').value == "admin" && window.document.getElementById('usuario').value == "admin") {
        window.open("opcionesAdmin.html");
        window.close();
    } else {
        window.alert("Por favor ingrese nombre de usuario y contraseña correctos.");
    }
}

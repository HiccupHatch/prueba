window.addEventListener('load', iniciar, false);

function iniciar() {
    var boton = document.getElementById('confirmar');
    boton.addEventListener('click', nuevoitem, false);
    mostrar();
}
function nuevoitem() {
    var clave = document.getElementById('tis').value;
    var valor = document.getElementById('texto').value;
    sessionStorage.setItem(clave, valor);
    mostrar();
    document.getElementById('clave').value = '';
    document.getElementById('texto').value = '';
}
function mostrar() {
    var cajadatos = document.getElementById('cajadatos');
    cajadatos.innerHTML = '';
    for (var f = 0; f < sessionStorage.length; f++) {
        var clave = sessionStorage.key(f);
        var valor = sessionStorage.getItem(clave);
        cajadatos.innerHTML += '<div>' + clave + ' - ' + valor + '</div>';
    }
}
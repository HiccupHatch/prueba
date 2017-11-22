window.addEventListener('load', go, false);

function go() {
    if (document.form.password.value == 'admin' && document.form.login.value == 'admin') {
        document.form.submit();
    } else {
        alert("Porfavor ingrese, nombre de usuario y contraseña correctos.");
    }
}

function nuevoitem() {
    var clave = document.getElementById('clave').value;
    var valor = document.getElementById('texto').value;
    localStorage.setItem(clave, valor);
    mostrar();
    document.getElementById('clave').value = '';
    document.getElementById('texto').value = '';
}
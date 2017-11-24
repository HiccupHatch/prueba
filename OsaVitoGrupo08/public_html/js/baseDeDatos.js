window.addEventListener('load', iniciar, false);

var bd = null;

function iniciar() {
    cajadatos = document.getElementById('cajadatos');
    var btnGrabar;
    if(document.getElementById('confirmar').name == "paciente"){
        btnGrabar = document.getElementById('confirmar');
        btnGrabar.addEventListener('click', agregarPaciente, false);
        alert("Funciona");
    }
        
    var indexedDB = window.indexedDB || window.mozIndexedDB || window.webkitIndexedDB || window.msIndexedDB;
    var solicitud = indexedDB.open("base");
    solicitud.onupgradeneeded = function (e) {
        bd = e.target.result;
        var ob = bd.createObjectStore("paciente", { keyPath : 'id', autoIncrement : true });
        ob.createIndex('by_tis', 'tis', { unique : false });
    };
    solicitud.onsuccess = function (e) {
        bd = e.target.result;
        //alert('Database loaded '+bd);
    };
    solicitud.onerror = function (e) {
        alert('Error loading database'+bd);
    };
    
}

function agregarPaciente() {
    //var active = bd.result;
    var data = bd.transaction(["paciente"], "readwrite");
    var object = data.objectStore("paciente");

    var request = object.put({
        nombre : document.querySelector("#nombre").value,
        tis : document.querySelector("#tis").value,
        fechaNacimiento : document.querySelector("#fechaNacimiento").value,
        movil : document.querySelector("#movil").value,
        sexo : document.querySelector("#sexo").value
    });

    request.onerror = function (e) {
        alert(request.error.name + '\n\n' + request.error.message);
    };

    data.oncomplete = function (e) {
        document.querySelector("#nombre").value = '';
        document.querySelector('#tis').value = '';
        document.querySelector('#fechaNacimiento').value = '';
        document.querySelector("#movil").value = '';
        document.querySelector("#sexo").value = '';
        alert('Paciente agregado');
        mostrarBaseDeDatos();
    };
}

function mostrarBaseDeDatos() {
    var data = bd.transaction(["paciente"], "readonly");
    var object = data.objectStore("paciente");
    var elements = [];

    object.openCursor().onsuccess = function (e) {
        var result = e.target.result;
        if (result === null) {
            return;
        }
        elements.push(result.value);
        result.continue();
    };

    data.oncomplete = function() {
        var outerHTML = '';
        for (var key in elements) {
            outerHTML += '<div>' + elements[key].nombre + ' - ' + elements[key].tis + ' - '
                                 + elements[key].fechaNacimiento + elements[key].movil + elements[key].sexo + '</div>';
        }
        elements = [];
        document.querySelector("#cajadatos").innerHTML = outerHTML;
    };
}

function buscarObjetos() {
    cajadatos.innerHTML = '';
    var fechaBuscar = document.getElementById('fechaBusqueda').value;
    var transaccion = bd.transaction(['peliculas']);
    var almacen = transaccion.objectStore('peliculas');
    var indice = almacen.index('by_fecha');
    var request = indice.get(String(fechaBuscar));
    request.onsuccess = function () {
        var result = request.result;
        if (result !== undefined) {
            alert("Datos: \n\Clave: " + result.clave + "\n\
            Película: " + result.texto + "\n\
            Fecha: " + result.fecha);
            
            cajadatos.innerHTML += '<div>' + result.id + 
                ' - '+result.texto+' - '+result.fecha+'</div>';
            result.continue();
        }
    };
};
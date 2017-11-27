/* global IDBKeyRange */

window.addEventListener('load', iniciar, false);

var bd = null;

function iniciar() {
    cajadatos = document.getElementById('cajadatos');
    var btnGrabar;
    btnGrabar = document.getElementById('confirmar');
    if (document.getElementById('confirmar').name == "paciente") {
        btnGrabar.addEventListener('click', agregarPaciente, false);
    } else if (document.getElementById('confirmar').name == "sanitario") {
        btnGrabar.addEventListener('click', agregarSanitario, false);
    } else if (document.getElementById('confirmar').name == "asignarPac") {
        btnGrabar.addEventListener('click', elegirPaciente, false);
        document.getElementById("sanit").addEventListener('click', elegirSanitario, false);
        document.getElementById("enviar").addEventListener('click', agregarSaniPac, false);
    } else if (document.getElementById('confirmar').name == "confirmarPac") {
        btnGrabar.addEventListener('click', confirmarLogin, false);
    } else if (document.getElementById('confirmar').name == "altaCita") {
        document.getElementById("confirmar").addEventListener('click', agregarCita, false);
    }

    var indexedDB = window.indexedDB || window.mozIndexedDB || window.webkitIndexedDB || window.msIndexedDB;
    var solicitud = indexedDB.open("osavito08");

    solicitud.onupgradeneeded = function (e) {
        bd = e.target.result;

        var ob = bd.createObjectStore("paciente", {keyPath: 'id', autoIncrement: true});
        ob.createIndex('by_tis', 'tis', {unique: false});

        var ob2 = bd.createObjectStore("sanitario", {keyPath: 'id', autoIncrement: true});
        ob2.createIndex('by_nColegiado', 'nColegiado', {unique: false});
        ob2.createIndex('by_especialidad', 'especialidad', {unique: false});

        var ob3 = bd.createObjectStore("cita", {keyPath: 'id', autoIncrement: true});
        ob3.createIndex('by_tis', 'tis', {unique: false});
        ob3.createIndex('by_nColegiado', 'nColegiado', {unique: false});
        ob3.createIndex('by_fecha', 'fecha', {unique: false});
        ob3.createIndex('by_hora', 'hora', {unique: false});

        var ob4 = bd.createObjectStore("sanipac", {keyPath: 'id', autoIncrement: true});
        ob4.createIndex('by_tis', 'tis', {unique: false});
        ob4.createIndex('by_nColegiado', 'nColegiado', {unique: false});
        ob4.createIndex('by_especialidad', 'especialidad', {unique: false});
    };
    
    solicitud.onsuccess = function (e) {
        bd = e.target.result;
        //alert('Database loaded ' + bd);
        mostrarBaseDeDatos();
        if (document.getElementById('confirmar').name == "asignarPac") {
            var data = bd.transaction(["paciente"], "readonly");
            var obj = data.objectStore("paciente");
            var elementos = [];
            obj.openCursor().onsuccess = function (e) {
                var result = e.target.result;
                if (result === null) {
                    return;
                }
                elementos.push(result.value);
                result.continue();
            };
            data.oncomplete = function () {
                var opt = document.getElementById("tis");
                for (var key in elementos) {
                    var option = document.createElement("option");
                    option.value = elementos[key].tis;
                    var optionText = document.createTextNode(elementos[key].tis);
                    option.appendChild(optionText);
                    opt.appendChild(option);
                }
                elementos = [];
            };
        } else if (document.getElementById('confirmar').name == "altaCita") {
            elegirSanitario2();
        }
    };
    solicitud.onerror = function (e) {
        alert('Error loading database' + bd);
    };

}

function agregarPaciente() {
    //var active = bd.result;
    var data = bd.transaction(["paciente"], "readwrite");
    var object = data.objectStore("paciente");

    var radios = document.getElementsByName('sexo');
    var sex;

    if (radios[0].checked) {
        sex = radios[0].value;
    } else {
        sex = radios[1].value;
    }

    var request = object.put({
        nombre: document.querySelector("#nombre").value,
        sexo: sex,
        tis: document.querySelector("#tis").value,
        fechaNacimiento: document.querySelector("#fechaNacimiento").value,
        movil: document.querySelector("#movil").value
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
    };
}

function agregarSanitario() {
    //var active = bd.result;
    var data = bd.transaction(["sanitario"], "readwrite");
    var object = data.objectStore("sanitario");

    var request = object.put({
        nombre: document.querySelector("#nombre").value,
        especialidad: document.querySelector("#especialidad").value,
        nColegiado: document.querySelector("#nColegiado").value
    });

    request.onerror = function (e) {
        alert(request.error.name + '\n\n' + request.error.message);
    };

    data.oncomplete = function (e) {
        document.querySelector("#nombre").value = '';
        document.querySelector('#especialidad').value = '';
        document.querySelector('#nColegiado').value = '';
        alert('Sanitario agregado');
    };
}

function agregarSaniPac() {
    //var active = bd.result;
    var data = bd.transaction(["sanipac"], "readwrite");
    var object = data.objectStore("sanipac");

    var request = object.put({
        tis: document.querySelector("#tis").value,
        especialidad: document.querySelector("#info").value,
        nColegiado: document.querySelector("#nColegiado").value
    });

    request.onerror = function (e) {
        alert(request.error.name + '\n\n' + request.error.message);
    };

    data.oncomplete = function (e) {
        document.querySelector("#tis").value = '';
        document.querySelector('#info').value = '';
        document.querySelector('#nColegiado').value = '';
        alert('Sanitario agregado');
    };
}

function agregarCita(){
    //var active = bd.result;
    var data = bd.transaction(["cita"], "readwrite");
    var object = data.objectStore("cita");
    var tis = sessionStorage.getItem("tis");
    var request = object.put({
        tis: tis,
        nColegiado: document.querySelector("#info").value,
        fecha: document.querySelector("#fecha").value,
        hora: document.querySelector("#hora").value
    });
    
    request.onerror = function (e) {
        alert(request.error.name + '\n\n' + request.error.message);
    };

    data.oncomplete = function (e) {
        document.querySelector("#tis").value = '';
        document.querySelector('#fecha').value = '';
        document.querySelector('#nColegiado').value = '';
        document.querySelector('#hora').value = '';
        alert('Cita agregada');
    };
}

function mostrarBaseDeDatos() {
    var data1 = bd.transaction(["paciente"], "readonly");
    var object1 = data1.objectStore("paciente");
    var elements1 = [];
    object1.openCursor().onsuccess = function (e) {
        var result = e.target.result;
        if (result === null) {
            return;
        }
        elements1.push(result.value);
        result.continue();
    };

    data1.oncomplete = function () {
        var outerHTML = "";
        outerHTML += '<div>' + 'Tabla Paciente' + '</div>';
        for (var key in elements1) {
            outerHTML += '<div>' + elements1[key].nombre + ' - ' + elements1[key].tis + ' - '
                    + elements1[key].fechaNacimiento + ' - ' + elements1[key].movil + ' - '
                    + elements1[key].sexo + '</div>';
        }
        elements1 = [];
        document.querySelector("#cajadatos").innerHTML = outerHTML;
    };

    var data2 = bd.transaction(["sanitario"], "readonly");
    var object2 = data2.objectStore("sanitario");
    var elements = [];

    object2.openCursor().onsuccess = function (e) {
        var result = e.target.result;
        if (result === null) {
            return;
        }
        elements.push(result.value);
        result.continue();
    };

    data2.oncomplete = function () {
        var outerHTML = "";
        outerHTML += '<div>' + 'Tabla Sanitario' + '</div>';
        for (var key in elements) {
            outerHTML += '<div>' + elements[key].nombre + ' - ' + elements[key].especialidad + ' - '
                    + elements[key].nColegiado + '</div>';
        }
        elements = [];
        document.querySelector("#cajadatos2").innerHTML = outerHTML;
    };
}

function elegirPaciente() {
    var opt = document.getElementById("info");
    for (var i = 0; i <= opt.length; i++) {
        opt.remove(opt.length - 1);
    }
    var option = document.createElement("option");
    option.value = "medicina";
    var optionText = document.createTextNode("Medico/a");
    option.appendChild(optionText);
    opt.appendChild(option);

    option = document.createElement("option");
    option.value = "enfermeria";
    optionText = document.createTextNode("Enfermero/a");
    option.appendChild(optionText);
    opt.appendChild(option);

    var tis = document.getElementById('tis').value;
    var transaccion = bd.transaction(['paciente']);
    var almacen = transaccion.objectStore('paciente');
    var indice = almacen.index('by_tis');
    var mirango = IDBKeyRange.only(tis);
    var nuevocursor = indice.openCursor(mirango);

    nuevocursor.addEventListener('success', mostrarlistaEspe);
}

function mostrarlistaEspe(e) {
    var cursor = e.target.result;
    var i = 0;
    if (cursor) {
        if (cursor.value.sexo == "M") {
            i = 1;
        }
        cursor.continue();
    }
    if (i == 1) {
        var opt = document.getElementById("info");
        option = document.createElement("option");
        option.value = "obstetricia";
        optionText = document.createTextNode("Matron/a");
        option.appendChild(optionText);
        opt.appendChild(option);
    }
}

function elegirSanitario() {
    var opt = document.getElementById("nColegiado");
    for (var i = 0; i <= opt.length; i++) {
        opt.remove(opt.length - 1);
    }
    var espe = document.getElementById('info').value;
    var transaccion = bd.transaction(["sanitario"], "readonly");
    var almacen = transaccion.objectStore("sanitario");
    var indice = almacen.index('by_especialidad');
    var mirango = IDBKeyRange.only(espe);
    var nuevocursor = indice.openCursor(mirango);
    nuevocursor.addEventListener('success', mostrarlistaSani);
}

function mostrarlistaSani(e){
    var cursor = e.target.result;
    if (cursor) {
        var num = cursor.value.nColegiado;
        var opt = document.getElementById("nColegiado");
        option = document.createElement("option");
        option.value = num;
        optionText = document.createTextNode(num);
        option.appendChild(optionText);
        opt.appendChild(option);
        cursor.continue();
    }
}

function elegirSanitario2() {
    var tis;
    tis = sessionStorage.getItem("tis");

    var opt = document.getElementById("info");
    for (var i = 0; i <= opt.length; i++) {
        opt.remove(opt.length - 1);
    }
    
    var transaccion = bd.transaction(['sanipac']);
    var almacen = transaccion.objectStore('sanipac');
    var indice = almacen.index('by_tis');
    var mirango = IDBKeyRange.only(tis);
    var nuevocursor = indice.openCursor(mirango);

    nuevocursor.addEventListener('success', mostrarSanit1);
}

function mostrarSanit1(e) {
    var cursor = e.target.result;

    if (cursor) {
        var num = cursor.value.nColegiado;
        
        var transaccion = bd.transaction(['sanitario']);
        var almacen = transaccion.objectStore('sanitario');
        var indice = almacen.index('by_nColegiado');
        var mirango = IDBKeyRange.only(num);
        var nuevocursor = indice.openCursor(mirango);
        nuevocursor.addEventListener('success', mostrarSanit2);
        cursor.continue();
    }
}

function mostrarSanit2(e){
    var opt = document.getElementById("info");
    var cursor = e.target.result;
    if (cursor) {
        option = document.createElement("option");
        option.value = cursor.value.nColegiado;
        var optionText = document.createTextNode(cursor.value.nombre+" - "+cursor.value.especialidad);
        option.appendChild(optionText);
        opt.appendChild(option);
        cursor.continue();
    }
    
}

function confirmarLogin() {
    var tis = document.getElementById('tis').value;
    var transaccion = bd.transaction(['paciente']);
    var almacen = transaccion.objectStore('paciente');
    var indice = almacen.index('by_tis');
    var mirango = IDBKeyRange.only(tis);
    var nuevocursor = indice.openCursor(mirango);
    nuevocursor.addEventListener('success', busFechPac);
}

function busFechPac(e) {
    var fecha = document.getElementById('fecha').value;

    var cursor = e.target.result;
    if (cursor) {
        if (cursor.value.fechaNacimiento == fecha) {
            sessionStorage.setItem("tis", document.getElementById('tis').value);
            sessionStorage.setItem("fecha", fecha);
            document.location.href = 'opcionesPac.html';
            //window.open("opcionesPac.html");
        }
        cursor.continue();
    }
}
;
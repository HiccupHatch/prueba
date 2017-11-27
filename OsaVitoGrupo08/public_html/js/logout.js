window.addEventListener('load', iniciar, false);

function iniciar() {
    document.getElementByName("logout").addEventListener('click', logout, false);
}

function logout() {
    localStorage.clear();
    sessionStorage.clear();
    window.close();
    document.close();
}
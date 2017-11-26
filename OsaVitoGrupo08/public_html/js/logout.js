window.addEventListener('load', iniciar, false);

function iniciar() {
    document.getElementByName("logout").addEventListener('click', logout, false);
}

function logout() {
    clearStorageExcept = function (exceptions) {
        var storage = localStorage;
        var keys = [];
        var exceptions = [].concat(exceptions); //prevent undefined

        //get storage keys
        $.each(localStorage, function (key, val) {
            keys.push(key);
        });

        //loop through keys
        for (i = 0; i < keys.length; i++) {
            var key = keys[i];
            var deleteItem = true;

            //check if key excluded
            for (j = 0; j < exceptions.length; j++) {
                var exception = exceptions[j];
                if (key == exception) {
                    deleteItem = false;
                }
            }

            //delete key
            if (deleteItem) {
                localStorage.removeItem(key);
            }
        }
    }
    window.close();

}
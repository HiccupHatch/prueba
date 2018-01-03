window.addEventListener('load', iniciar, false);

function iniciar() {

    if (document.getElementById('confirmar').name == "altaCita") {
        var dtToday = new Date();
        var month = dtToday.getMonth() + 1;     // getMonth() is zero-based
        var day = dtToday.getDate();
        var year = dtToday.getFullYear();
        var hour = dtToday.getHours();
        if (month < 10)
            month = '0' + month.toString();
        if (day < 10)
            day = '0' + day.toString();

        if (hour > 10) {
            if (day < 9) {
                day++;
                day = '0' + day;
            } else {
                day++;
            }
        }

        var minDate = year + '-' + month + '-' + day;

        document.getElementById("fecha").setAttribute("min", minDate);
        //$('#fecha').attr('min', minDate);

        var date = document.getElementById("fecha");

        date.addEventListener('input', noWeekends);
        function noWeekends(e) {
            var day = new Date(e.target.value).getUTCDay();
            // Days in JS range from 0-6 where 0 is Sunday and 6 is Saturday
            if (day == 0) {
                e.target.setCustomValidity('OH NO! We hate Sundays! Please pick any day but Sunday.');
            } else if (day == 6) {
                e.target.setCustomValidity('OH NO! We hate Saturdays! Please pick any day but Saturday.');
            } else {
                e.target.setCustomValidity('');
            }
        }
    }
}



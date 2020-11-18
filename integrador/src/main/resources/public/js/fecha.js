
(function(){

    var fechaActual =  function(){
        var fecha = new Date(),
            dia = fecha.getDate(),
            mes = fecha.getMonth(),
            anio = fecha.getFullYear();

        var fechaDia = document.getElementById('dia'),
            fechaMes = document.getElementById('mes'),
            fechaAnio = document.getElementById('anio');

        fechaDia.textContent = dia;
        fechaMes.textContent = mes;
        fechaAnio.textContent = anio;
    };

    fechaActual();
}())
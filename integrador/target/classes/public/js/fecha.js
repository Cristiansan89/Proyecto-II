
(function(){

    var fechaActual =  function(){
        var fecha = new Date(),
            dia = fecha.getDate(),
            mes = fecha.getMonth(),
            anio = fecha.getFullYear();
            fechaFormato = date;

        var fechaDia = document.getElementById('dia'),
            fechaMes = document.getElementById('mes'),
            fechaAnio = document.getElementById('anio');
            
        var fechaFormato = document.getElementById('fechaFormato');

        fechaDia.textContent = dia;
        fechaMes.textContent = mes;
        fechaAnio.textContent = anio;

        fechaFormato.textContent = dia/mes/anio;
    };

    fechaActual();
}())


function validarUsuario() {
    // obtengo elemento de la pagina con id nombreUsuario
    const nombreUsuario = document.getElementById("nombreUsuario");
    console.log(nombreUsuario);
    if (nombreUsuario.value.trim().length < 1) {
        alert("El usuario debe tener un nombre");
        return false;
    } else {
        return true;
    }
}
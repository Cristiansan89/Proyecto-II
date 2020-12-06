
(function(){

    var fechaNow = function(){
        var typeFecha = (new Date).toLocaleDateString();
        var fechaMostrar = document.getElementById('fecha');

        fechaMostrar.textContent = typeFecha;
    };
    
    fechaNow();
}())
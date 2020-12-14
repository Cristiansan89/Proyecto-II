let borrar = function (id){
    fetch(`http://localhost:8000/usuarios/borrar/${id}`,{
        method: 'DELETE', 
    }
    ).then(res => window.location.reload(true));
}

function validarUsuario() {
    // obtengo elemento de la pagina con id nombre del Usuario
    const nick = document.getElementById("nick");
    var contrasena = document.getElementById("contrasena");
    console.log(nick);
    if ((nick.value.trim().length < 1) && (contrasena.value.trim().length < 1)) {
        alert("Ingrese el Nombre de Usuario y Contrasena");
        return false;
    } else {
        return true;
    }
}

function verificarPasswords(){
     // Ontenemos los valores de los campos de contraseñas 
    pass1 = document.getElementById('contrasena');
    pass2 = document.getElementById('contrasena1');

     // Verificamos si las constraseñas no coinciden 
    if (pass1.value != pass2.value) {
        // Si las constraseñas no coinciden mostramos un mensaje 
        document.getElementById("error").classList.add("mostrar");
        return false;
    } else {  
        // Si las contraseñas coinciden ocultamos el mensaje de error
        document.getElementById("error").classList.remove("mostrar");
        // Mostramos un mensaje mencionando que las Contraseñas coinciden 
        document.getElementById("ok").classList.remove("ocultar");
        // Desabilitamos el botón de login 
        document.getElementById("login").disabled = true;
        // Refrescamos la página (Simulación de envío del formulario) 
        setTimeout(function() {
            location.reload();
        }, 3000);
        return true;
    }
}

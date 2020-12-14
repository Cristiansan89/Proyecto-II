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
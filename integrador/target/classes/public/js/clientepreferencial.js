let borrar = function (id){
    fetch(`http://localhost:8000/clientespreferencial/borrar/${id}`,{
        method: 'DELETE', 
    }
    ).then(res => window.location.reload(true));
}
let borrar = function (id,idpedido){
    fetch(`http://localhost:8000/detallepedido/borrar/${id}/${idpedido}`,{
        method: 'DELETE', 
    }
    ).then(res => window.location.reload(true));
}
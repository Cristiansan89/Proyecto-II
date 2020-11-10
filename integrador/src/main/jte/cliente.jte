@param edu.unam.integrador.paginas.ModeloClientes modelo

@tag.header()
    <h2>Clientes</h2>
    <a href="/" type="button" class="btn btn-primary"> Volver </a>
    <div class"table-responsive">
        <table class=table table-hover table-striped">
            <thead>
                <tr>
                    <th scope="col">ID Cliente</th>
                    <th scope="col">Nombre</th>
                    <th scope="col">Cuil</th>
                    <th scope="col">Domicilio</th>
                    <th scope="col">Telefono</th>
                    <th class="col-1" scope="col"> </th>
                    <th class="col-1" scope="col"> </th>
                    <th class="col-1" scope="col"> </th>
                </tr>
            </thead>
            <tbody>
                @for (var cliente : modelo.clientes)
                    <tr>
                        <td scope="row">${cliente.getClienteId()}</td>
                        <td>${cliente.getNombre()}</td>
                        <td>${cliente.getCuil()}</td>
                        <td>${cliente.getDomicilio()}</td>
                        <td>${cliente.getTelefono()}</td>
                        <td class="col-1"> <a type="button" class="btn btn-info no-gutters" href="clientes/${cliente.getClienteId()}"> Editar </a></td>                            
                        <td class="col-1"> <button type="button" class="btn btn-danger no-gutters" onClick="borrar(${cliente.getClienteId()})"> Eliminar </button></td>
                    </tr>
            </tbody>
        </table>
    </div>

@tag.footer()
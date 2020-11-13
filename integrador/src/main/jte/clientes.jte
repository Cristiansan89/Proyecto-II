@param edu.unam.integrador.paginas.ModeloClientes modelo

@tag.header()
    <h2>Clientes</h2>
    
    <div class="table-responsive">
        <table class="table table-hover table-striped">
            <thead>
                <tr>
                    <th>ID Cliente</th>
                    <th >Nombre</th>
                    <th >Cuil</th>
                    <th>Domicilio</th>
                    <th >Telefono</th>
                    <th > </th>
                    <th > </th>
                </tr>
            </thead>
            <tbody>
                @for (var cliente : modelo.clientes)
                    <tr>
                        <td >${cliente.getIdCliente()}</td>
                        <td>${cliente.getNombre()}</td>
                        <td>${cliente.getCuil()}</td>
                        <td>${cliente.getDomicilio()}</td>
                        <td>${cliente.getTelefono()}</td>
                        <td > <a style="float: left;" type="button" class="btn btn-info no-gutters" href="clientes/editar/${cliente.getIdCliente()}"> Editar </a></td>                            
                        <td > <a style="float: left;"  type="button" class="btn btn-danger no-gutters"  href="cliente/${cliente.getIdCliente()}/borrar" >Eliminar</a>  </td>
                    </tr>
                @endfor
            </tbody>
        </table>
    </div>
    <a href="/" style="float: right;" type="button" class="btn btn-primary"> Volver </a>


@tag.footer()
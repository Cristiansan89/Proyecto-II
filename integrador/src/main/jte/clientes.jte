@param edu.unam.integrador.paginas.ModeloClientes modelo

@tag.header()

<div style="margin-top: 6em; margin-left: 15em; margin-right: 15em;">
    <h2><b>Clientes</b></h2>
    <div class="table-responsive">
        <table class="table table-hover table-striped">
            <thead>
                <tr>  
                    <th>ID Cliente</th>
                    <th>Nombre</th>
                    <th>Apellido</th>
                    <th>Cuil</th>
                    <th>Domicilio</th>
                    <th>Tel&eacute;fono</th>
                    <th> </th>
                    <th> </th>
                </tr>
            </thead>
            <tbody>
                @for (var cliente : modelo.clientes)
                    <tr>
                        <td>${cliente.getIdCliente()}</td>
                        <td>${cliente.getNombre()}</td>
                        <td>${cliente.getApellido()}</td>
                        <td>${cliente.getCuil()}</td>
                        <td>${cliente.getDomicilio()}</td>
                        <td>${cliente.getTelefono()}</td>
                        <td> <a type="button" class="btn btn-info no-gutters" href="/clientes/modificar/${cliente.getIdCliente()}"> Editar </a></td>
                        <td> <button type="button" class="btn btn-danger no-gutters" onClick="borrar(${cliente.getIdCliente()})"> Eliminar </button></td>
                    </tr>
                @endfor
            </tbody>
        </table>
    </div>
    <a href="/" style="float: right;" type="button" class="btn btn-primary"> Volver </a>
</div>

<script src="/js/cliente.js"></script>

@tag.footer()
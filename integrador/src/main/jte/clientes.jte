@param edu.unam.integrador.paginas.ModeloClientes modelo

@tag.header()

<div id="estilo_list">
    <h2>Clientes</h2>
    <br>
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
                    </tr>
                @endfor
            </tbody>
        </table>
    </div>
    <a href="/" style="float: right;" type="button" class="btn btn-primary"> Volver </a>
</div>

<script src="/js/cliente.js"></script>

@tag.footer()
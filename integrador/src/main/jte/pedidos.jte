@param edu.unam.integrador.paginas.ModeloPedidos modelo

@tag.header()
<br>

<div id="estilo_list">
    <h2><b>Lista de Pedido</b></h2>
    <br>
    <div class="table-responsive">
        <table class="table table-hover table-striped">
            <thead>
                <tr>  
                    <th>ID</th>
                    <th>Fecha</th>
                    <th>Hora</th>
                    <th>Estado</th>
                    <th>Condici&oacute;n</th>
                    <th>Total a Pagar</th>
                    <th> </th>
                    <th> </th>
                </tr>
            </thead>
            <tbody>
            @for (var pedido : modelo.pedidos)
                <tr>
                    <td>${pedido.getIdPedido()}</td>
                    <td>${pedido.formatoFecha(pedido.getFecha())}</td>
                    <td>${pedido.getHora()}</td>
                    <td>${pedido.tipoEstadoStr()}</td>
                    <td>${pedido.getCondicion()}</td>
                    <td>${pedido.stringTotalPagar()}</td> 
                    <td> <a type="button" class="btn btn-success no-gutters" href="/pedidos/listadetalle/${pedido.getIdPedido()}"> Ver </a></td>    
                    @if ((modelo.rol.equals("admin")) && (pedido.getCondicion().equals("En Espera")))
                        <td> <a type="button" class="btn btn-info no-gutters" href="/pedidos/entregado/${pedido.getIdPedido()}"> Entregado </a></td>    
                    @elseif((modelo.rol.equals("cliente")) && (pedido.getCondicion().equals("En Espera")))
                        <td> <a type="button" class="btn btn-danger no-gutters" href="/pedidos/cancelar/${pedido.getIdPedido()}"> Cancelar </a></td>    
                    @else
                        <td></td>
                    @endif
                </tr>
            @endfor
            </tbody>
        </table>
    </div>
    <center>
        <a href="/" type="button" class="btn btn-primary justify-content-center align-items-center"> Volver </a>
    </center>
</div>

<script src="/js/pedido.js"></script>

@tag.footer()
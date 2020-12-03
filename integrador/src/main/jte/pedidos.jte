@param edu.unam.integrador.paginas.ModeloPedidos modelo
@tag.header()
<br>
<script src="/js/fecha.js"></script>
                        <table class="table table-hover table-striped">
                            <thead>
                                <tr>  
                                <th>Id</th>
                                    <th>Fecha</th>
                                    <th>Estado</th>
                                    <th>Total</th>
                                    <th> </th>
                                </tr>
                            </thead>
                            <tbody>
                            @for (var pedido : modelo.pedidos )
                                <tr>
                                    <td>${pedido.getIdPedido()}</td>
                                    <td>${pedido.formatoFecha(pedido.getFecha())}-${pedido.getHora()}</td>
                                    <td>${pedido.isEstado()}</td>
                                    <td>${pedido.getTotalPagar()}</td> 
                                    <td> <button type="button" class="btn btn-danger no-gutters" onClick="borrar(${pedido.getIdPedido()})"> Anular </button></td>
                                </tr>
                            @endfor
                            </tbody>
                        </table>
@tag.footer()
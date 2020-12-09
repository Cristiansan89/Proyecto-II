@param edu.unam.integrador.paginas.ModeloDetallesPedidos modelo

@tag.header()

<div class="card" id="estilo_card_pedido"> 
    <div class="card-footer">
        <h2> Ingresar Pedido</h2>
        <br>
        <div id="estilo_card_form"> 
            <form action="/pedidos/agregardetalle/${modelo.idPedido}" method="post">
                <label for="unProducto" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Producto</label>
                <div class="form-group row">
                    <div class="col-sm-10">  
                        <select name="producto" class="form-control">
                            <option> </option>
                            @for (var producto : modelo.productos)
                                <option value="${producto.getIdProducto()}">${producto.getIdProducto()} - ${producto.getCodProducto()} - ${producto.getCategoria()} - ${producto.getMarca()} - ${producto.getMedida()} - ${producto.getUnidad()} - ${producto.getStock()} - ${producto.getPrecioUnitario()} - ${producto.getDetalle()} </option>
                            @endfor
                        </select>
                    </div>
                </div>
                <label for="unCliente" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Cliente</label>    
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="text" value="${modelo.nombreUsuario}" name="unCliente" readonly/>
                    </div>
                </div>
                <label for="cantidad" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Cantidad</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="number" name="cantidad"/>
                    </div>
                </div>
                <div class="text-center" style="margin-right: 4em;">
                    <button type="submit" class="btn btn-success"> Agregar </button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="card" id="estilo_card_list"> 
    <div class="card-footer">
        <div id="estilo_card_form">
            <h2> Lista de Pedido </h2>
            <br>
            <form action="/pedidos/finalizar/${modelo.idPedido}" method="post">
                <div id="estilo_list_pedido">
                    <div class="table-responsive">
                        <table class="table table-hover table-striped">
                            <thead>
                                <tr>  
                                    <th>Producto</th>
                                    <th>Cantidad</th>
                                    <th>Precio</th>
                                    <th>Neto</th>
                                    <th> </th>
                                </tr>
                            </thead>
                            <tbody>
                                @for (var detallepedido : modelo.detallePedidos )
                                    <tr>
                                        <td>${detallepedido.getProducto().toString()}</td>
                                        <td>${detallepedido.getCantidad()}</td>
                                        <td>${detallepedido.getProducto().getPrecioUnitario()}</td>
                                        <td>${detallepedido.getTotalFila()}</td>
                                        <td> <button type="button" class="btn btn-danger no-gutters" onClick="borrar(${detallepedido.getIdDetallePedido()},${modelo.idPedido})"> Quitar </button></td>
                                    </tr>
                                @endfor
                                
                            </tbody>
                            <thead>
                                <tr class="alert-secondary">
                                    <td> </td>
                                    <td> </td>
                                    <td><b>SubTotal</b></td>
                                    <td><b>$</b></td>
                                    <td> </td>
                                </tr> 
                                <tr class="bg-light">
                                    <td> </td>
                                    <td> </td>
                                    <td><b>Descuento</b></td>
                                    <td><b>%</b></td>
                                    <td> </td>
                                </tr> 
                                <tr class="bg-warning">
                                    <td> </td>
                                    <td> </td>
                                    <td><b>Total</b></td>
                                    <td><b>${modelo.total}</b></td>
                                    <td> </td>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary"> Finalizar </button>
                    <a href="/" style="float:center;" type="button" class="btn btn-secondary"> Volver </a>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="/js/detallepedido.js"></script>
@tag.footer()
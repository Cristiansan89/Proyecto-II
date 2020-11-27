@param edu.unam.integrador.paginas.ModeloDetallesPedidos modelo

@tag.headers()
<div class="container">
<div class="align-items-center">

        <div class="card"  style=""> 
            <div class="card-footer">
                <div style="margin-left: 3em;"> 
                    <h2><b>Ingresar Pedido</b></h2>
                    <br>
                    <form action="/pedidos/agregardetalle/${modelo.idPedido}" method="post">
                        <label for="unProducto" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Producto</label>
                        <div class="form-group row">
                            <div class="col-sm-20">  
                                <select name="producto" class="selectpicker" data-style="btn-success">
                                    <option> </option>
                                    @for (var producto : modelo.productos)
                                        <option value="${producto.getIdProducto()}" >${producto.getIdProducto()} - ${producto.getCodProducto()} - ${producto.getCategoria()} - ${producto.getMarca()} - ${producto.getMedida()} - ${producto.getUnidad()} - ${producto.getStock()} - ${producto.getPrecioUnitario()} - ${producto.getDetalle()} </option>
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
                            <button type="submit" class="btn btn-primary"> Agregar </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="card" style="width: 95%; left: 45px; right: 25px; margin-bottom: 3rem;"> 
    <div class="card-footer">
        <div style="margin-left: 3em; ">
            <h2><b>Lista de Pedido</b></h2>
            <br>
            <form action="/pedidos/finalizar/${modelo.idPedido}" method="post">
                <div style="margin-top: 6em; margin-left: 15em; margin-right: 15em;">
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
                            <tr><td></td><td></td><td>Total</td><td>${modelo.total}</td></tr>
                            </tbody>
                        </table>

                    </div>
                    <button type="submit" class="btn btn-primary"> Finalizar </button>
                    <a href="/" style="float: right;" type="button" class="btn btn-primary"> Volver </a>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="/js/detallepedido.js"></script>
@tag.footer()
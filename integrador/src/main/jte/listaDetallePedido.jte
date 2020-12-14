@param edu.unam.integrador.paginas.ModeloDetallesPedidos modelo

@tag.header()

<div id="cuerpo_datos">
    <div class="card-footer">
        <div id="estilo_card_form"> 
            <h2>Datos del Cliente</h2>
            <br>
            <label class="col-sm-8 col-form-label font-weight-bold" id="text-size">Apellido: ${modelo.apellido}</label>
            <label class="col-sm-8 col-form-label font-weight-bold" id="text-size">Nombre: ${modelo.nombre}</label>
            <label class="col-sm-8 col-form-label font-weight-bold" id="text-size">Cuil: ${modelo.cuil}</label>
            <label class="col-sm-8 col-form-label font-weight-bold" id="text-size">Domicilio: ${modelo.domicilio}</label>
            <label class="col-sm-8 col-form-label font-weight-bold" id="text-size">Tel&eacute;fono: ${modelo.telefono}</label>
        </div>
    </div>
</div>
<br>
<div id="estilo_list">
    <h2><b>Lista de Pedido</b></h2>
    <br>
    <div class="table-responsive">
        <table class="table table-hover table-striped">
            <thead>
                <tr>  
                    <th>Producto</th>
                    <th>Cantidad</th>
                    <th>Precio</th>
                    <th>Neto</th>
                </tr>
            </thead>
            <tbody>
                    @for (var detallepedido : modelo.detallePedidos )
                    <tr>
                        <td>${detallepedido.getProducto().toString()}</td>
                        <td>${detallepedido.getCantidad()}</td>
                        <td>${detallepedido.getProducto().getPrecioUnitario()}</td>
                        <td>${detallepedido.getTotalFila()}</td>
                    </tr>
                @endfor
            </tbody>
            <thead>
                <tr class="alert-secondary">
                    <td> </td>
                    <td> </td>
                    <td><b>SubTotal</b></td>
                    <td><b>${modelo.subtotal}</b></td>
                </tr> 
                <tr class="bg-light">
                    <td> </td>
                    <td> </td>
                    <td><b>Descuento ${modelo.valdescuento}%</b></td>
                    <td><b>${modelo.descuento}</b></td>
                </tr> 
                <tr class="bg-warning">
                    <td> </td>
                    <td> </td>
                    <td><b>Total</b></td>
                    <td><b>${modelo.total}</b></td>
                </tr>
            </thead>
        </table>
    </div>
    <a href="/pedidos" style="float: left;" type="button" class="btn btn-primary"> Volver </a>
</div>


@tag.footer()
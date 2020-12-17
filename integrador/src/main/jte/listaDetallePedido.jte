@param edu.unam.integrador.paginas.ModeloDetallesPedidos modelo


@tag.header()

<br>
<div id="estilo_list">
    <h2><b>Pedido</b></h2>
    <br>
    <h3>Datos del Cliente</h3>
    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
                <tr style="border: hidden">
                    <td>
                        <label class="col-sm-8 col-form-label font-weight-bold" id="text-size-data ">Apellido: <span class="text-uppercase">${modelo.apellido}</span></label>
                    </td>
                    <td>
                        <label class="col-sm-8 col-form-label font-weight-bold" id="text-size-data">Nombre: <span class="text-uppercase">${modelo.nombre}</span></label>
                    </td>
                </tr>
                <tr style="border: hidden">
                    <td>
                        <label class="col-sm-8 col-form-label font-weight-bold" id="text-size-data">Cuil: ${modelo.cuil}</label>
                    </td>
                    <td>
                        <label class="col-sm-8 col-form-label font-weight-bold" id="text-size-data">Tel&eacute;fono: ${modelo.telefono}</label>
                    </td>
                </tr>
                <tr style="border: hidden">
                    <td>
                        <label class="col-sm-8 col-form-label font-weight-bold" id="text-size-data">Domicilio: <span class="text-uppercase">${modelo.domicilio}</span></label>                        
                    </td>
                </tr>
            </thead>
        </table>
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
                        <td>${detallepedido.getSubTotal()}</td>
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
    <center>
        <a href="/pedidos/listapedido" type="button" class="btn btn-primary justify-content-center align-items-center"> Volver </a>
    </center>
  
</div>


@tag.footer()
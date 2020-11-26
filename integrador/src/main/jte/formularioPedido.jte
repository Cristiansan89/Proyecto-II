@param edu.unam.integrador.paginas.ModeloProductos modelo

@tag.headers()

<div class="card" style="width: 40rem; top: 7rem; left: 55rem; margin-bottom: 10rem;"> 
    <div class="card-footer">
        <div style="margin-left: 3em;"> 
            <h2><b>Ingresar Pedido</b></h2>
            <br>
            <form action="/pedidos/agregar" method="post">
                <label for="unProducto" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Producto</label>
                <div class="form-group row">
                    <div class="col-sm-20">  
                        <select class="selectpicker" data-style="btn-success">
                            <option> </option>
                            @for (var producto : modelo.productos)
                                <option>${producto.getIdProducto()} - ${producto.getCodProducto()} - ${producto.getCategoria()} - ${producto.getMarca()} - ${producto.getMedida()} - ${producto.getUnidad()} - ${producto.getStock()} - ${producto.getPrecioUnitario()} - ${producto.getDetalle()} </option>
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


@tag.footer()
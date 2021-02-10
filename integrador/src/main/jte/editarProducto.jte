@param edu.unam.integrador.paginas.ModeloProducto modelo

@tag.header()

<div class="card" id="estilo_card""> 
    <div class="card-footer">
        <h2><b>Editar Producto</b></h2>
        <br>
        <div id="estilo_card_form">
            <form action="/productos/actualizar/${modelo.producto.getIdProducto()}" method="post">
                <label for="codproducto" class="col-sm-8 col-form-label font-weight-bold" id="text-size">C&oacute;digo Producto</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="number" name="codproducto" value="${modelo.producto.getCodProducto()}"/>
                    </div>
                </div>
                <label for="categoria" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Categor&iacute;a</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="text" name="categoria" value="${modelo.producto.getCategoria()}"/>
                    </div>
                </div>
                <label for="marca" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Marca</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="text" name="marca" value="${modelo.producto.getMarca()}"/>
                    </div>
                </div>
                <label for="medida" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Medida</label>                
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="number" step="0.01" name="medida" value="${modelo.producto.getMedida()}"/>
                    </div>
                </div>
                <label for="unidad" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Unidad</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="text" name="unidad" value="${modelo.producto.getUnidad()}"/>
                    </div>
                </div>
                <label for="stock" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Stock</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="number" name="stock" value="${modelo.producto.getStock()}"/>
                    </div>
                </div>
                <label for="preciounitario" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Precio Unitario</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="number" step="0.01" name="preciounitario" value="${modelo.producto.getPrecioUnitario()}"/>
                    </div>
                </div>
                <label for="detalle" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Detalle</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="text" name="detalle" value="${modelo.producto.getDetalle()}"/>
                    </div>
                </div>
                <div class="text-center" id="estilo_bottom">
                    <button type="submit" class="btn btn-primary"> Modificar </button>
                    <a href="/" type="button" class="btn btn-secondary"> Volver </a>
                </div>
            </form>
        </div>
    </div>
</div>

@tag.footer()
@param edu.unam.integrador.paginas.ModeloProductos modelo

@tag.header()

<div id="estilo_list">
    <h2>Producto</h2>
    <br>
    <div class="table-responsive">
        <table class="table table-hover table-striped">
            <thead>
                <tr>
                    <th>ID Producto</th>
                    <th>C&oacute;digo Producto</th>
                    <th>Categor&iacute;a</th>
                    <th>Marca</th>
                    <th>Medida</th>
                    <th>Unidad</th>
                    <th>Stock</th>
                    <th>Precio Unitario</th>
                    <th>Detalle</th>
                    @if (modelo.rol.equals("admin"))
                        <th> </th>
                        <th> </th>
                    
                    @endif
                </tr>
            </thead>
            <tbody>
                @for (var producto : modelo.productos)
                    <tr>
                        <td>${producto.getIdProducto()}</td>
                        <td>${producto.getCodProducto()}</td>
                        <td>${producto.getCategoria()}</td>
                        <td>${producto.getMarca()}</td>
                        <td>${producto.getMedida()}</td>
                        <td>${producto.getUnidad()}</td>
                        <td>${producto.getStock()}</td>
                        <td>${producto.getPrecioUnitario()}</td>
                        <td>${producto.getDetalle()}</td>
                        @if (modelo.rol.equals("admin"))
                            <td> <a type="button" class="btn btn-info no-gutters" href="/productos/modificar/${producto.getIdProducto()}"> Editar </a></td>
                            <td> <button type="button" class="btn btn-danger no-gutters" onClick="borrar(${producto.getIdProducto()})"> Eliminar </button></td>
                        @endif
                    </tr>
                @endfor
            </tbody>
        </table>
    </div>
    
    <a href="/" style="float: right;" type="button" class="btn btn-primary"> Volver </a>
</div>

<script src="/js/producto.js"></script>

@tag.footer()
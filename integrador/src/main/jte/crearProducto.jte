
@tag.header()

<div class="card" style="width: 45rem; top: 7rem; left: 40rem; margin-bottom: 10rem;"> 
    <div class="card-footer">
        <div style="margin-left: 3em; ">
            <h2><b>Crear Producto</b></h2>
            <br>
            <form action="/productos/crear" method="post">
                <label for="codProducto" class="col-sm-8 col-form-label font-weight-bold" id="text-size"> C&oacute;digo Producto </label> 
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="number" name="codProducto"/>
                    </div>
                </div>
                <label for="categoria" class="col-sm-8 col-form-label font-weight-bold" id="text-size"> Categor&iacute;a </label> 
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="text" name="categoria"/>
                    </div>
                </div>
                <label for="marca" class="col-sm-8 col-form-label font-weight-bold" id="text-size"> Marca </label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="text" name="marca"/>
                    </div>
                </div>
                <label for="medida" class="col-sm-8 col-form-label font-weight-bold" id="text-size"> Medida </label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="text" name="medida"/>
                    </div>
                </div>
                <label for="unidad" class="col-sm-8 col-form-label font-weight-bold" id="text-size"> Unidad </label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="text" name="unidad"/>
                    </div>
                </div>
                <label for="stock" class="col-sm-8 col-form-label font-weight-bold" id="text-size"> Stock </label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="number" name="stock"/>
                    </div>
                </div>
                <label for="precioUnitario" class="col-sm-8 col-form-label font-weight-bold" id="text-size"> Precio Unitario </label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="text" name="precioUnitario"/>
                    </div>
                </div>
                <label for="detalle" class="col-sm-8 col-form-label font-weight-bold" id="text-size"> Detalle </label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="text" name="detalle"/>
                    </div>
                </div>
                <div class="text-center" style="margin-right: 4em;">
                    <button type="submit" class="btn btn-primary"> Guardar </button>
                    <a href="/" type="button" class="btn btn-secondary"> Volver </a>
                </div>
            </form>
        </div>
    </div>
</div>

@tag.footer()
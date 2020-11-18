
@tag.header()

<div class="card" style="width: 45rem; top: 7rem; left: 40rem;"> 
    <div class="card-footer">
        <div style="margin-left: 3em; ">
            <h2><b>Crear Producto</b></h2>
            <br>
            <form action="/productos/crear" method="post">
                <div class="form-group row">
                    <label for="codProducto" class="col-sm-2 col-form-label font-weight-bold"> C&oacute;digo Producto </label>
                    <div class="col-sm-8">
                        <input class="form-control" type="numbre" name="codProducto"/>
                    </div>
                </div>
                    <div class="form-group row">
                    <label for="categoria" class="col-sm-2 col-form-label font-weight-bold"> Categor&iacute;a </label>
                    <div class="col-sm-8">
                        <input class="form-control" type="number" name="categoria"/>
                    </div>
                </div>
                    <div class="form-group row">
                    <label for="marca" class="col-sm-2 col-form-label font-weight-bold"> Marca </label>
                    <div class="col-sm-8">
                        <input class="form-control" type="text" name="marca"/>
                    </div>
                </div>
                    <div class="form-group row">
                    <label for="medida" class="col-sm-2 col-form-label font-weight-bold"> Medida </label>
                    <div class="col-sm-8">
                        <input class="form-control" type="text" name="medida"/>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="unidad" class="col-sm-2 col-form-label font-weight-bold"> Unidad </label>
                    <div class="col-sm-8">
                        <input class="form-control" type="text" name="unidad"/>
                    </div>
                </div>
                 <div class="form-group row">
                    <label for="stock" class="col-sm-2 col-form-label font-weight-bold"> Stock </label>
                    <div class="col-sm-8">
                        <input class="form-control" type="number" name="stock"/>
                    </div>
                </div>
                 <div class="form-group row">
                    <label for="detalle" class="col-sm-2 col-form-label font-weight-bold"> Detalle </label>
                    <div class="col-sm-8">
                        <input class="form-control" type="text" name="detalle"/>
                    </div>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary"> Guardar </button>
                    <a href="/" type="button" class="btn btn-secondary"> Volver </a>
                </div>
            </form>
        </div>
    </div>
</div>

@tag.footer()
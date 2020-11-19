
@tag.header()

<div class="card" style="width: 40rem; top: 7rem; left: 40rem; margin-bottom: 10rem;"> 
    <div class="card-footer">
        <div style="margin-left: 3em;"> 
            <h2><b>Crear Cliente</b></h2>
            <br>
            <form action="/clientes/crear" method="post">
                <label for="nombre" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Nombre</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="text" name="nombre"/>
                    </div>
                </div>
                <label for="apellido" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Apellido</label>    
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="text" name="apellido"/>
                    </div>
                </div>
                <label for="cuil" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Cuil</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="number" name="cuil"/>
                    </div>
                </div>
                <label for="domicilio" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Domicilio</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="text" name="domicilio"/>
                    </div>
                </div>
                <label for="telefono" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Tel&eacute;fono</label>   
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="number" name="telefono"/>
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
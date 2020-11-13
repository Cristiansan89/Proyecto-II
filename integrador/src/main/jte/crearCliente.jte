
@tag.header()

<h2> Crear Cliente</h2>
<form action="/cliente/crear" method="post">

    <div class="form-group row">
        <label for="nombre" class="col-sm-2 col-form-label"> Nombre </label>
        <div class="col-sm-8">
            <input class="form-control" type="text" placeholder="Nombre" name="nombre"/>
        </div>
    </div>
        <div class="form-group row">
        <label for="apellido" class="col-sm-2 col-form-label"> Apellido </label>
        <div class="col-sm-8">
            <input class="form-control" type="text" placeholder="Apellido" name="apellido"/>
        </div>
    </div>
        <div class="form-group row">
        <label for="cuil" class="col-sm-2 col-form-label"> CUIL </label>
        <div class="col-sm-8">
            <input class="form-control" type="number" placeholder="ingrese su CUIL" name="cuil"/>
        </div>
    </div>
        <div class="form-group row">
        <label for="domicilio" class="col-sm-2 col-form-label"> Domicilio </label>
        <div class="col-sm-8">
            <input class="form-control" type="text" placeholder="Domicilio" name="domicilio"/>
        </div>
    </div>
    <div class="form-group row">
        <label for="telefono" class="col-sm-2 col-form-label"> Telefono</label>
        <div class="col-sm-8">
            <input class="form-control" type="number" placeholder="Telefono" name="telefono"/>
        </div>
    </div>

    <button type="submit" class="btn btn-primary"> Guardar </button>
    <a href="/" type="button" class="btn btn-secondary"> Volver </a>
</form>

@tag.footer()
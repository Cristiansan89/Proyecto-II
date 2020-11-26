@param edu.unam.integrador.paginas.ModeloCliente modelo

@tag.header()

<div class="card" style="width: 42rem; top: 7rem; left: 40rem; margin-bottom: 10rem;"> 
    <div class="card-footer">
        <div style="margin-left: 3rem;">
            <h2><b>Editar Cliente</b></h2>
            <br>
            <form action="/clientes/actualizar/${modelo.cliente.getIdCliente()}" method="post">
                <label for="nombre" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Nombre</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="text" name="nombre" value="${modelo.cliente.getNombre()}"/>
                    </div>
                </div>
                <label for="apellido" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Apellido</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="text" name="apellido" value="${modelo.cliente.getApellido()}"/>
                    </div>
                </div>
                <label for="cuil" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Cuil</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="number" name="cuil" value="${modelo.cliente.getCuil()}"/>
                    </div>
                </div>
                <label for="domicilio" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Domicilio</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="text" name="domicilio" value="${modelo.cliente.getDomicilio()}"/>
                    </div>
                </div>
                <label for="telefono" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Tel&eacute;fono</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="number" name="telefono" value="${modelo.cliente.getTelefono()}"/>
                    </div>
                </div>
                <div class="text-center" style="margin-right: 4em;">
                    <button type="submit" class="btn btn-primary"> Modificar </button>
                    <a href="/" type="button" class="btn btn-primary"> Volver </a>
                </div>
            </form>
        </div>
    </div>
</div>

@tag.footer()
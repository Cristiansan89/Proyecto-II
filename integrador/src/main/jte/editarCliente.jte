@param edu.unam.integrador.paginas.ModeloCliente modelo

@tag.header()

<h2>Cliente</h2>

<div class="card" style="width: 42rem; top: 7rem; left: 40rem;"> 
    <div class="card-footer">
        <div style="margin-left: 3em; ">
            <h2><b>Editar Cliente</b></h2>
            <br>
            <form action="/clientes" method="post">
                <div class="form-group row">
                    <label for="nombre" class="col-sm-2 col-form-label font-weight-bold"> Nombre </label>
                    <div class="col-sm-8">
                        <input class="form-control" type="text" name="nombre" value="${modelo.cliente.getNombre()}"/>
                    </div>
                </div>
                    <div class="form-group row">
                    <label for="apellido" class="col-sm-2 col-form-label font-weight-bold"> Apellido </label>
                    <div class="col-sm-8">
                        <input class="form-control" type="text" name="apellido" value="${modelo.cliente.getApellido()}"/>
                    </div>
                </div>
                    <div class="form-group row">
                    <label for="cuil" class="col-sm-2 col-form-label font-weight-bold"> CUIL </label>
                    <div class="col-sm-8">
                        <input class="form-control" type="number" name="cuil" value="${modelo.cliente.getCuil()}"/>
                    </div>
                </div>
                    <div class="form-group row">
                    <label for="domicilio" class="col-sm-2 col-form-label font-weight-bold"> Domicilio </label>
                    <div class="col-sm-8">
                        <input class="form-control" type="text" name="domicilio" value="${modelo.cliente.getDomicilio()}"/>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="telefono" class="col-sm-2 col-form-label font-weight-bold"> Telefono</label>
                    <div class="col-sm-8">
                        <input class="form-control" type="number" name="telefono" value="${modelo.cliente.getTelefono()}"/>
                    </div>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary"> Modificar </button>
                    <a href="/clientes" type="button" class="btn btn-secondary"> Volver </a>
                </div>
            </form>
        </div>
    </div>
</div>

@tag.footer()

@tag.header()

<div class="card" id="estilo_card"> 
    <div class="card-footer">
        <div id="estilo_card_form"> 
            <form action="/clientes/crear" method="post">
                <h2>Datos del Usuario</h2>
                <br>
                <label for="mail" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Mail</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="email" name="mail"/>
                    </div>
                </div>
                <label for="nick" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Usuario</label>    
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="text" name="nick"/>
                    </div>
                </div>
                <label for="contrasena" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Contraseña</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="password" name="contrasena"/>
                    </div>
                </div>
                <label for="repetirContrasena" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Repetir Contraseña</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="password" name="repetirContrasena"/>
                    </div>
                </div>
                <br>
                <hr>
                <h2>Datos de Cliente</h2>
                <br>
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
                        <input id="cuil" class="form-control" type="number" name="cuil"/>
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
                        <input id="telefono" class="form-control" type="number" name="telefono"/>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.15/jquery.mask.min.js"></script>
<script>

$(document).ready(function(){
    $('#cuil').mask('00000000000');
    $('#telefono').mask('0000000000');
  });
</script>
  
@tag.footer()
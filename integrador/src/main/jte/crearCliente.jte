
@tag.header()

<div class="card" id="estilo_card"> 
    <div class="card-footer">
        <h2>Datos del Usuario</h2>
        <br>
        <div id="estilo_card_form"> 
            <form action="/clientes/crear" method="post" onsubmit="verificarPasswords(); return false">  
                <label for="mail" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Mail</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="email" name="mail" required/>
                    </div>
                </div>
                <label for="nick" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Usuario</label>    
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="text" name="nick" required/>
                    </div>
                </div>
                <label for="contrasena" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Contraseña</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="password" id="contrasena" name="contrasena" required/>
                    </div>
                </div>
                <label for="contrasena1" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Repetir Contraseña</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="password" id="contrasena1" name="contrasena1" required/>
                    </div>
                </div>
                <br>
                <hr>
                <h2 id="text_h2">Datos de Cliente</h2>
                <label for="nombre" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Nombre</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="text" name="nombre" required/>
                    </div>
                </div>
                <label for="apellido" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Apellido</label>    
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="text" name="apellido" required/>
                    </div>
                </div>
                <label for="cuil" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Cuil</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input id="cuil" class="form-control" type="number" name="cuil" required/>
                    </div>
                </div>
                <label for="domicilio" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Domicilio</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="text" name="domicilio" required/>
                    </div>
                </div>
                <label for="telefono" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Tel&eacute;fono</label>   
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input id="telefono" class="form-control" type="number" name="telefono" required/>
                    </div>
                </div>
                <div id="msg"></div>
                <!-- Mensajes de Verificación -->
                <div id="error" class="alert alert-danger col-sm-10 ocultar" role="alert">
                    Las Contraseñas no coinciden, vuelve a intentar !
                </div>
                
                <!-- Fin Mensajes de Verificación -->
                <div class="text-center" id="estilo_bottom">
                    <button type="submit" class="btn btn-primary"> Guardar </button>
                    <a href="/" type="button" class="btn btn-secondary"> Volver </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.15/jquery.mask.min.js"></script>

<script src="/js/usuario.js"></>

<script>
    $(document).ready(function(){
        $('#cuil').mask('00000000000');
        $('#telefono').mask('0000000000');
    });
</script>
  
@tag.footer()
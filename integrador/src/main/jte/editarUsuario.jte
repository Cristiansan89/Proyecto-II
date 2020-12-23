@param edu.unam.integrador.paginas.ModeloUsuario modelo

@tag.header()

<div class="card" id="estilo_card"> 
    <div class="card-footer">
        <h2><b>Editar Usuario</b></h2>
        <br>
        <div id="estilo_card_form">
            <form action="/usuarios/actualizar/${modelo.usuario.getIdUsuario()}" method="post">
                
                <label for="mail" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Mail</label>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="email" name="mail" value="${modelo.usuario.getMail()}" required/>
                    </div>
                </div>
                <label for="nick" class="col-sm-8 col-form-label font-weight-bold" id="text-size">Usuario</label>    
                <div class="form-group row">
                    <div class="col-sm-10">
                        <input class="form-control" type="text" name="nick" value="${modelo.nick}" readonly/>
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
                <div id="msg"></div>
                <!-- Mensajes de Verificación -->
                <div id="error" class="alert alert-danger col-sm-10 ocultar" role="alert">
                    Las Contraseñas no coinciden, vuelve a intentar !
                </div>
                <div id="ok" class="alert alert-success col-sm-10 ocultar" role="alert">
                    Las Contraseñas coinciden ! (Procesando formulario ... )
                </div>
                <!-- Fin Mensajes de Verificación -->
                <div class="text-center" id="estilo_bottom">
                    <button type="submit" id="login" class="btn btn-primary"> Modificar </button>
                    <a href="/" type="button" class="btn btn-secondary"> Volver </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="/js/usuario.js"></>

<script>
    $(document).ready(function(){
        $('#cuil').mask('00000000000');
        $('#telefono').mask('0000000000');
    });
</script>

@tag.footer()
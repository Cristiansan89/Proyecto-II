@param edu.unam.integrador.paginas.ModeloIndex modelo

@tag.header()

@if (!modelo.nombreUsuario.trim().isEmpty()) 
    <h2><b> Hola ${modelo.nombreUsuario}! </b></h2>
@else        
    <form action="/" method="post" onsubmit="return validarUsuario();">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"> Usuario </label>
            <input class="form-control col-sm-4" type="text" placeholder="nombre del usuario" id="nombreUsuario" name="nombreUsuario"/>
        </div>
        <button class="btn btn-primary"> Ingresar </button>
    </form>
@endif

<script src="/js/validarUsuario.js"></script>
@tag.footer()
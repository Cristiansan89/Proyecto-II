@param edu.unam.integrador.paginas.ModeloIndex modelo

@tag.header()

<div id="bar_menu">
    @if (! modelo.nombreUsuario.trim().isEmpty())
        <nav class="navbar navbar-expand-lg navbar-light bg-primary">   
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link text-white" href="/inicio">Inicio</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Cliente
                        </a>
                        <div class="dropdown-menu bg-warning" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item text-dark" href="/crearCliente">Crear Cliente</a>
                            <a class="dropdown-item text-dark" href="/editarCliente">Editar Cliente</a>
                            <a class="dropdown-item text-dark" href="/clientes">Ver Cliente</a>
                        </div>
                    </li> 
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Producto
                        </a>
                        <div class="dropdown-menu bg-warning" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item text-dark" href="/crearProducto">Crear Producto</a>
                            <a class="dropdown-item text-dark" href="/editarProducto">Editar Producto</a>
                            <a class="dropdown-item text-dark" href="/productos">Ver Producto</a>
                        </div>
                    </li>
                </ul>
            </div>
            <div>
                <span>${modelo.nombreUsuario}</span><br>
                <span>12/12/20</span>
            </div>
        </nav>
    @else
        <form action="/" method="post" onsubmit="validarUsuario();">
        <div class="form-group row">
                <label class="col-sm-2 col-form-label"> Usuario </label>
                <input class="form-control col-sm-4" type="text" placeholder="nombre del usuario" id="nombreUsuario" name="nombreUsuario"/>
            </div>
            <button class="btn btn-primary"> Ingresar </button>
        </form>
    @endif
</div>
<script src="/js/validarUsuario.js"></script>

@tag.footer()
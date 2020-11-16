@param edu.unam.integrador.paginas.ModeloIndex modelo

@tag.header()

<div id="bar_menu">
    @if (! modelo.nombreUsuario.trim().isEmpty())
        <nav class="navbar navbar-expand-lg navbar-light bg-info">   
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link text-white" href="/">
                            <svg width="1.5em" height="1.5em" viewBox="0 0 16 16" class="bi bi-journal-text" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                <path d="M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2z"/>
                                <path d="M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1z"/>
                                <path fill-rule="evenodd" d="M5 10.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
                            </svg>
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Cliente
                        </a>
                        <div class="dropdown-menu bg-warning" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item text-dark" href="/clientes/nuevo">Crear Cliente</a>
                            <a class="dropdown-item text-dark" href="/clientes/:id">Editar Cliente</a>
                            <a class="dropdown-item text-dark" href="/clientes">Ver Cliente</a>
                        </div>
                    </li> 
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Producto
                        </a>
                        <div class="dropdown-menu bg-warning" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item text-dark" href="/productos/nuevo">Crear Producto</a>
                            <a class="dropdown-item text-dark" href="/productos/:id">Editar Producto</a>
                            <a class="dropdown-item text-dark" href="/productos">Ver Producto</a>
                        </div>
                    </li>
                </ul>
            </div>
            <div>
                <span><b>${modelo.nombreUsuario}</b></span><br>
                <span>12/12/20</span>
            </div>
        </nav>
    @else
         <div id="bar_principal">
            <nav class="navbar navbar-expand-lg navbar-light bg-primary">   
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item active">
                            <a class="nav-link text-white" href="/">Inicio</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-white" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Registrarse
                            </a>
                            <div class="dropdown-menu bg-warning" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item text-dark" href="">Crear Cuenta</a>
                                <a class="dropdown-item text-dark" href="">Recuperar Cuenta</a>
                            </div>
                        </li> 
                    </ul>
                </div>
                <div>
                    <span>12/12/20</span>
                </div>
            </nav>
        </div>
        <div class="card" style="width: 35rem; top: 5rem; left: 25rem;"> 
            <div class="card-body">
                <form action="/" method="post" onsubmit="validarUsuario();" class="text-center">
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label"> Usuario </label>
                        <input class="form-control col-sm-4" type="text" placeholder="nombre del usuario" id="nombreUsuario" name="nombreUsuario"/>
                    </div>
                    <button class="btn btn-primary"> Ingresar </button>
                </form>
            </div>
        </div>
    @endif
</div>

<script src="/js/validarUsuario.js"></script>
@tag.footer()
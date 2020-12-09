
@param edu.unam.integrador.paginas.ModeloUsuarios modelo

@tag.header()
<div id="bar_menu">
    @if (modelo.rol.equals("admin"))
        <!-- Barra de Menú Admin -->
        <div id="bar_principal">
            <nav class="navbar navbar-expand-lg navbar-light bg-primary">   
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item active">
                            <span class="nav-link text-white" href="/">
                                <svg width="1.5em" height="1.5em" viewBox="0 0 16 16" class="bi bi-journal-text" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2z"/>
                                    <path d="M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1z"/>
                                    <path fill-rule="evenodd" d="M5 10.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
                                </svg>
                            </span>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-white font-weight-bold h5 mb-0" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Cliente
                            </a>
                            <div class="dropdown-menu bg-warning" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item text-dark" href="/clientes">Ver Cliente</a>
                            </div>
                        </li> 
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-white font-weight-bold h5 mb-0" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Producto
                            </a>
                            <div class="dropdown-menu bg-warning" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item text-dark" href="/productos/nuevo">Crear Producto</a>
                                <a class="dropdown-item text-dark" href="/productos">Ver Producto</a>
                            </div>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-white font-weight-bold h5 mb-0" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Pedido
                            </a>
                            <div class="dropdown-menu bg-warning" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item text-dark" href="/pedidos">Ver Pedido</a>
                            </div>
                        </li>
                    </ul>
                </div>
                <div>
                    <table id="table_menu">
                        <tr>
                            <td>
                                <p class="text-white font-weight-bold h6 mt-1 mb-0 mt-o" id="fecha"></p>    
                            </td>
                            <td>
                                <ul class="navbar-nav mr-auto">
                                    <li class="nav-item dropdown">
                                        <a class="nav-link dropdown-toggle text-white font-weight-bold h5 ml-2 mr-2 mb-0 mt-0 text-uppercase" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <span>  ${modelo.nick}  </span>
                                        </a>
                                        <div class="dropdown-menu bg-danger" aria-labelledby="navbarDropdown">
                                            <a class="dropdown-item text-light font-weight-bold" href="/cerrar">Cerrar Sesi&oacute;n</a>
                                        </div>
                                    </li>
                                </ul>      
                            </td>
                        </tr>
                    </table>
                </div>
            </nav>
        </div>
    @elseif (modelo.rol.equals("cliente"))
        <!-- Barra de Menú Cliente -->
        <div id="bar_principal">
            <nav class="navbar navbar-expand-lg navbar-light bg-primary">   
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item active mb-0">
                            <span class="nav-link text-white" href="/">
                                <svg width="1.5em" height="1.5em" viewBox="0 0 16 16" class="bi bi-journal-text" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2z"/>
                                    <path d="M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1z"/>
                                    <path fill-rule="evenodd" d="M5 10.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
                                </svg>
                            </span>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-white font-weight-bold h5 mb-0" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Cliente
                            </a>
                            <div class="dropdown-menu bg-warning" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item text-dark" href="/clientes/modificar/:id">Editar Mis Datos</a>
                            </div>
                        </li> 
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-white font-weight-bold h5 mb-0" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Producto
                            </a>
                            <div class="dropdown-menu bg-warning" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item text-dark" href="/productos">Ver Producto</a>
                            </div>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-white font-weight-bold h5 mb-0" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Pedido
                            </a>
                            <div class="dropdown-menu bg-warning" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item text-dark" href="/pedidos/crear">Realizar Pedido</a>
                                <a class="dropdown-item text-dark" href="/pedidos/lista/:id">Mis Pedido</a>
                            </div>
                        </li>
                    </ul>
                </div>
                <div>
                    <table id="table_menu">
                        <tr>
                            <td>
                                <p class="text-white font-weight-bold h6 mt-1 mb-0 mt-o" id="fecha"></p>    
                            </td>
                            <td>
                                <ul class="navbar-nav mr-auto">
                                    <li class="nav-item dropdown">
                                        <a class="nav-link dropdown-toggle text-white font-weight-bold h5 ml-2 mr-2 mb-0 mt-0 text-uppercase" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <span>  ${modelo.nick}  </span>
                                        </a>
                                        <div class="dropdown-menu bg-danger" aria-labelledby="navbarDropdown">
                                            <a class="dropdown-item text-light font-weight-bold" href="/cerrar">Cerrar Sesi&oacute;n</a>
                                        </div>
                                    </li>
                                </ul>      
                            </td>
                        </tr>
                    </table>
                </div>
            </nav>
        </div> 
    @else
        <!-- Inicio de Sesión -->
        <div id="bar_principal">
            <nav class="navbar navbar-expand-lg navbar-light bg-primary">   
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item ">
                            <span class="nav-link text-white" href="/">
                                <svg width="1.5em" height="1.5em" viewBox="0 0 16 16" class="bi bi-journal-text" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2z"/>
                                    <path d="M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1z"/>
                                    <path fill-rule="evenodd" d="M5 10.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
                                </svg>
                            </span>
                        </li>
                        <li class="nav-item dropdown text-center">
                            <a class="nav-link dropdown-toggle text-white font-weight-bold h5 mb-0" href="#" id="navbarDropdown " role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Registrarse
                            </a>
                            <div class="dropdown-menu bg-warning" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item text-dark" href="/clientes/nuevo">Crear Cuenta</a>
                                <a class="dropdown-item text-dark" href="">Recuperar Cuenta</a>
                            </div>
                        </li> 
                    </ul>
                </div>
            </nav>
        </div>
        <div class="card" id="estilo_card"> 
            <div class="card-footer">
                <div id="estilo_card_form">
                    <h3 class="text-center font-weight-bold"> Iniciar Sesi&oacute;n </h3>
                    <br>  
                    <form action="/" method="post" onsubmit="validarUsuario();" class="text-center">
                        <div class="form-group row">                     
                            <label class="col-sm-3 col-form-label font-weight-bold" id="text-size"> Usuario </label>
                            <input class="form-control col-sm-8" type="text" name="nick"/>
                        </div>
                        <div class="form-group row">                     
                            <label class="col-sm-3 col-form-label font-weight-bold" id="text-size"> Contraseña </label>
                            <input class="form-control col-sm-8" type="password" name="contrasena"/>
                        </div>
                        <button class="btn btn-primary"> Ingresar </button>
                    </form>
                </div>
            </div>
        </div>
    @endif
</div>

<script src="/js/validarUsuario.js"></script>
<script src="/js/fechaActual.js"></script>

@tag.footer()
@param edu.unam.integrador.paginas.ModeloIndex modelo

@tag.header()

<div id="bar_menu">
  @if (! modelo.nombreUsuario.trim().isEmpty())
    <nav class="navbar navbar-expand-sm navbar-dark bg-info">
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item active">
            <a class="nav-link" href="/inicio">Inicio</a>
          </li>
          <li class="nav-item dropdown">
             <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Cliente
            </a>
            <div class="dropdown-menu" aria-labelledby="navbardropdown">
              <a class="dropdown-item" href="/cliente">Ver Clientes</a>
              <a class="dropdown-item" href="/cliente/nuevo">Agregar Cliente</a>
            </div>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Producto
            </a>
            <div class="dropdown-menu" aria-labelledby="navbarProducto">
              <a class="dropdown-item" href="/producto">Ver Producto</a>
              <a class="dropdown-item" href="/producto/nuevo">Agregar Producto</a>
            </div>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Dropdown link
            </a>
            <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
              <a class="dropdown-item" href="#">Action</a>
              <a class="dropdown-item" href="#">Another action</a>
              <a class="dropdown-item" href="#">Something else here</a>
            </div>
          </li>
          <li class="nav-item" align="right">
            <div id="user_text"><b> ${modelo.nombreUsuario}! </b></div>
          </li>
        </ul>
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
@param edu.unam.integrador.paginas.ModeloIndex modelo

@tag.header()

@if (! modelo.nombreUsuario.trim().isEmpty())
  <h2>Distribuidora</h2>
  <h1><b> ${modelo.nombreUsuario}! </b></h1>
  <nav class="navbar navbar-expand-sm navbar-dark bg-info">
    <a class="navbar-brand" href="Inicio">Inicio</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
      <div class="navbar-nav">
        <a class="nav-link active " href="Cliente">Cliente <span class="sr-only">(current)</span></a>
        <a class="nav-link" href="Producto">Producto </a>
      </div>
    </div>
    <div>
      <ul class="navbar-nav">
            <li class="nav-item">
                <a class="navbar-brand" href="/clientes"> Ver clientes </a>
            </li>
            <li class="nav-item">
                <a class="navbar-brand" href="/clientes/nuevo"> Agregar cliente </a>
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

<script src="/js/validarUsuario.js"></script>

@tag.footer()
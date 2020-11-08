@param edu.unam.integrador.paginas.ModeloIndex modelo

@tag.header()

@if (! modelo.nombreUsuario.trim().isEmpty())
  <h2>Distribuidora</h2>
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
  </nav>
@else
  <form action="/" method="post">
    <label>Usuario </label>
    <input type="text" placeholder="nombreUsuario" name="nombreUsuario">
    <button>Ingresar</button>
  </form>
@endif

@tag.footer()
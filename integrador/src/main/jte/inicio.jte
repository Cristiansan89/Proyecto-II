
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
                                <a class="dropdown-item text-dark" href="/pedidos/listapedido">Ver Pedido</a>
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
                            <a class="nav-link dropdown-toggle text-white font-weight-bold h5 mb-0" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                Cliente
                            </a>
                            <div class="dropdown-menu bg-warning" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item text-dark" href="/clientes/modificar/${modelo.idCliente}"> Editar Mis Datos </a>
                                <a class="dropdown-item text-dark" href="/usuarios/modificar/${modelo.idUsuario}"> Cambiar Contrase&ntilde;a </a>
                            </div>
                        </li> 
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-white font-weight-bold h5 mb-0" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Producto
                            </a>
                            <div class="dropdown-menu bg-warning" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item text-dark" href="/productos"> Ver Producto </a>
                            </div>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-white font-weight-bold h5 mb-0" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Pedido
                            </a>
                            <div class="dropdown-menu bg-warning" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item text-dark" href="/pedidos/crear">Realizar Pedido</a>
                                <a class="dropdown-item text-dark" href="/pedido/listapedido/cliente/${modelo.idCliente}">Mis Pedido</a>
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

        <!-- Carousel ===> MARCA de Productos -->
        <div class="mt-5 ml-4 mr-4">
            <div id="carousel1" class="carousel slide" data-ride="carousel">
                <div class="carousel-item active" data-interval="25000">
                    <div class="row ml-5">
                        <div class="col px-0">
                            <img src="/img/marca/7up.png" class="w-25 ml-4 mb-2 rounded-lg" alt="7up">
                            <img src="/img/marca/1882.png" class="w-25 ml-4 mb-2 rounded-lg" alt="1882">
                            <img src="/img/marca/absolut.png" class="w-25 ml-4 mb-2 rounded-lg" alt="absolut">
                            
                            <img src="/img/marca/baggio.png" class="w-25 ml-4 mb-2 rounded-lg" alt="baggio">
                            <img src="/img/marca/bagley.png" class="w-25 ml-4 mb-2 rounded-lg" alt="bagley">
                            <img src="/img/marca/bianchi.png" class="w-25 ml-4 mb-2 rounded-lg" alt="bianchi">

                            <img src="/img/marca/cif.png" class="w-25 ml-4 mb-2 rounded-lg" alt="cif">
                            <img src="/img/marca/clight.png" class="w-25 ml-4 mb-2 rounded-lg" alt="clight">
                            <img src="/img/marca/cocacola.png" class="w-25 ml-4 mb-2 rounded-lg" alt="cocacola">
                            
                            <img src="/img/marca/donvalentin.png" class="w-25 ml-4 mb-2 rounded-lg" alt="donvalentin">
                            <img src="/img/marca/doritos.png" class="w-25 ml-4 mb-2 rounded-lg" alt="doritos">
                            <img src="/img/marca/dosanclas.png" class="w-25 ml-4 mb-2 rounded-lg" alt="dosanclas">

                            <img src="/img/marca/gallo.png" class="w-25 ml-4 mb-2 rounded-lg" alt="gallo">
                            <img src="/img/marca/gancia.png" class="w-25 ml-4 mb-2 rounded-lg" alt="gancia">
                            <img src="/img/marca/gatorade.png" class="w-25 ml-4 mb-2 rounded-lg" alt="gatorade">
                            
                            <img src="/img/marca/lacampagnola.png" class="w-25 ml-4 mb-2 rounded-lg" alt="lacampagnola">
                            <img src="/img/marca/lacaroyense.png" class="w-25 ml-4 mb-2 rounded-lg" alt="lacaroyense">
                            <img src="/img/marca/lapaulina.png" class="w-25 ml-4 mb-2 rounded-lg" alt="lapaulina">
                            
                            <img src="/img/marca/maizena.png" class="w-25 ml-4 mb-2 rounded-lg" alt="maizena">
                            <img src="/img/marca/malibu.png" class="w-25 ml-4 mb-2 rounded-lg" alt="malibu">
                            <img src="/img/marca/manaos.png" class="w-25 ml-4 mb-2 rounded-lg" alt="manaos">
                        </div>
                        <div class="col px-0">
                            <img src="/img/marca/ace.png" class="w-25 ml-4 mb-2 rounded-lg" alt="ace">
                            <img src="/img/marca/aguadelasmisiones.png" class="w-25 ml-4 mb-2 rounded-lg" alt="aguadelasmisiones">
                            <img src="/img/marca/ala.png" class="w-25 ml-4 mb-2 rounded-lg" alt="ala">
                            
                            <img src="/img/marca/bic.png" class="w-25 ml-4 mb-2 rounded-lg" alt="amanda">
                            <img src="/img/marca/blancaflor.png" class="w-25 ml-4 mb-2 rounded-lg" alt="callia">
                            <img src="/img/marca/brahma.png" class="w-25 ml-4 mb-2 rounded-lg" alt="danica">

                            <img src="/img/marca/cocinero.png" class="w-25 ml-4 mb-2 rounded-lg" alt="cocinero">
                            <img src="/img/marca/colgate.png" class="w-25 ml-4 mb-2 rounded-lg" alt="colgate">
                            <img src="/img/marca/corona.png" class="w-25 ml-4 mb-2 rounded-lg" alt="corona">
                            
                            <img src="/img/marca/dove.png" class="w-25 ml-4 mb-2 rounded-lg" alt="dove">
                            <img src="/img/marca/drive.png" class="w-25 ml-4 mb-2 rounded-lg" alt="drive">
                            <img src="/img/marca/ecodelosandes.png" class="w-25 ml-4 mb-2 rounded-lg" alt="ecodelosandes">

                            <img src="/img/marca/gillete.png" class="w-25 ml-4 mb-2 rounded-lg" alt="gillete">
                            <img src="/img/marca/head&shoulders.png" class="w-25 ml-4 mb-2 rounded-lg" alt="head&shoulders">
                            <img src="/img/marca/heineken.png" class="w-25 ml-4 mb-2 rounded-lg" alt="heineken">
                            
                            <img src="/img/marca/laprovidencia.png" class="w-25 ml-4 mb-2 rounded-lg" alt="laprovidencia">
                            <img src="/img/marca/laserenisima.png" class="w-25 ml-4 mb-2 rounded-lg" alt="laserenisima">
                            <img src="/img/marca/lavirginia.png" class="w-25 ml-4 mb-2 rounded-lg" alt="lavirginia">
                            
                            <img src="/img/marca/marolio.png" class="w-25 ml-4 mb-2 rounded-lg" alt="marolio">
                            <img src="/img/marca/martini.png" class="w-25 ml-4 mb-2 rounded-lg" alt="martini">
                            <img src="/img/marca/matarazzo.png" class="w-25 ml-4 mb-2 rounded-lg" alt="matarazzo">
                        </div>
                        <div class="col px-0">
                            <img src="/img/marca/alicante.png" class="w-25 ml-4 mb-2 rounded-lg" alt="alicante">
                            <img src="/img/marca/almamora.png" class="w-25 ml-4 mb-2 rounded-lg" alt="almamora">
                            <img src="/img/marca/amanda.png" class="w-25 ml-4 mb-2 rounded-lg" alt="amanda">
                            
                            <img src="/img/marca/branca.png" class="w-25 ml-4 mb-2 rounded-lg" alt="branca">
                            <img src="/img/marca/budweiser.png" class="w-25 ml-4 mb-2 rounded-lg" alt="budweiser">
                            <img src="/img/marca/callia.png" class="w-25 ml-4 mb-2 rounded-lg" alt="callia">

                            <img src="/img/marca/cusenier.png" class="w-25 ml-4 mb-2 rounded-lg" alt="cusenier">
                            <img src="/img/marca/dada.png" class="w-25 ml-4 mb-2 rounded-lg" alt="dada">
                            <img src="/img/marca/danica.png" class="w-25 ml-4 mb-2 rounded-lg" alt="danica">
                            
                            <img src="/img/marca/elite.png" class="w-25 ml-4 mb-2 rounded-lg" alt="elite">
                            <img src="/img/marca/elvive.png" class="w-25 ml-4 mb-2 rounded-lg" alt="elvive">
                            <img src="/img/marca/estrella.png" class="w-25 ml-4 mb-2 rounded-lg" alt="estrella">

                            <img src="/img/marca/hellmanns.png" class="w-25 ml-4 mb-2 rounded-lg" alt="hellmanns">
                            <img src="/img/marca/higienol.png" class="w-25 ml-4 mb-2 rounded-lg" alt="higienol">
                            <img src="/img/marca/huggies.png" class="w-25 ml-4 mb-2 rounded-lg" alt="huggies">
                            
                            <img src="/img/marca/lays.png" class="w-25 ml-4 mb-2 rounded-lg" alt="lays">
                            <img src="/img/marca/ledesma.png" class="w-25 ml-4 mb-2 rounded-lg" alt="ledesma">
                            <img src="/img/marca/levex.png" class="w-25 ml-4 mb-2 rounded-lg" alt="levex">
                            
                            <img src="/img/marca/medianaranja.png" class="w-25 ml-4 mb-2 rounded-lg" alt="medianaranja">
                            <img src="/img/marca/milkaut.png" class="w-25 ml-4 mb-2 rounded-lg" alt="milkaut">
                            <img src="/img/marca/molinocanuelas.png" class="w-25 ml-4 mb-2 rounded-lg" alt="molinocanuelas">
                        </div>
                        <div class="col px-0">
                            <img src="/img/marca/aquarius.png" class="w-25 ml-4 mb-2 rounded-lg" alt="aquarius">
                            <img src="/img/marca/arcor.png" class="w-25 ml-4 mb-2 rounded-lg" alt="arcor">
                            <img src="/img/marca/ariel.png" class="w-25 ml-4 mb-2 rounded-lg" alt="ariel">
                            
                            <img src="/img/marca/canale.png" class="w-25 ml-4 mb-2 rounded-lg" alt="canale">
                            <img src="/img/marca/celusal.png" class="w-25 ml-4 mb-2 rounded-lg" alt="celusal">
                            <img src="/img/marca/chandon.png" class="w-25 ml-4 mb-2 rounded-lg" alt="chandon">

                            <img src="/img/marca/danone.png" class="w-25 ml-4 mb-2 rounded-lg" alt="danone">
                            <img src="/img/marca/dermaglos.png" class="w-25 ml-4 mb-2 rounded-lg" alt="dermaglos">
                            <img src="/img/marca/dogchow.png" class="w-25 ml-4 mb-2 rounded-lg" alt="dogchow">
                            
                            <img src="/img/marca/exquisita.png" class="w-25 ml-4 mb-2 rounded-lg" alt="exquisita">
                            <img src="/img/marca/fanta.png" class="w-25 ml-4 mb-2 rounded-lg" alt="fanta">
                            <img src="/img/marca/favorita.png" class="w-25 ml-4 mb-2 rounded-lg" alt="favorita">

                            <img src="/img/marca/ilolay.png" class="w-25 ml-4 mb-2 rounded-lg" alt="ilolay">
                            <img src="/img/marca/imperial.png" class="w-25 ml-4 mb-2 rounded-lg" alt="imperial">
                            <img src="/img/marca/jackdaniels.png" class="w-25 ml-4 mb-2 rounded-lg" alt="jackdaniels">
                            
                            <img src="/img/marca/lifebuoy.png" class="w-25 ml-4 mb-2 rounded-lg" alt="lifebuoy">
                            <img src="/img/marca/luchetti.png" class="w-25 ml-4 mb-2 rounded-lg" alt="luchetti">
                            <img src="/img/marca/lux.png" class="w-25 ml-4 mb-2 rounded-lg" alt="lux">
                            
                            <img src="/img/marca/monster.png" class="w-25 ml-4 mb-2 rounded-lg" alt="monster">
                            <img src="/img/marca/mortimer.png" class="w-25 ml-4 mb-2 rounded-lg" alt="mortimer">
                            <img src="/img/marca/mrmusculo.png" class="w-25 ml-4 mb-2 rounded-lg" alt="mrmusculo">
                        </div>  
                        <div class="col pl-0 pr-5 mr-5">
                            <img src="/img/marca/axe.png" class="w-25 ml-4 mb-2 rounded-lg" alt="axe">
                            <img src="/img/marca/ayudin.png" class="w-25 ml-4 mb-2 rounded-lg" alt="ayudin">
                            <img src="/img/marca/bacardi.png" class="w-25 ml-4 mb-2 rounded-lg" alt="bacardi">
                            
                            <img src="/img/marca/cheetos.png" class="w-25 ml-4 mb-2 rounded-lg" alt="cheetos">
                            <img src="/img/marca/chivasregal.png" class="w-25 ml-4 mb-2 rounded-lg" alt="chivasregal">
                            <img src="/img/marca/cica.png" class="w-25 ml-4 mb-2 rounded-lg" alt="cica">

                            <img src="/img/marca/dogui.png" class="w-25 ml-4 mb-2 rounded-lg" alt="dogui">
                            <img src="/img/marca/donfelipe.png" class="w-25 ml-4 mb-2 rounded-lg" alt="donfelipe">
                            <img src="/img/marca/donsatur.png" class="w-25 ml-4 mb-2 rounded-lg" alt="donsatur">
                            
                            <img src="/img/marca/fluidomanchester.png" class="w-25 ml-4 mb-2 rounded-lg" alt="fluidomanchester">
                            <img src="/img/marca/frizze.png" class="w-25 ml-4 mb-2 rounded-lg" alt="frizze">
                            <img src="/img/marca/fuyi.png" class="w-25 ml-4 mb-2 rounded-lg" alt="fuyi">

                            <img src="/img/marca/johnsonjohnson.png" class="w-25 ml-4 mb-2 rounded-lg" alt="johnsonjohnson">
                            <img src="/img/marca/kahlua.png" class="w-25 ml-4 mb-2 rounded-lg" alt="kahlua">
                            <img src="/img/marca/knoll.png" class="w-25 ml-4 mb-2 rounded-lg" alt="knoll">
                            
                            <img src="/img/marca/lysoform.png" class="w-25 ml-4 mb-2 rounded-lg" alt="lysoform">
                            <img src="/img/marca/maggi.png" class="w-25 ml-4 mb-2 rounded-lg" alt="maggi">
                            <img src="/img/marca/magistral.png" class="w-25 ml-4 mb-2 rounded-lg" alt="magistral">
                            
                            <img src="/img/marca/natura.png" class="w-25 ml-4 mb-2 rounded-lg" alt="natura">
                            <img src="/img/marca/nescafe.png" class="w-25 ml-4 mb-2 rounded-lg" alt="nescafe">
                            <img src="/img/marca/nestle.png" class="w-25 ml-4 mb-2 rounded-lg" alt="nestle">
                        </div> 
                    </div>
                </div>
                <div class="carousel-item" data-interval="25000">
                    <div class="row ml-5">
                        <div class="col px-0">
                            <img src="/img/marca/newage.png" class="w-25 ml-4 mb-2 rounded-lg" alt="newage">
                            <img src="/img/marca/nivea.png" class="w-25 ml-4 mb-2 rounded-lg" alt="nivea">
                            <img src="/img/marca/norton.png" class="w-25 ml-4 mb-2 rounded-lg" alt="norton">
                            
                            <img src="/img/marca/poett.png" class="w-25 ml-4 mb-2 rounded-lg" alt="poett">
                            <img src="/img/marca/primicia.png" class="w-25 ml-4 mb-2 rounded-lg" alt="primicia">
                            <img src="/img/marca/pringles.png" class="w-25 ml-4 mb-2 rounded-lg" alt="pringles">

                            <img src="/img/marca/sabrositos.png" class="w-25 ml-4 mb-2 rounded-lg" alt="sabrositos">
                            <img src="/img/marca/sancor.png" class="w-25 ml-4 mb-2 rounded-lg" alt="sancor">
                            <img src="/img/marca/santaana.png" class="w-25 ml-4 mb-2 rounded-lg" alt="santaana">
                            
                            <img src="/img/marca/stellaartois.png" class="w-25 ml-4 mb-2 rounded-lg" alt="stellaartois">
                            <img src="/img/marca/sussex.png" class="w-25 ml-4 mb-2 rounded-lg" alt="sussex">
                            <img src="/img/marca/tang.png" class="w-25 ml-4 mb-2 rounded-lg" alt="tang">

                            <img src="/img/marca/wassington.png" class="w-25 ml-4 mb-2 rounded-lg" alt="wassington">
                            <img src="/img/marca/zorro.png" class="w-25 ml-4 mb-2 rounded-lg" alt="zorro">
                        </div>
                        <div class="col px-0">
                            <img src="/img/marca/off.png" class="w-25 ml-4 mb-2 rounded-lg" alt="off">
                            <img src="/img/marca/oralb.png" class="w-25 ml-4 mb-2 rounded-lg" alt="oralb">
                            <img src="/img/marca/oreo.png" class="w-25 ml-4 mb-2 rounded-lg" alt="oreo">
                            
                            <img src="/img/marca/procenex.png" class="w-25 ml-4 mb-2 rounded-lg" alt="procenex">
                            <img src="/img/marca/protex.png" class="w-25 ml-4 mb-2 rounded-lg" alt="protex">
                            <img src="/img/marca/pureza.png" class="w-25 ml-4 mb-2 rounded-lg" alt="pureza">

                            <img src="/img/marca/santaisabel.png" class="w-25 ml-4 mb-2 rounded-lg" alt="santaisabel">
                            <img src="/img/marca/santajulia.png" class="w-25 ml-4 mb-2 rounded-lg" alt="santajulia">
                            <img src="/img/marca/santelmo.png" class="w-25 ml-4 mb-2 rounded-lg" alt="santelmo">

                            <img src="/img/marca/taragui.png" class="w-25 ml-4 mb-2 rounded-lg" alt="taragui">
                            <img src="/img/marca/terma.png" class="w-25 ml-4 mb-2 rounded-lg" alt="terma">
                            <img src="/img/marca/terrabusi.png" class="w-25 ml-4 mb-2 rounded-lg" alt="terrabusi">
                        </div>
                        <div class="col px-0">
                            <img src="/img/marca/paladini.png" class="w-25 ml-4 mb-2 rounded-lg" alt="paladini">
                            <img src="/img/marca/palmolive.png" class="w-25 ml-4 mb-2 rounded-lg" alt="palmolive">
                            <img src="/img/marca/pampers.png" class="w-25 ml-4 mb-2 rounded-lg" alt="pampers">
                            
                            <img src="/img/marca/quaker.png" class="w-25 ml-4 mb-2 rounded-lg" alt="quaker">
                            <img src="/img/marca/quilmes.png" class="w-25 ml-4 mb-2 rounded-lg" alt="quilmes">
                            <img src="/img/marca/raid.png" class="w-25 ml-4 mb-2 rounded-lg" alt="raid">

                            <img src="/img/marca/schneider.png" class="w-25 ml-4 mb-2 rounded-lg" alt="schneider">
                            <img src="/img/marca/scott.png" class="w-25 ml-4 mb-2 rounded-lg" alt="scott">
                            <img src="/img/marca/sedal.png" class="w-25 ml-4 mb-2 rounded-lg" alt="sedal">
                            
                            <img src="/img/marca/tiernitos.png" class="w-25 ml-4 mb-2 rounded-lg" alt="tiernitos">
                            <img src="/img/marca/trapiche.png" class="w-25 ml-4 mb-2 rounded-lg" alt="trapiche">
                            <img src="/img/marca/tregar.png" class="w-25 ml-4 mb-2 rounded-lg" alt="tregar">
                        </div>
                        <div class="col px-0">
                            <img src="/img/marca/pantene.png" class="w-25 ml-4 mb-2 rounded-lg" alt="pantene">
                            <img src="/img/marca/pasosdelostoros.png" class="w-25 ml-4 mb-2 rounded-lg" alt="pasosdelostoros">
                            <img src="/img/marca/paty.png" class="w-25 ml-4 mb-2 rounded-lg" alt="paty">
                            
                            <img src="/img/marca/redbull.png" class="w-25 ml-4 mb-2 rounded-lg" alt="redbull">
                            <img src="/img/marca/reinharina.png" class="w-25 ml-4 mb-2 rounded-lg" alt="reinharina">
                            <img src="/img/marca/rexona.png" class="w-25 ml-4 mb-2 rounded-lg" alt="rexona">

                            <img src="/img/marca/ser.png" class="w-25 ml-4 mb-2 rounded-lg" alt="ser">
                            <img src="/img/marca/skip.png" class="w-25 ml-4 mb-2 rounded-lg" alt="skip">
                            <img src="/img/marca/skyy.png" class="w-25 ml-4 mb-2 rounded-lg" alt="skyy">
                            
                            <img src="/img/marca/veritas.png" class="w-25 ml-4 mb-2 rounded-lg" alt="veritas">
                            <img src="/img/marca/villadelsur.png" class="w-25 ml-4 mb-2 rounded-lg" alt="villadelsur">
                            <img src="/img/marca/villavicencio.png" class="w-25 ml-4 mb-2 rounded-lg" alt="villavicencio">
                        </div>  
                        <div class="col pl-0 pr-5 mr-5">
                            <img src="/img/marca/pedigree.png" class="w-25 ml-4 mb-2 rounded-lg" alt="pedigree">
                            <img src="/img/marca/pepsi.png" class="w-25 ml-4 mb-2 rounded-lg" alt="pepsi">
                            <img src="/img/marca/plusbelle.png" class="w-25 ml-4 mb-2 rounded-lg" alt="plusbelle">
                            
                            <img src="/img/marca/rik.png" class="w-25 ml-4 mb-2 rounded-lg" alt="rik">
                            <img src="/img/marca/romance.png" class="w-25 ml-4 mb-2 rounded-lg" alt="romance">
                            <img src="/img/marca/rosamonte.png" class="w-25 ml-4 mb-2 rounded-lg" alt="rosamonte">

                            <img src="/img/marca/smirnoff.png" class="w-25 ml-4 mb-2 rounded-lg" alt="smirnoff">
                            <img src="/img/marca/speed.png" class="w-25 ml-4 mb-2 rounded-lg" alt="speed">
                            <img src="/img/marca/sprite.png" class="w-25 ml-4 mb-2 rounded-lg" alt="sprite">
                            
                            <img src="/img/marca/vim.png" class="w-25 ml-4 mb-2 rounded-lg" alt="vim">
                            <img src="/img/marca/vinadelbalbo.png" class="w-25 ml-4 mb-2 rounded-lg" alt="vinadelbalbo">
                            <img src="/img/marca/vivere.png" class="w-25 ml-4 mb-2 rounded-lg" alt="vivere">
                        </div> 
                    </div>
                </div>
            </div>    
            <!--Controles NEXT y PREV-->
            <div >
                <a class="carousel-control-prev position-relative" href="#carousel1" role="button" data-slide="prev">
                    <span aria-hidden="true" style="margin-top: 18rem; margin-left: -14rem;">
                        <svg xmlns="http://www.w3.org/2000/svg" width="60" height="60" fill="#283747" class="bi bi-arrow-left-circle-fill" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-4.5.5a.5.5 0 0 0 0-1H5.707l2.147-2.146a.5.5 0 1 0-.708-.708l-3 3a.5.5 0 0 0 0 .708l3 3a.5.5 0 0 0 .708-.708L5.707 8.5H11.5z"/>
                        </svg>
                    </span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next position-relative" href="#carousel1" role="button" data-slide="next">
                    <span aria-hidden="true" style="margin-top: -4rem; margin-right: -212rem;">
                        <svg class="dark" xmlns="http://www.w3.org/2000/svg" width="60" height="60" fill="#283747" class="bi bi-arrow-right-circle-fill" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-11.5.5a.5.5 0 0 1 0-1h5.793L8.146 5.354a.5.5 0 1 1 .708-.708l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L10.293 8.5H4.5z"/>
                        </svg>
                    </span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
            <!--Controles de indicadores-->
            <!-- <ol class="carousel-indicators">
                <li data-target="#carousel1" fill="#283747" data-slide-to="0" class="active"></li>
                <li data-target="#carousel1" fill="#283747" data-slide-to="1"></li>
            </ol> -->
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

<script src="https://cdn.jsdelivr.net/npm/glider-js@1.7.3/glider.min.js"></script>
<script src="https://kit.fontawesome.com/2c36e9b7b1.js" crossorigin="anonymous"></script>

@tag.footer()
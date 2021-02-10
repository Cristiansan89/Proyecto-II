
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
        <div class="mt-3 ml-4 mr-4">
            <div id="carousel1" class="carousel slide" data-ride="carousel">
                <div class="carousel-item active" data-interval="25000">
                    <div class="row" id="row_margen">
                        <div class="col px-0">
                            <img src="/img/marca/7up.png" id="img_margen" alt="7up">
                            <img src="/img/marca/1882.png" id="img_margen" alt="1882">
                            <img src="/img/marca/absolut.png" id="img_margen" alt="absolut">
                            
                            <img src="/img/marca/baggio.png" id="img_margen" alt="baggio">
                            <img src="/img/marca/bagley.png" id="img_margen" alt="bagley">
                            <img src="/img/marca/bianchi.png" id="img_margen" alt="bianchi">

                            <img src="/img/marca/cif.png" id="img_margen" alt="cif">
                            <img src="/img/marca/clight.png" id="img_margen" alt="clight">
                            <img src="/img/marca/cocacola.png" id="img_margen" alt="cocacola">
                            
                            <img src="/img/marca/donvalentin.png" id="img_margen" alt="donvalentin">
                            <img src="/img/marca/doritos.png" id="img_margen" alt="doritos">
                            <img src="/img/marca/dosanclas.png" id="img_margen" alt="dosanclas">

                            <img src="/img/marca/gallo.png" id="img_margen" alt="gallo">
                            <img src="/img/marca/gancia.png" id="img_margen" alt="gancia">
                            <img src="/img/marca/gatorade.png" id="img_margen" alt="gatorade">
                            
                            <img src="/img/marca/lacampagnola.png" id="img_margen" alt="lacampagnola">
                            <img src="/img/marca/lacaroyense.png" id="img_margen" alt="lacaroyense">
                            <img src="/img/marca/lapaulina.png" id="img_margen" alt="lapaulina">
                            
                            <img src="/img/marca/maizena.png" id="img_margen" alt="maizena">
                            <img src="/img/marca/malibu.png" id="img_margen" alt="malibu">
                            <img src="/img/marca/manaos.png" id="img_margen" alt="manaos">
                        </div>
                        <div class="col px-0">
                            <img src="/img/marca/ace.png" id="img_margen" alt="ace">
                            <img src="/img/marca/aguadelasmisiones.png" id="img_margen" alt="aguadelasmisiones">
                            <img src="/img/marca/ala.png" id="img_margen" alt="ala">
                            
                            <img src="/img/marca/bic.png" id="img_margen" alt="amanda">
                            <img src="/img/marca/blancaflor.png" id="img_margen" alt="callia">
                            <img src="/img/marca/brahma.png" id="img_margen" alt="danica">

                            <img src="/img/marca/cocinero.png" id="img_margen" alt="cocinero">
                            <img src="/img/marca/colgate.png" id="img_margen" alt="colgate">
                            <img src="/img/marca/corona.png" id="img_margen" alt="corona">
                            
                            <img src="/img/marca/dove.png" id="img_margen" alt="dove">
                            <img src="/img/marca/drive.png" id="img_margen" alt="drive">
                            <img src="/img/marca/ecodelosandes.png" id="img_margen" alt="ecodelosandes">

                            <img src="/img/marca/gillete.png" id="img_margen" alt="gillete">
                            <img src="/img/marca/head&shoulders.png" id="img_margen" alt="head&shoulders">
                            <img src="/img/marca/heineken.png" id="img_margen" alt="heineken">
                            
                            <img src="/img/marca/laprovidencia.png" id="img_margen" alt="laprovidencia">
                            <img src="/img/marca/laserenisima.png" id="img_margen" alt="laserenisima">
                            <img src="/img/marca/lavirginia.png" id="img_margen" alt="lavirginia">
                            
                            <img src="/img/marca/marolio.png" id="img_margen" alt="marolio">
                            <img src="/img/marca/martini.png" id="img_margen" alt="martini">
                            <img src="/img/marca/matarazzo.png" id="img_margen" alt="matarazzo">
                        </div>
                        <div class="col px-0">
                            <img src="/img/marca/alicante.png" id="img_margen" alt="alicante">
                            <img src="/img/marca/almamora.png" id="img_margen" alt="almamora">
                            <img src="/img/marca/amanda.png" id="img_margen" alt="amanda">
                            
                            <img src="/img/marca/branca.png" id="img_margen" alt="branca">
                            <img src="/img/marca/budweiser.png" id="img_margen" alt="budweiser">
                            <img src="/img/marca/callia.png" id="img_margen" alt="callia">

                            <img src="/img/marca/cusenier.png" id="img_margen" alt="cusenier">
                            <img src="/img/marca/dada.png" id="img_margen" alt="dada">
                            <img src="/img/marca/danica.png" id="img_margen" alt="danica">
                            
                            <img src="/img/marca/elite.png" id="img_margen" alt="elite">
                            <img src="/img/marca/elvive.png" id="img_margen" alt="elvive">
                            <img src="/img/marca/estrella.png" id="img_margen" alt="estrella">

                            <img src="/img/marca/hellmanns.png" id="img_margen" alt="hellmanns">
                            <img src="/img/marca/higienol.png" id="img_margen" alt="higienol">
                            <img src="/img/marca/huggies.png" id="img_margen" alt="huggies">
                            
                            <img src="/img/marca/lays.png" id="img_margen" alt="lays">
                            <img src="/img/marca/ledesma.png" id="img_margen" alt="ledesma">
                            <img src="/img/marca/levex.png" id="img_margen" alt="levex">
                            
                            <img src="/img/marca/medianaranja.png" id="img_margen" alt="medianaranja">
                            <img src="/img/marca/milkaut.png" id="img_margen" alt="milkaut">
                            <img src="/img/marca/molinocanuelas.png" id="img_margen" alt="molinocanuelas">
                        </div>
                        <div class="col px-0">
                            <img src="/img/marca/aquarius.png" id="img_margen" alt="aquarius">
                            <img src="/img/marca/arcor.png" id="img_margen" alt="arcor">
                            <img src="/img/marca/ariel.png" id="img_margen" alt="ariel">
                            
                            <img src="/img/marca/canale.png" id="img_margen" alt="canale">
                            <img src="/img/marca/celusal.png" id="img_margen" alt="celusal">
                            <img src="/img/marca/chandon.png" id="img_margen" alt="chandon">

                            <img src="/img/marca/danone.png" id="img_margen" alt="danone">
                            <img src="/img/marca/dermaglos.png" id="img_margen" alt="dermaglos">
                            <img src="/img/marca/dogchow.png" id="img_margen" alt="dogchow">
                            
                            <img src="/img/marca/exquisita.png" id="img_margen" alt="exquisita">
                            <img src="/img/marca/fanta.png" id="img_margen" alt="fanta">
                            <img src="/img/marca/favorita.png" id="img_margen" alt="favorita">

                            <img src="/img/marca/ilolay.png" id="img_margen" alt="ilolay">
                            <img src="/img/marca/imperial.png" id="img_margen" alt="imperial">
                            <img src="/img/marca/jackdaniels.png" id="img_margen" alt="jackdaniels">
                            
                            <img src="/img/marca/lifebuoy.png" id="img_margen" alt="lifebuoy">
                            <img src="/img/marca/luchetti.png" id="img_margen" alt="luchetti">
                            <img src="/img/marca/lux.png" id="img_margen" alt="lux">
                            
                            <img src="/img/marca/monster.png" id="img_margen" alt="monster">
                            <img src="/img/marca/mortimer.png" id="img_margen" alt="mortimer">
                            <img src="/img/marca/mrmusculo.png" id="img_margen" alt="mrmusculo">
                        </div>  
                        <div class="col pl-0 pr-5 mr-5">
                            <img src="/img/marca/axe.png" id="img_margen" alt="axe">
                            <img src="/img/marca/ayudin.png" id="img_margen" alt="ayudin">
                            <img src="/img/marca/bacardi.png" id="img_margen" alt="bacardi">
                            
                            <img src="/img/marca/cheetos.png" id="img_margen" alt="cheetos">
                            <img src="/img/marca/chivasregal.png" id="img_margen" alt="chivasregal">
                            <img src="/img/marca/cica.png" id="img_margen" alt="cica">

                            <img src="/img/marca/dogui.png" id="img_margen" alt="dogui">
                            <img src="/img/marca/donfelipe.png" id="img_margen" alt="donfelipe">
                            <img src="/img/marca/donsatur.png" id="img_margen" alt="donsatur">
                            
                            <img src="/img/marca/fluidomanchester.png" id="img_margen" alt="fluidomanchester">
                            <img src="/img/marca/frizze.png" id="img_margen" alt="frizze">
                            <img src="/img/marca/fuyi.png" id="img_margen" alt="fuyi">

                            <img src="/img/marca/johnsonjohnson.png" id="img_margen" alt="johnsonjohnson">
                            <img src="/img/marca/kahlua.png" id="img_margen" alt="kahlua">
                            <img src="/img/marca/knoll.png" id="img_margen" alt="knoll">
                            
                            <img src="/img/marca/lysoform.png" id="img_margen" alt="lysoform">
                            <img src="/img/marca/maggi.png" id="img_margen" alt="maggi">
                            <img src="/img/marca/magistral.png" id="img_margen" alt="magistral">
                            
                            <img src="/img/marca/natura.png" id="img_margen" alt="natura">
                            <img src="/img/marca/nescafe.png" id="img_margen" alt="nescafe">
                            <img src="/img/marca/nestle.png" id="img_margen" alt="nestle">
                        </div> 
                    </div>
                </div>
                <div class="carousel-item" data-interval="25000">
                    <div class="row" id="row_margen">
                        <div class="col px-0">
                            <img src="/img/marca/newage.png" id="img_margen" alt="newage">
                            <img src="/img/marca/nivea.png" id="img_margen" alt="nivea">
                            <img src="/img/marca/norton.png" id="img_margen" alt="norton">
                            
                            <img src="/img/marca/poett.png" id="img_margen" alt="poett">
                            <img src="/img/marca/primicia.png" id="img_margen" alt="primicia">
                            <img src="/img/marca/pringles.png" id="img_margen" alt="pringles">

                            <img src="/img/marca/sabrositos.png" id="img_margen" alt="sabrositos">
                            <img src="/img/marca/sancor.png" id="img_margen" alt="sancor">
                            <img src="/img/marca/santaana.png" id="img_margen" alt="santaana">
                            
                            <img src="/img/marca/stellaartois.png" id="img_margen" alt="stellaartois">
                            <img src="/img/marca/sussex.png" id="img_margen" alt="sussex">
                            <img src="/img/marca/tang.png" id="img_margen" alt="tang">

                            <img src="/img/marca/wassington.png" id="img_margen" alt="wassington">
                            <img src="/img/marca/zorro.png" id="img_margen" alt="zorro">
                        </div>
                        <div class="col px-0">
                            <img src="/img/marca/off.png" id="img_margen" alt="off">
                            <img src="/img/marca/oralb.png" id="img_margen" alt="oralb">
                            <img src="/img/marca/oreo.png" id="img_margen" alt="oreo">
                            
                            <img src="/img/marca/procenex.png" id="img_margen" alt="procenex">
                            <img src="/img/marca/protex.png" id="img_margen" alt="protex">
                            <img src="/img/marca/pureza.png" id="img_margen" alt="pureza">

                            <img src="/img/marca/santaisabel.png" id="img_margen" alt="santaisabel">
                            <img src="/img/marca/santajulia.png" id="img_margen" alt="santajulia">
                            <img src="/img/marca/santelmo.png" id="img_margen" alt="santelmo">

                            <img src="/img/marca/taragui.png" id="img_margen" alt="taragui">
                            <img src="/img/marca/terma.png" id="img_margen" alt="terma">
                            <img src="/img/marca/terrabusi.png" id="img_margen" alt="terrabusi">
                        </div>
                        <div class="col px-0">
                            <img src="/img/marca/paladini.png" id="img_margen" alt="paladini">
                            <img src="/img/marca/palmolive.png" id="img_margen" alt="palmolive">
                            <img src="/img/marca/pampers.png" id="img_margen" alt="pampers">
                            
                            <img src="/img/marca/quaker.png" id="img_margen" alt="quaker">
                            <img src="/img/marca/quilmes.png" id="img_margen" alt="quilmes">
                            <img src="/img/marca/raid.png" id="img_margen" alt="raid">

                            <img src="/img/marca/schneider.png" id="img_margen" alt="schneider">
                            <img src="/img/marca/scott.png" id="img_margen" alt="scott">
                            <img src="/img/marca/sedal.png" id="img_margen" alt="sedal">
                            
                            <img src="/img/marca/tiernitos.png" id="img_margen" alt="tiernitos">
                            <img src="/img/marca/trapiche.png" id="img_margen" alt="trapiche">
                            <img src="/img/marca/tregar.png" id="img_margen" alt="tregar">
                        </div>
                        <div class="col px-0">
                            <img src="/img/marca/pantene.png" id="img_margen" alt="pantene">
                            <img src="/img/marca/pasosdelostoros.png" id="img_margen" alt="pasosdelostoros">
                            <img src="/img/marca/paty.png" id="img_margen" alt="paty">
                            
                            <img src="/img/marca/redbull.png" id="img_margen" alt="redbull">
                            <img src="/img/marca/reinharina.png" id="img_margen" alt="reinharina">
                            <img src="/img/marca/rexona.png" id="img_margen" alt="rexona">

                            <img src="/img/marca/ser.png" id="img_margen" alt="ser">
                            <img src="/img/marca/skip.png" id="img_margen" alt="skip">
                            <img src="/img/marca/skyy.png" id="img_margen" alt="skyy">
                            
                            <img src="/img/marca/veritas.png" id="img_margen" alt="veritas">
                            <img src="/img/marca/villadelsur.png" id="img_margen" alt="villadelsur">
                            <img src="/img/marca/villavicencio.png" id="img_margen" alt="villavicencio">
                        </div>  
                        <div class="col pl-0 pr-5 mr-5">
                            <img src="/img/marca/pedigree.png" id="img_margen" alt="pedigree">
                            <img src="/img/marca/pepsi.png" id="img_margen" alt="pepsi">
                            <img src="/img/marca/plusbelle.png" id="img_margen" alt="plusbelle">
                            
                            <img src="/img/marca/rik.png" id="img_margen" alt="rik">
                            <img src="/img/marca/romance.png" id="img_margen" alt="romance">
                            <img src="/img/marca/rosamonte.png" id="img_margen" alt="rosamonte">

                            <img src="/img/marca/smirnoff.png" id="img_margen" alt="smirnoff">
                            <img src="/img/marca/speed.png" id="img_margen" alt="speed">
                            <img src="/img/marca/sprite.png" id="img_margen" alt="sprite">
                            
                            <img src="/img/marca/vim.png" id="img_margen" alt="vim">
                            <img src="/img/marca/vinadelbalbo.png" id="img_margen" alt="vinadelbalbo">
                            <img src="/img/marca/vivere.png" id="img_margen" alt="vivere">
                        </div> 
                    </div>
                </div>
            </div> 
   
            <!--Controles NEXT y PREV-->
            <div >
                <a class="carousel-control-prev position-relative" href="#carousel1" role="button" data-slide="prev">
                    <span aria-hidden="true" id="flecha_left">
                        <svg xmlns="http://www.w3.org/2000/svg" id="flecha_size" fill="#283747" class="bi bi-arrow-left-circle-fill" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-4.5.5a.5.5 0 0 0 0-1H5.707l2.147-2.146a.5.5 0 1 0-.708-.708l-3 3a.5.5 0 0 0 0 .708l3 3a.5.5 0 0 0 .708-.708L5.707 8.5H11.5z"/>
                        </svg>
                    </span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next position-relative" href="#carousel1" role="button" data-slide="next">
                    <span aria-hidden="true" id="flecha_right">
                        <svg class="dark" xmlns="http://www.w3.org/2000/svg" id="flecha_size" fill="#283747" class="bi bi-arrow-right-circle-fill" viewBox="0 0 16 16">
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
                <div id="estilo_card_sesion">
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
                        <div id="boton_ingresar">
                            <button class="btn btn-primary mr-5" > Ingresar </button>
                        </div>
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
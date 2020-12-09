package gg.jte.generated;
public final class JteinicioGenerated {
	public static final String JTE_NAME = "inicio.jte";
	public static final int[] JTE_LINE_INFO = {1,1,1,1,3,3,3,5,5,57,57,57,70,70,122,122,122,135,135,182,182,188,188};
	public static void render(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, edu.unam.integrador.paginas.ModeloUsuarios modelo) {
		jteOutput.writeContent("\n");
		gg.jte.generated.tag.JteheaderGenerated.render(jteOutput, jteHtmlInterceptor);
		jteOutput.writeContent("\n<div id=\"bar_menu\">\n    ");
		if (modelo.rol.equals("admin")) {
			jteOutput.writeContent("\n        <!-- Barra de Menú Admin -->\n        <div id=\"bar_principal\">\n            <nav class=\"navbar navbar-expand-lg navbar-light bg-primary\">   \n                <div class=\"collapse navbar-collapse\" id=\"navbarSupportedContent\">\n                    <ul class=\"navbar-nav mr-auto\">\n                        <li class=\"nav-item active\">\n                            <span class=\"nav-link text-white\" href=\"/\">\n                                <svg width=\"1.5em\" height=\"1.5em\" viewBox=\"0 0 16 16\" class=\"bi bi-journal-text\" fill=\"currentColor\" xmlns=\"http://www.w3.org/2000/svg\">\n                                    <path d=\"M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2z\"/>\n                                    <path d=\"M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1z\"/>\n                                    <path fill-rule=\"evenodd\" d=\"M5 10.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z\"/>\n                                </svg>\n                            </span>\n                        </li>\n                        <li class=\"nav-item dropdown\">\n                            <a class=\"nav-link dropdown-toggle text-white font-weight-bold h5 mb-0\" href=\"#\" id=\"navbarDropdown\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\n                                Cliente\n                            </a>\n                            <div class=\"dropdown-menu bg-warning\" aria-labelledby=\"navbarDropdown\">\n                                <a class=\"dropdown-item text-dark\" href=\"/clientes\">Ver Cliente</a>\n                            </div>\n                        </li> \n                        <li class=\"nav-item dropdown\">\n                            <a class=\"nav-link dropdown-toggle text-white font-weight-bold h5 mb-0\" href=\"#\" id=\"navbarDropdown\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\n                                Producto\n                            </a>\n                            <div class=\"dropdown-menu bg-warning\" aria-labelledby=\"navbarDropdown\">\n                                <a class=\"dropdown-item text-dark\" href=\"/productos/nuevo\">Crear Producto</a>\n                                <a class=\"dropdown-item text-dark\" href=\"/productos\">Ver Producto</a>\n                            </div>\n                        </li>\n                        <li class=\"nav-item dropdown\">\n                            <a class=\"nav-link dropdown-toggle text-white font-weight-bold h5 mb-0\" href=\"#\" id=\"navbarDropdown\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\n                                Pedido\n                            </a>\n                            <div class=\"dropdown-menu bg-warning\" aria-labelledby=\"navbarDropdown\">\n                                <a class=\"dropdown-item text-dark\" href=\"/pedidos\">Ver Pedido</a>\n                            </div>\n                        </li>\n                    </ul>\n                </div>\n                <div>\n                    <table id=\"table_menu\">\n                        <tr>\n                            <td>\n                                <p class=\"text-white font-weight-bold h6 mt-1 mb-0 mt-o\" id=\"fecha\"></p>    \n                            </td>\n                            <td>\n                                <ul class=\"navbar-nav mr-auto\">\n                                    <li class=\"nav-item dropdown\">\n                                        <a class=\"nav-link dropdown-toggle text-white font-weight-bold h5 ml-2 mr-2 mb-0 mt-0 text-uppercase\" href=\"#\" id=\"navbarDropdown\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\n                                            <span>  ");
			jteOutput.setContext("span", null);
			jteOutput.writeUserContent(modelo.nick);
			jteOutput.writeContent("  </span>\n                                        </a>\n                                        <div class=\"dropdown-menu bg-danger\" aria-labelledby=\"navbarDropdown\">\n                                            <a class=\"dropdown-item text-light font-weight-bold\" href=\"/cerrar\">Cerrar Sesi&oacute;n</a>\n                                        </div>\n                                    </li>\n                                </ul>      \n                            </td>\n                        </tr>\n                    </table>\n                </div>\n            </nav>\n        </div>\n    ");
		} else if (modelo.rol.equals("cliente")) {
			jteOutput.writeContent("\n        <!-- Barra de Menú Cliente -->\n        <div id=\"bar_principal\">\n            <nav class=\"navbar navbar-expand-lg navbar-light bg-primary\">   \n                <div class=\"collapse navbar-collapse\" id=\"navbarSupportedContent\">\n                    <ul class=\"navbar-nav mr-auto\">\n                        <li class=\"nav-item active mb-0\">\n                            <span class=\"nav-link text-white\" href=\"/\">\n                                <svg width=\"1.5em\" height=\"1.5em\" viewBox=\"0 0 16 16\" class=\"bi bi-journal-text\" fill=\"currentColor\" xmlns=\"http://www.w3.org/2000/svg\">\n                                    <path d=\"M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2z\"/>\n                                    <path d=\"M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1z\"/>\n                                    <path fill-rule=\"evenodd\" d=\"M5 10.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z\"/>\n                                </svg>\n                            </span>\n                        </li>\n                        <li class=\"nav-item dropdown\">\n                            <a class=\"nav-link dropdown-toggle text-white font-weight-bold h5 mb-0\" href=\"#\" id=\"navbarDropdown\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\n                                Cliente\n                            </a>\n                            <div class=\"dropdown-menu bg-warning\" aria-labelledby=\"navbarDropdown\">\n                                <a class=\"dropdown-item text-dark\" href=\"/clientes/modificar/:id\">Editar Mis Datos</a>\n                            </div>\n                        </li> \n                        <li class=\"nav-item dropdown\">\n                            <a class=\"nav-link dropdown-toggle text-white font-weight-bold h5 mb-0\" href=\"#\" id=\"navbarDropdown\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\n                                Producto\n                            </a>\n                            <div class=\"dropdown-menu bg-warning\" aria-labelledby=\"navbarDropdown\">\n                                <a class=\"dropdown-item text-dark\" href=\"/productos\">Ver Producto</a>\n                            </div>\n                        </li>\n                        <li class=\"nav-item dropdown\">\n                            <a class=\"nav-link dropdown-toggle text-white font-weight-bold h5 mb-0\" href=\"#\" id=\"navbarDropdown\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\n                                Pedido\n                            </a>\n                            <div class=\"dropdown-menu bg-warning\" aria-labelledby=\"navbarDropdown\">\n                                <a class=\"dropdown-item text-dark\" href=\"/pedidos/crear\">Realizar Pedido</a>\n                                <a class=\"dropdown-item text-dark\" href=\"/pedidos/lista/:id\">Mis Pedido</a>\n                            </div>\n                        </li>\n                    </ul>\n                </div>\n                <div>\n                    <table id=\"table_menu\">\n                        <tr>\n                            <td>\n                                <p class=\"text-white font-weight-bold h6 mt-1 mb-0 mt-o\" id=\"fecha\"></p>    \n                            </td>\n                            <td>\n                                <ul class=\"navbar-nav mr-auto\">\n                                    <li class=\"nav-item dropdown\">\n                                        <a class=\"nav-link dropdown-toggle text-white font-weight-bold h5 ml-2 mr-2 mb-0 mt-0 text-uppercase\" href=\"#\" id=\"navbarDropdown\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\n                                            <span>  ");
			jteOutput.setContext("span", null);
			jteOutput.writeUserContent(modelo.nick);
			jteOutput.writeContent("  </span>\n                                        </a>\n                                        <div class=\"dropdown-menu bg-danger\" aria-labelledby=\"navbarDropdown\">\n                                            <a class=\"dropdown-item text-light font-weight-bold\" href=\"/cerrar\">Cerrar Sesi&oacute;n</a>\n                                        </div>\n                                    </li>\n                                </ul>      \n                            </td>\n                        </tr>\n                    </table>\n                </div>\n            </nav>\n        </div> \n    ");
		} else {
			jteOutput.writeContent("\n        <!-- Inicio de Sesión -->\n        <div id=\"bar_principal\">\n            <nav class=\"navbar navbar-expand-lg navbar-light bg-primary\">   \n                <div class=\"collapse navbar-collapse\" id=\"navbarSupportedContent\">\n                    <ul class=\"navbar-nav mr-auto\">\n                        <li class=\"nav-item \">\n                            <span class=\"nav-link text-white\" href=\"/\">\n                                <svg width=\"1.5em\" height=\"1.5em\" viewBox=\"0 0 16 16\" class=\"bi bi-journal-text\" fill=\"currentColor\" xmlns=\"http://www.w3.org/2000/svg\">\n                                    <path d=\"M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2z\"/>\n                                    <path d=\"M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1z\"/>\n                                    <path fill-rule=\"evenodd\" d=\"M5 10.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z\"/>\n                                </svg>\n                            </span>\n                        </li>\n                        <li class=\"nav-item dropdown text-center\">\n                            <a class=\"nav-link dropdown-toggle text-white font-weight-bold h5 mb-0\" href=\"#\" id=\"navbarDropdown \" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\n                                Registrarse\n                            </a>\n                            <div class=\"dropdown-menu bg-warning\" aria-labelledby=\"navbarDropdown\">\n                                <a class=\"dropdown-item text-dark\" href=\"/clientes/nuevo\">Crear Cuenta</a>\n                                <a class=\"dropdown-item text-dark\" href=\"\">Recuperar Cuenta</a>\n                            </div>\n                        </li> \n                    </ul>\n                </div>\n            </nav>\n        </div>\n        <div class=\"card\" id=\"estilo_card\"> \n            <div class=\"card-footer\">\n                <div id=\"estilo_card_form\">\n                    <h3 class=\"text-center font-weight-bold\"> Iniciar Sesi&oacute;n </h3>\n                    <br>  \n                    <form action=\"/\" method=\"post\" onsubmit=\"validarUsuario();\" class=\"text-center\">\n                        <div class=\"form-group row\">                     \n                            <label class=\"col-sm-3 col-form-label font-weight-bold\" id=\"text-size\"> Usuario </label>\n                            <input class=\"form-control col-sm-8\" type=\"text\" name=\"nick\"/>\n                        </div>\n                        <div class=\"form-group row\">                     \n                            <label class=\"col-sm-3 col-form-label font-weight-bold\" id=\"text-size\"> Contraseña </label>\n                            <input class=\"form-control col-sm-8\" type=\"password\" name=\"contrasena\"/>\n                        </div>\n                        <button class=\"btn btn-primary\"> Ingresar </button>\n                    </form>\n                </div>\n            </div>\n        </div>\n    ");
		}
		jteOutput.writeContent("\n</div>\n\n<script src=\"/js/validarUsuario.js\"></script>\n<script src=\"/js/fechaActual.js\"></script>\n\n");
		gg.jte.generated.tag.JtefooterGenerated.render(jteOutput, jteHtmlInterceptor);
	}
	public static void renderMap(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, java.util.Map<String, Object> params) {
		edu.unam.integrador.paginas.ModeloUsuarios modelo = (edu.unam.integrador.paginas.ModeloUsuarios)params.get("modelo");
		render(jteOutput, jteHtmlInterceptor, modelo);
	}
}
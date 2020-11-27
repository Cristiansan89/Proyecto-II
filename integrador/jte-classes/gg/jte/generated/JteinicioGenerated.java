package gg.jte.generated;
public final class JteinicioGenerated {
	public static final String JTE_NAME = "inicio.jte";
	public static final int[] JTE_LINE_INFO = {1,1,1,1,3,3,3,6,6,50,50,50,73,73,114,114,120,120};
	public static void render(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, edu.unam.integrador.paginas.ModeloIndex modelo) {
		jteOutput.writeContent("\r\n");
		gg.jte.generated.tag.JteheaderGenerated.render(jteOutput, jteHtmlInterceptor);
		jteOutput.writeContent("\r\n\r\n<div id=\"bar_menu\">\r\n    ");
		if (! modelo.nombreUsuario.trim().isEmpty()) {
			jteOutput.writeContent("\r\n        <!-- Barra de Menú -->\r\n        <nav class=\"navbar navbar-expand-lg navbar-light bg-primary\">   \r\n            <div class=\"collapse navbar-collapse\" id=\"navbarSupportedContent\">\r\n                <ul class=\"navbar-nav mr-auto\">\r\n                    <li class=\"nav-item active\">\r\n                        <span class=\"nav-link text-white\" href=\"/\">\r\n                            <svg width=\"1.5em\" height=\"1.5em\" viewBox=\"0 0 16 16\" class=\"bi bi-journal-text\" fill=\"currentColor\" xmlns=\"http://www.w3.org/2000/svg\">\r\n                                <path d=\"M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2z\"/>\r\n                                <path d=\"M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1z\"/>\r\n                                <path fill-rule=\"evenodd\" d=\"M5 10.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z\"/>\r\n                            </svg>\r\n                        </span>\r\n                    </li>\r\n                    <li class=\"nav-item dropdown\">\r\n                        <a class=\"nav-link dropdown-toggle text-white\" href=\"#\" id=\"navbarDropdown\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\r\n                            Cliente\r\n                        </a>\r\n                        <div class=\"dropdown-menu bg-warning\" aria-labelledby=\"navbarDropdown\">\r\n                            <a class=\"dropdown-item text-dark\" href=\"/clientes/nuevo\">Crear Cliente</a>\r\n                            <a class=\"dropdown-item text-dark\" href=\"/clientes\">Ver Cliente</a>\r\n                        </div>\r\n                    </li> \r\n                    <li class=\"nav-item dropdown\">\r\n                        <a class=\"nav-link dropdown-toggle text-white\" href=\"#\" id=\"navbarDropdown\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\r\n                            Producto\r\n                        </a>\r\n                        <div class=\"dropdown-menu bg-warning\" aria-labelledby=\"navbarDropdown\">\r\n                            <a class=\"dropdown-item text-dark\" href=\"/productos/nuevo\">Crear Producto</a>\r\n                            <a class=\"dropdown-item text-dark\" href=\"/productos\">Ver Producto</a>\r\n                        </div>\r\n                    </li>\r\n                    <li class=\"nav-item dropdown\">\r\n                        <a class=\"nav-link dropdown-toggle text-white\" href=\"#\" id=\"navbarDropdown\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\r\n                            Pedido\r\n                        </a>\r\n                        <div class=\"dropdown-menu bg-warning\" aria-labelledby=\"navbarDropdown\">\r\n                            <a class=\"dropdown-item text-dark\" href=\"/pedidos/crear\">Realizar Pedido</a>\r\n                            <a class=\"dropdown-item text-dark\" href=\"/pedidos\">Ver Pedido</a>\r\n                        </div>\r\n                    </li>\r\n                </ul>\r\n            </div>\r\n            <div> \r\n                <span><b>");
			jteOutput.setContext("b", null);
			jteOutput.writeUserContent(modelo.nombreUsuario);
			jteOutput.writeContent("</b></span><br>\r\n                <div class=\"format_fecha font-weight-bold\">\r\n                    <p id=\"dia\">\r\n                        <p>/\r\n                            <p id=\"mes\" class=\"mes\">\r\n                                <p>/\r\n                                    <p id=\"anio\" class=\"anio\"></p>\r\n                                </p>\r\n                            </p>\r\n                        </p>\r\n                    </p>\r\n                </div>\r\n            </div>\r\n        </nav>\r\n            <!-- Tarjeta de Publicidad -->\r\n            <!-- <div >\r\n            <div class=\"card\" style=\"width: 18rem;\">\r\n                <img src=\"...\" class=\"card-img-top\" alt=\"...\">\r\n                <div class=\"card-body\">\r\n                    <p class=\"card-text\">Some quick example text to build on the card title and make up the bulk of the card's content.</p>\r\n                </div>\r\n            </div>\r\n        </div> -->\r\n    ");
		} else {
			jteOutput.writeContent("\r\n        <!-- Inicio de Sesión -->\r\n        <div id=\"bar_principal\">\r\n            <nav class=\"navbar navbar-expand-lg navbar-light bg-primary\">   \r\n                <div class=\"collapse navbar-collapse\" id=\"navbarSupportedContent\">\r\n                    <ul class=\"navbar-nav mr-auto\">\r\n                        <li class=\"nav-item \">\r\n                            <span class=\"nav-link text-white\" href=\"/\">\r\n                                <svg width=\"1.5em\" height=\"1.5em\" viewBox=\"0 0 16 16\" class=\"bi bi-journal-text\" fill=\"currentColor\" xmlns=\"http://www.w3.org/2000/svg\">\r\n                                    <path d=\"M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2z\"/>\r\n                                    <path d=\"M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1z\"/>\r\n                                    <path fill-rule=\"evenodd\" d=\"M5 10.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z\"/>\r\n                                </svg>\r\n                            </span>\r\n                        </li>\r\n                        <li class=\"nav-item dropdown text-center\">\r\n                            <a class=\"nav-link dropdown-toggle text-white\" href=\"#\" id=\"navbarDropdown\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\r\n                                Registrarse\r\n                            </a>\r\n                            <div class=\"dropdown-menu bg-warning\" aria-labelledby=\"navbarDropdown\">\r\n                                <a class=\"dropdown-item text-dark\" href=\"\">Crear Cuenta</a>\r\n                                <a class=\"dropdown-item text-dark\" href=\"\">Recuperar Cuenta</a>\r\n                            </div>\r\n                        </li> \r\n                    </ul>\r\n                </div>\r\n            </nav>\r\n        </div>\r\n        <div class=\"card\" style=\"width: 33rem; top: 5rem; left: 45rem; \"> \r\n            <div class=\"card-body\">\r\n                <h3 class=\"text-center\"><b>Iniciar Sesi&oacute;n</b></h3>\r\n                <br>  \r\n                <form action=\"/\" method=\"post\" onsubmit=\"validarUsuario();\" class=\"text-center\">\r\n                    <div class=\"form-group row\">                     \r\n                            <label class=\"col-sm-5 col-form-label font-weight-bold\"> Usuario </label>\r\n                        <input class=\"form-control col-sm-6\" type=\"text\" placeholder=\"nombre del usuario\" id=\"nombreUsuario\" name=\"nombreUsuario\"/>\r\n                    </div>\r\n                    <button class=\"btn btn-primary\"> Ingresar </button>\r\n                </form>\r\n            </div>\r\n        </div>\r\n    ");
		}
		jteOutput.writeContent("\r\n</div>\r\n\r\n<script src=\"/js/validarUsuario.js\"></script>\r\n<script src=\"/js/fecha.js\"></script>\r\n\r\n");
		gg.jte.generated.tag.JtefooterGenerated.render(jteOutput, jteHtmlInterceptor);
	}
	public static void renderMap(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, java.util.Map<String, Object> params) {
		edu.unam.integrador.paginas.ModeloIndex modelo = (edu.unam.integrador.paginas.ModeloIndex)params.get("modelo");
		render(jteOutput, jteHtmlInterceptor, modelo);
	}
}

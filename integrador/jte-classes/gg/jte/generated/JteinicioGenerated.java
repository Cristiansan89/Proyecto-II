package gg.jte.generated;
public final class JteinicioGenerated {
	public static final String JTE_NAME = "inicio.jte";
	public static final int[] JTE_LINE_INFO = {0,0,0,0,2,2,2,5,5,35,35,35,39,39,47,47,51,51};
	public static void render(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, edu.unam.integrador.paginas.ModeloIndex modelo) {
		jteOutput.writeContent("\n");
		gg.jte.generated.tag.JteheaderGenerated.render(jteOutput, jteHtmlInterceptor);
		jteOutput.writeContent("\n\n<div id=\"bar_menu\">\n    ");
		if (! modelo.nombreUsuario.trim().isEmpty()) {
			jteOutput.writeContent("\n        <nav class=\"navbar navbar-expand-lg navbar-light bg-primary\">   \n            <div class=\"collapse navbar-collapse\" id=\"navbarSupportedContent\">\n                <ul class=\"navbar-nav mr-auto\">\n                    <li class=\"nav-item active\">\n                        <a class=\"nav-link text-white\" href=\"/inicio\">Inicio</a>\n                    </li>\n                    <li class=\"nav-item dropdown\">\n                        <a class=\"nav-link dropdown-toggle text-white\" href=\"#\" id=\"navbarDropdown\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\n                            Cliente\n                        </a>\n                        <div class=\"dropdown-menu bg-warning\" aria-labelledby=\"navbarDropdown\">\n                            <a class=\"dropdown-item text-dark\" href=\"/crearCliente\">Crear Cliente</a>\n                            <a class=\"dropdown-item text-dark\" href=\"/editarCliente\">Editar Cliente</a>\n                            <a class=\"dropdown-item text-dark\" href=\"/clientes\">Ver Cliente</a>\n                        </div>\n                    </li> \n                    <li class=\"nav-item dropdown\">\n                        <a class=\"nav-link dropdown-toggle text-white\" href=\"#\" id=\"navbarDropdown\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\n                            Producto\n                        </a>\n                        <div class=\"dropdown-menu bg-warning\" aria-labelledby=\"navbarDropdown\">\n                            <a class=\"dropdown-item text-dark\" href=\"/crearProducto\">Crear Producto</a>\n                            <a class=\"dropdown-item text-dark\" href=\"/editarProducto\">Editar Producto</a>\n                            <a class=\"dropdown-item text-dark\" href=\"/productos\">Ver Producto</a>\n                        </div>\n                    </li>\n                </ul>\n            </div>\n            <div>\n                <span>");
			jteOutput.setContext("span", null);
			jteOutput.writeUserContent(modelo.nombreUsuario);
			jteOutput.writeContent("</span><br>\n                <span>12/12/20</span>\n            </div>\n        </nav>\n    ");
		} else {
			jteOutput.writeContent("\n        <form action=\"/\" method=\"post\" onsubmit=\"validarUsuario();\">\n        <div class=\"form-group row\">\n                <label class=\"col-sm-2 col-form-label\"> Usuario </label>\n                <input class=\"form-control col-sm-4\" type=\"text\" placeholder=\"nombre del usuario\" id=\"nombreUsuario\" name=\"nombreUsuario\"/>\n            </div>\n            <button class=\"btn btn-primary\"> Ingresar </button>\n        </form>\n    ");
		}
		jteOutput.writeContent("\n</div>\n<script src=\"/js/validarUsuario.js\"></script>\n\n");
		gg.jte.generated.tag.JtefooterGenerated.render(jteOutput, jteHtmlInterceptor);
	}
	public static void renderMap(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, java.util.Map<String, Object> params) {
		edu.unam.integrador.paginas.ModeloIndex modelo = (edu.unam.integrador.paginas.ModeloIndex)params.get("modelo");
		render(jteOutput, jteHtmlInterceptor, modelo);
	}
}

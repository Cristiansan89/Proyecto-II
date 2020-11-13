package gg.jte.generated;
public final class JteinicioGenerated {
	public static final String JTE_NAME = "inicio.jte";
	public static final int[] JTE_LINE_INFO = {0,0,0,0,2,2,2,5,5,41,41,41,46,46,54,54,58,58};
	public static void render(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, edu.unam.integrador.paginas.ModeloIndex modelo) {
		jteOutput.writeContent("\r\n");
		gg.jte.generated.tag.JteheaderGenerated.render(jteOutput, jteHtmlInterceptor);
		jteOutput.writeContent("\r\n\r\n<div id=\"bar_menu\">\r\n  ");
		if (! modelo.nombreUsuario.trim().isEmpty()) {
			jteOutput.writeContent("\r\n    <nav class=\"navbar navbar-expand-sm navbar-dark bg-info\">\r\n      <div class=\"collapse navbar-collapse\" id=\"navbarSupportedContent\">\r\n        <ul class=\"navbar-nav mr-auto\">\r\n          <li class=\"nav-item active\">\r\n            <a class=\"nav-link\" href=\"/inicio\">Inicio</a>\r\n          </li>\r\n          <li class=\"nav-item dropdown\">\r\n             <a class=\"nav-link dropdown-toggle\" href=\"#\" id=\"navbarDropdown\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\r\n              Cliente\r\n            </a>\r\n            <div class=\"dropdown-menu\" aria-labelledby=\"navbardropdown\">\r\n              <a class=\"dropdown-item\" href=\"/cliente\">Ver Clientes</a>\r\n              <a class=\"dropdown-item\" href=\"/cliente/nuevo\">Agregar Cliente</a>\r\n            </div>\r\n          </li>\r\n          <li class=\"nav-item dropdown\">\r\n            <a class=\"nav-link dropdown-toggle\" href=\"#\" id=\"navbarDropdown\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\r\n              Producto\r\n            </a>\r\n            <div class=\"dropdown-menu\" aria-labelledby=\"navbarProducto\">\r\n              <a class=\"dropdown-item\" href=\"/producto\">Ver Producto</a>\r\n              <a class=\"dropdown-item\" href=\"/producto/nuevo\">Agregar Producto</a>\r\n            </div>\r\n          </li>\r\n          <li class=\"nav-item dropdown\">\r\n            <a class=\"nav-link dropdown-toggle\" href=\"#\" id=\"navbarDropdownMenuLink\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\r\n              Dropdown link\r\n            </a>\r\n            <div class=\"dropdown-menu\" aria-labelledby=\"navbarDropdownMenuLink\">\r\n              <a class=\"dropdown-item\" href=\"#\">Action</a>\r\n              <a class=\"dropdown-item\" href=\"#\">Another action</a>\r\n              <a class=\"dropdown-item\" href=\"#\">Something else here</a>\r\n            </div>\r\n          </li>\r\n          <li class=\"nav-item\" align=\"right\">\r\n            <div id=\"user_text\"><b> ");
			jteOutput.setContext("b", null);
			jteOutput.writeUserContent(modelo.nombreUsuario);
			jteOutput.writeContent("! </b></div>\r\n          </li>\r\n        </ul>\r\n      </div>\r\n    </nav>\r\n  ");
		} else {
			jteOutput.writeContent("\r\n    <form action=\"/\" method=\"post\" onsubmit=\"validarUsuario();\">\r\n      <div class=\"form-group row\">\r\n              <label class=\"col-sm-2 col-form-label\"> Usuario </label>\r\n              <input class=\"form-control col-sm-4\" type=\"text\" placeholder=\"nombre del usuario\" id=\"nombreUsuario\" name=\"nombreUsuario\"/>\r\n          </div>\r\n          <button class=\"btn btn-primary\"> Ingresar </button>\r\n    </form>\r\n  ");
		}
		jteOutput.writeContent("\r\n</div>\r\n<script src=\"/js/validarUsuario.js\"></script>\r\n\r\n");
		gg.jte.generated.tag.JtefooterGenerated.render(jteOutput, jteHtmlInterceptor);
	}
	public static void renderMap(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, java.util.Map<String, Object> params) {
		edu.unam.integrador.paginas.ModeloIndex modelo = (edu.unam.integrador.paginas.ModeloIndex)params.get("modelo");
		render(jteOutput, jteHtmlInterceptor, modelo);
	}
}

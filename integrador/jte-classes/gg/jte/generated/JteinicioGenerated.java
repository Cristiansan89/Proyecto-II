package gg.jte.generated;
public final class JteinicioGenerated {
	public static final String JTE_NAME = "inicio.jte";
	public static final int[] JTE_LINE_INFO = {0,0,0,0,2,2,2,4,4,6,6,6,29,29,37,37,41,41};
	public static void render(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, edu.unam.integrador.paginas.ModeloIndex modelo) {
		jteOutput.writeContent("\r\n");
		gg.jte.generated.tag.JteheaderGenerated.render(jteOutput, jteHtmlInterceptor);
		jteOutput.writeContent("\r\n\r\n");
		if (! modelo.nombreUsuario.trim().isEmpty()) {
			jteOutput.writeContent("\r\n  <h2>Distribuidora</h2>\r\n  <h1><b> ");
			jteOutput.setContext("b", null);
			jteOutput.writeUserContent(modelo.nombreUsuario);
			jteOutput.writeContent("! </b></h1>\r\n  <nav class=\"navbar navbar-expand-sm navbar-dark bg-info\">\r\n    <a class=\"navbar-brand\" href=\"Inicio\">Inicio</a>\r\n    <button class=\"navbar-toggler\" type=\"button\" data-toggle=\"collapse\" data-target=\"#navbarNavAltMarkup\" aria-controls=\"navbarNavAltMarkup\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">\r\n      <span class=\"navbar-toggler-icon\"></span>\r\n    </button>\r\n    <div class=\"collapse navbar-collapse\" id=\"navbarNavAltMarkup\">\r\n      <div class=\"navbar-nav\">\r\n        <a class=\"nav-link active \" href=\"Cliente\">Cliente <span class=\"sr-only\">(current)</span></a>\r\n        <a class=\"nav-link\" href=\"Producto\">Producto </a>\r\n      </div>\r\n    </div>\r\n    <div>\r\n      <ul class=\"navbar-nav\">\r\n            <li class=\"nav-item\">\r\n                <a class=\"navbar-brand\" href=\"/clientes\"> Ver clientes </a>\r\n            </li>\r\n            <li class=\"nav-item\">\r\n                <a class=\"navbar-brand\" href=\"/clientes/nuevo\"> Agregar cliente </a>\r\n            </li>\r\n        </ul>\r\n    </div>\r\n  </nav>\r\n");
		} else {
			jteOutput.writeContent("\r\n  <form action=\"/\" method=\"post\" onsubmit=\"validarUsuario();\">\r\n     <div class=\"form-group row\">\r\n            <label class=\"col-sm-2 col-form-label\"> Usuario </label>\r\n            <input class=\"form-control col-sm-4\" type=\"text\" placeholder=\"nombre del usuario\" id=\"nombreUsuario\" name=\"nombreUsuario\"/>\r\n        </div>\r\n        <button class=\"btn btn-primary\"> Ingresar </button>\r\n  </form>\r\n");
		}
		jteOutput.writeContent("\r\n\r\n<script src=\"/js/validarUsuario.js\"></script>\r\n\r\n");
		gg.jte.generated.tag.JtefooterGenerated.render(jteOutput, jteHtmlInterceptor);
	}
	public static void renderMap(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, java.util.Map<String, Object> params) {
		edu.unam.integrador.paginas.ModeloIndex modelo = (edu.unam.integrador.paginas.ModeloIndex)params.get("modelo");
		render(jteOutput, jteHtmlInterceptor, modelo);
	}
}

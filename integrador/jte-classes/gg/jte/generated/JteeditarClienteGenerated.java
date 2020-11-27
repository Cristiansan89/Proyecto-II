package gg.jte.generated;
public final class JteeditarClienteGenerated {
	public static final String JTE_NAME = "editarCliente.jte";
	public static final int[] JTE_LINE_INFO = {0,0,0,0,2,2,2,9,9,9,13,13,13,19,19,19,25,25,25,31,31,31,37,37,37,49,49};
	public static void render(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, edu.unam.integrador.paginas.ModeloCliente modelo) {
		jteOutput.writeContent("\r\n");
		gg.jte.generated.tag.JteheaderGenerated.render(jteOutput, jteHtmlInterceptor);
		jteOutput.writeContent("\r\n\r\n<div class=\"card\" style=\"width: 42rem; top: 7rem; left: 40rem; margin-bottom: 10rem;\"> \r\n    <div class=\"card-footer\">\r\n        <div style=\"margin-left: 3rem;\">\r\n            <h2><b>Editar Cliente</b></h2>\r\n            <br>\r\n            <form action=\"/clientes/actualizar/");
		jteOutput.setContext("form", "action");
		jteOutput.writeUserContent(modelo.cliente.getIdCliente());
		jteOutput.writeContent("\" method=\"post\">\r\n                <label for=\"nombre\" class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Nombre</label>\r\n                <div class=\"form-group row\">\r\n                    <div class=\"col-sm-10\">\r\n                        <input class=\"form-control\" type=\"text\" name=\"nombre\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.cliente.getNombre());
		jteOutput.writeContent("\"/>\r\n                    </div>\r\n                </div>\r\n                <label for=\"apellido\" class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Apellido</label>\r\n                <div class=\"form-group row\">\r\n                    <div class=\"col-sm-10\">\r\n                        <input class=\"form-control\" type=\"text\" name=\"apellido\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.cliente.getApellido());
		jteOutput.writeContent("\"/>\r\n                    </div>\r\n                </div>\r\n                <label for=\"cuil\" class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Cuil</label>\r\n                <div class=\"form-group row\">\r\n                    <div class=\"col-sm-10\">\r\n                        <input class=\"form-control\" type=\"number\" name=\"cuil\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.cliente.getCuil());
		jteOutput.writeContent("\"/>\r\n                    </div>\r\n                </div>\r\n                <label for=\"domicilio\" class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Domicilio</label>\r\n                <div class=\"form-group row\">\r\n                    <div class=\"col-sm-10\">\r\n                        <input class=\"form-control\" type=\"text\" name=\"domicilio\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.cliente.getDomicilio());
		jteOutput.writeContent("\"/>\r\n                    </div>\r\n                </div>\r\n                <label for=\"telefono\" class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Tel&eacute;fono</label>\r\n                <div class=\"form-group row\">\r\n                    <div class=\"col-sm-10\">\r\n                        <input class=\"form-control\" type=\"text\" name=\"telefono\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.cliente.getTelefono());
		jteOutput.writeContent("\"/>\r\n                    </div>\r\n                </div>\r\n                <div class=\"text-center\" style=\"margin-right: 4em;\">\r\n                    <button type=\"submit\" class=\"btn btn-primary\"> Modificar </button>\r\n                    <a href=\"/\" type=\"button\" class=\"btn btn-primary\"> Volver </a>\r\n                </div>\r\n            </form>\r\n        </div>\r\n    </div>\r\n</div>\r\n\r\n");
		gg.jte.generated.tag.JtefooterGenerated.render(jteOutput, jteHtmlInterceptor);
	}
	public static void renderMap(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, java.util.Map<String, Object> params) {
		edu.unam.integrador.paginas.ModeloCliente modelo = (edu.unam.integrador.paginas.ModeloCliente)params.get("modelo");
		render(jteOutput, jteHtmlInterceptor, modelo);
	}
}

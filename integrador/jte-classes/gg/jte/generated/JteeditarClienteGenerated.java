package gg.jte.generated;
public final class JteeditarClienteGenerated {
	public static final String JTE_NAME = "editarCliente.jte";
	public static final int[] JTE_LINE_INFO = {0,0,0,0,2,2,2,11,11,11,15,15,15,21,21,21,27,27,27,33,33,33,39,39,39,51,51};
	public static void render(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, edu.unam.integrador.paginas.ModeloCliente modelo) {
		jteOutput.writeContent("\r\n");
		gg.jte.generated.tag.JteheaderGenerated.render(jteOutput, jteHtmlInterceptor);
		jteOutput.writeContent("\r\n\r\n<h2>Cliente</h2>\r\n\r\n<div class=\"card\" style=\"width: 42rem; top: 7rem; left: 40rem;\"> \r\n    <div class=\"card-footer\">\r\n        <div style=\"margin-left: 3em; \">\r\n            <h2><b>Editar Cliente</b></h2>\r\n            <br>\r\n            <form action=\"/clientes/actualizar/");
		jteOutput.setContext("form", "action");
		jteOutput.writeUserContent(modelo.cliente.getIdCliente());
		jteOutput.writeContent("\" method=\"post\">\r\n                <div class=\"form-group row\">\r\n                    <label for=\"nombre\" class=\"col-sm-2 col-form-label font-weight-bold\"> Nombre </label>\r\n                    <div class=\"col-sm-8\">\r\n                        <input class=\"form-control\" type=\"text\" name=\"nombre\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.cliente.getNombre());
		jteOutput.writeContent("\"/>\r\n                    </div>\r\n                </div>\r\n                    <div class=\"form-group row\">\r\n                    <label for=\"apellido\" class=\"col-sm-2 col-form-label font-weight-bold\"> Apellido </label>\r\n                    <div class=\"col-sm-8\">\r\n                        <input class=\"form-control\" type=\"text\" name=\"apellido\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.cliente.getApellido());
		jteOutput.writeContent("\"/>\r\n                    </div>\r\n                </div>\r\n                    <div class=\"form-group row\">\r\n                    <label for=\"cuil\" class=\"col-sm-2 col-form-label font-weight-bold\"> CUIL </label>\r\n                    <div class=\"col-sm-8\">\r\n                        <input class=\"form-control\" type=\"number\" name=\"cuil\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.cliente.getCuil());
		jteOutput.writeContent("\"/>\r\n                    </div>\r\n                </div>\r\n                    <div class=\"form-group row\">\r\n                    <label for=\"domicilio\" class=\"col-sm-2 col-form-label font-weight-bold\"> Domicilio </label>\r\n                    <div class=\"col-sm-8\">\r\n                        <input class=\"form-control\" type=\"text\" name=\"domicilio\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.cliente.getDomicilio());
		jteOutput.writeContent("\"/>\r\n                    </div>\r\n                </div>\r\n                <div class=\"form-group row\">\r\n                    <label for=\"telefono\" class=\"col-sm-2 col-form-label font-weight-bold\"> Telefono</label>\r\n                    <div class=\"col-sm-8\">\r\n                        <input class=\"form-control\" type=\"number\" name=\"telefono\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.cliente.getTelefono());
		jteOutput.writeContent("\"/>\r\n                    </div>\r\n                </div>\r\n                <div class=\"text-center\">\r\n                    <button type=\"submit\" class=\"btn btn-primary\"> Modificar </button>\r\n                    \r\n                </div>\r\n            </form>\r\n        </div>\r\n    </div>\r\n</div>\r\n\r\n");
		gg.jte.generated.tag.JtefooterGenerated.render(jteOutput, jteHtmlInterceptor);
	}
	public static void renderMap(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, java.util.Map<String, Object> params) {
		edu.unam.integrador.paginas.ModeloCliente modelo = (edu.unam.integrador.paginas.ModeloCliente)params.get("modelo");
		render(jteOutput, jteHtmlInterceptor, modelo);
	}
}

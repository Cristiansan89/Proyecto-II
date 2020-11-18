package gg.jte.generated;
public final class JteeditarClienteGenerated {
	public static final String JTE_NAME = "editarCliente.jte";
	public static final int[] JTE_LINE_INFO = {0,0,0,0,2,2,2,15,15,15,21,21,21,27,27,27,33,33,33,39,39,39,51,51};
	public static void render(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, edu.unam.integrador.paginas.ModeloCliente modelo) {
		jteOutput.writeContent("\n");
		gg.jte.generated.tag.JteheaderGenerated.render(jteOutput, jteHtmlInterceptor);
		jteOutput.writeContent("\n\n<h2>Cliente</h2>\n\n<div class=\"card\" style=\"width: 42rem; top: 7rem; left: 40rem;\"> \n    <div class=\"card-footer\">\n        <div style=\"margin-left: 3em; \">\n            <h2><b>Editar Cliente</b></h2>\n            <br>\n            <form action=\"/clientes\" method=\"post\">\n                <div class=\"form-group row\">\n                    <label for=\"nombre\" class=\"col-sm-2 col-form-label font-weight-bold\"> Nombre </label>\n                    <div class=\"col-sm-8\">\n                        <input class=\"form-control\" type=\"text\" name=\"nombre\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.cliente.getNombre());
		jteOutput.writeContent("\"/>\n                    </div>\n                </div>\n                    <div class=\"form-group row\">\n                    <label for=\"apellido\" class=\"col-sm-2 col-form-label font-weight-bold\"> Apellido </label>\n                    <div class=\"col-sm-8\">\n                        <input class=\"form-control\" type=\"text\" name=\"apellido\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.cliente.getApellido());
		jteOutput.writeContent("\"/>\n                    </div>\n                </div>\n                    <div class=\"form-group row\">\n                    <label for=\"cuil\" class=\"col-sm-2 col-form-label font-weight-bold\"> CUIL </label>\n                    <div class=\"col-sm-8\">\n                        <input class=\"form-control\" type=\"number\" name=\"cuil\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.cliente.getCuil());
		jteOutput.writeContent("\"/>\n                    </div>\n                </div>\n                    <div class=\"form-group row\">\n                    <label for=\"domicilio\" class=\"col-sm-2 col-form-label font-weight-bold\"> Domicilio </label>\n                    <div class=\"col-sm-8\">\n                        <input class=\"form-control\" type=\"text\" name=\"domicilio\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.cliente.getDomicilio());
		jteOutput.writeContent("\"/>\n                    </div>\n                </div>\n                <div class=\"form-group row\">\n                    <label for=\"telefono\" class=\"col-sm-2 col-form-label font-weight-bold\"> Telefono</label>\n                    <div class=\"col-sm-8\">\n                        <input class=\"form-control\" type=\"number\" name=\"telefono\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.cliente.getTelefono());
		jteOutput.writeContent("\"/>\n                    </div>\n                </div>\n                <div class=\"text-center\">\n                    <button type=\"submit\" class=\"btn btn-primary\"> Modificar </button>\n                    <a href=\"/clientes\" type=\"button\" class=\"btn btn-secondary\"> Volver </a>\n                </div>\n            </form>\n        </div>\n    </div>\n</div>\n\n");
		gg.jte.generated.tag.JtefooterGenerated.render(jteOutput, jteHtmlInterceptor);
	}
	public static void renderMap(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, java.util.Map<String, Object> params) {
		edu.unam.integrador.paginas.ModeloCliente modelo = (edu.unam.integrador.paginas.ModeloCliente)params.get("modelo");
		render(jteOutput, jteHtmlInterceptor, modelo);
	}
}

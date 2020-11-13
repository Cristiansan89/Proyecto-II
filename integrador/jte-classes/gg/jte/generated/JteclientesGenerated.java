package gg.jte.generated;
public final class JteclientesGenerated {
	public static final String JTE_NAME = "clientes.jte";
	public static final int[] JTE_LINE_INFO = {0,0,0,0,2,2,2,19,19,21,21,21,22,22,22,23,23,23,24,24,24,25,25,25,26,26,26,27,27,27,29,29,36,36};
	public static void render(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, edu.unam.integrador.paginas.ModeloClientes modelo) {
		jteOutput.writeContent("\r\n");
		gg.jte.generated.tag.JteheaderGenerated.render(jteOutput, jteHtmlInterceptor);
		jteOutput.writeContent("\r\n    <h2>Clientes</h2>\r\n    \r\n    <div class=\"table-responsive\">\r\n        <table class=\"table table-hover table-striped\">\r\n            <thead>\r\n                <tr>\r\n                    <th>ID Cliente</th>\r\n                    <th >Nombre</th>\r\n                    <th >Cuil</th>\r\n                    <th>Domicilio</th>\r\n                    <th >Telefono</th>\r\n                    <th > </th>\r\n                    <th > </th>\r\n                </tr>\r\n            </thead>\r\n            <tbody>\r\n                ");
		for (var cliente : modelo.clientes) {
			jteOutput.writeContent("\r\n                    <tr>\r\n                        <td >");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(cliente.getIdCliente());
			jteOutput.writeContent("</td>\r\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(cliente.getNombre());
			jteOutput.writeContent("</td>\r\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(cliente.getCuil());
			jteOutput.writeContent("</td>\r\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(cliente.getDomicilio());
			jteOutput.writeContent("</td>\r\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(cliente.getTelefono());
			jteOutput.writeContent("</td>\r\n                        <td > <a style=\"float: left;\" type=\"button\" class=\"btn btn-info no-gutters\" href=\"clientes/editar/");
			jteOutput.setContext("a", "href");
			jteOutput.writeUserContent(cliente.getIdCliente());
			jteOutput.writeContent("\"> Editar </a></td>                            \r\n                        <td > <a style=\"float: left;\"  type=\"button\" class=\"btn btn-danger no-gutters\"  href=\"cliente/");
			jteOutput.setContext("a", "href");
			jteOutput.writeUserContent(cliente.getIdCliente());
			jteOutput.writeContent("/borrar\" >Eliminar</a>  </td>\r\n                    </tr>\r\n                ");
		}
		jteOutput.writeContent("\r\n            </tbody>\r\n        </table>\r\n    </div>\r\n    <a href=\"/\" style=\"float: right;\" type=\"button\" class=\"btn btn-primary\"> Volver </a>\r\n\r\n\r\n");
		gg.jte.generated.tag.JtefooterGenerated.render(jteOutput, jteHtmlInterceptor);
	}
	public static void renderMap(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, java.util.Map<String, Object> params) {
		edu.unam.integrador.paginas.ModeloClientes modelo = (edu.unam.integrador.paginas.ModeloClientes)params.get("modelo");
		render(jteOutput, jteHtmlInterceptor, modelo);
	}
}

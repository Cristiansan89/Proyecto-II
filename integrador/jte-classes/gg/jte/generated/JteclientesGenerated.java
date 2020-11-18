package gg.jte.generated;
public final class JteclientesGenerated {
	public static final String JTE_NAME = "clientes.jte";
	public static final int[] JTE_LINE_INFO = {0,0,0,0,2,2,2,21,21,23,23,23,24,24,24,25,25,25,26,26,26,27,27,27,28,28,28,29,29,29,30,30,30,32,32,41,41};
	public static void render(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, edu.unam.integrador.paginas.ModeloClientes modelo) {
		jteOutput.writeContent("\n");
		gg.jte.generated.tag.JteheaderGenerated.render(jteOutput, jteHtmlInterceptor);
		jteOutput.writeContent("\n\n<div style=\"margin-top: 6em; margin-left: 15em; margin-right: 15em;\">\n    <h2><b>Clientes</b></h2>\n    <div class=\"table-responsive\">\n        <table class=\"table table-hover table-striped\">\n            <thead>\n                <tr>  \n                    <th>ID Cliente</th>\n                    <th>Nombre</th>\n                    <th>Apellido</th>\n                    <th>Cuil</th>\n                    <th>Domicilio</th>\n                    <th>Tel&eacute;fono</th>\n                    <th> </th>\n                    <th> </th>\n                </tr>\n            </thead>\n            <tbody>\n                ");
		for (var cliente : modelo.clientes) {
			jteOutput.writeContent("\n                    <tr>\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(cliente.getIdCliente());
			jteOutput.writeContent("</td>\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(cliente.getNombre());
			jteOutput.writeContent("</td>\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(cliente.getApellido());
			jteOutput.writeContent("</td>\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(cliente.getCuil());
			jteOutput.writeContent("</td>\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(cliente.getDomicilio());
			jteOutput.writeContent("</td>\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(cliente.getTelefono());
			jteOutput.writeContent("</td>\n                        <td> <a type=\"button\" class=\"btn btn-info no-gutters\" href=\"/clientes/");
			jteOutput.setContext("a", "href");
			jteOutput.writeUserContent(cliente.getIdCliente());
			jteOutput.writeContent("\"> Editar </a></td>\n                        <td> <button type=\"button\" class=\"btn btn-danger no-gutters\" onClick=\"borrar(");
			jteOutput.setContext("button", "onClick");
			jteOutput.writeUserContent(cliente.getIdCliente());
			jteOutput.writeContent(")\"> Eliminar </button></td>\n                    </tr>\n                ");
		}
		jteOutput.writeContent("\n            </tbody>\n        </table>\n    </div>\n    <a href=\"/\" style=\"float: right;\" type=\"button\" class=\"btn btn-primary\"> Volver </a>\n</div>\n\n<script src=\"/js/cliente.js\"></script>\n\n");
		gg.jte.generated.tag.JtefooterGenerated.render(jteOutput, jteHtmlInterceptor);
	}
	public static void renderMap(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, java.util.Map<String, Object> params) {
		edu.unam.integrador.paginas.ModeloClientes modelo = (edu.unam.integrador.paginas.ModeloClientes)params.get("modelo");
		render(jteOutput, jteHtmlInterceptor, modelo);
	}
}

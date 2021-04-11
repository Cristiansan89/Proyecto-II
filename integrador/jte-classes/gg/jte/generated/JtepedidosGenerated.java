package gg.jte.generated;
public final class JtepedidosGenerated {
	public static final String JTE_NAME = "pedidos.jte";
	public static final int[] JTE_LINE_INFO = {0,0,0,0,2,2,2,23,23,25,25,25,26,26,26,27,27,27,28,28,28,29,29,29,30,30,30,31,31,31,32,32,33,33,33,34,34,35,35,35,36,36,38,38,40,40,51,51};
	public static void render(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, edu.unam.integrador.paginas.ModeloPedidos modelo) {
		jteOutput.writeContent("\n");
		gg.jte.generated.tag.JteheaderGenerated.render(jteOutput, jteHtmlInterceptor);
		jteOutput.writeContent("\n<br>\n\n<div id=\"estilo_list\">\n    <h2><b>Lista de Pedido</b></h2>\n    <br>\n    <div class=\"table-responsive\">\n        <table class=\"table table-hover table-striped\">\n            <thead>\n                <tr>  \n                    <th>ID</th>\n                    <th>Fecha</th>\n                    <th>Hora</th>\n                    <th>Estado</th>\n                    <th>Condici&oacute;n</th>\n                    <th>Total a Pagar</th>\n                    <th> </th>\n                    <th> </th>\n                </tr>\n            </thead>\n            <tbody>\n            ");
		for (var pedido : modelo.pedidos) {
			jteOutput.writeContent("\n                <tr>\n                    <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(pedido.getIdPedido());
			jteOutput.writeContent("</td>\n                    <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(pedido.formatoFecha(pedido.getFecha()));
			jteOutput.writeContent("</td>\n                    <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(pedido.getHora());
			jteOutput.writeContent("</td>\n                    <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(pedido.tipoEstadoStr());
			jteOutput.writeContent("</td>\n                    <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(pedido.getCondicion());
			jteOutput.writeContent("</td>\n                    <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(pedido.stringTotalPagar());
			jteOutput.writeContent("</td> \n                    <td> <a type=\"button\" class=\"btn btn-success no-gutters\" href=\"/pedidos/listadetalle/");
			jteOutput.setContext("a", "href");
			jteOutput.writeUserContent(pedido.getIdPedido());
			jteOutput.writeContent("\"> Ver </a></td>    \n                    ");
			if ((modelo.rol.equals("admin")) && (pedido.getCondicion().equals("En Espera"))) {
				jteOutput.writeContent("\n                        <td> <a type=\"button\" class=\"btn btn-info no-gutters\" href=\"/pedidos/entregado/");
				jteOutput.setContext("a", "href");
				jteOutput.writeUserContent(pedido.getIdPedido());
				jteOutput.writeContent("\"> Entregado </a></td>    \n                    ");
			} else if ((modelo.rol.equals("cliente")) && (pedido.getCondicion().equals("En Espera"))) {
				jteOutput.writeContent("\n                        <td> <a type=\"button\" class=\"btn btn-danger no-gutters\" href=\"/pedidos/cancelar/");
				jteOutput.setContext("a", "href");
				jteOutput.writeUserContent(pedido.getIdPedido());
				jteOutput.writeContent("\"> Cancelar </a></td>    \n                    ");
			} else {
				jteOutput.writeContent("\n                        <td></td>\n                    ");
			}
			jteOutput.writeContent("\n                </tr>\n            ");
		}
		jteOutput.writeContent("\n            </tbody>\n        </table>\n    </div>\n    <center>\n        <a href=\"/\" type=\"button\" class=\"btn btn-primary justify-content-center align-items-center\"> Volver </a>\n    </center>\n</div>\n\n<script src=\"/js/pedido.js\"></script>\n\n");
		gg.jte.generated.tag.JtefooterGenerated.render(jteOutput, jteHtmlInterceptor);
	}
	public static void renderMap(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, java.util.Map<String, Object> params) {
		edu.unam.integrador.paginas.ModeloPedidos modelo = (edu.unam.integrador.paginas.ModeloPedidos)params.get("modelo");
		render(jteOutput, jteHtmlInterceptor, modelo);
	}
}

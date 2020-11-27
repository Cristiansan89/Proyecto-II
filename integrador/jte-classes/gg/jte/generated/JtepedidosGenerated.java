package gg.jte.generated;
public final class JtepedidosGenerated {
	public static final String JTE_NAME = "pedidos.jte";
	public static final int[] JTE_LINE_INFO = {0,0,0,0,1,1,15,15,17,17,17,18,18,18,18,18,18,19,19,19,20,20,20,22,22,22,24,24,27,27};
	public static void render(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, edu.unam.integrador.paginas.ModeloPedidos modelo) {
		gg.jte.generated.tag.JteheaderGenerated.render(jteOutput, jteHtmlInterceptor);
		jteOutput.writeContent("\r\n<br>\r\n<script src=\"/js/fecha.js\"></script>\r\n                        <table class=\"table table-hover table-striped\">\r\n                            <thead>\r\n                                <tr>  \r\n                                <th>Id</th>\r\n                                    <th>Fecha</th>\r\n                                    <th>Estado</th>\r\n                                    <th>Total</th>\r\n                                    <th> </th>\r\n                                </tr>\r\n                            </thead>\r\n                            <tbody>\r\n                            ");
		for (var pedido : modelo.pedidos ) {
			jteOutput.writeContent("\r\n                                    <tr>\r\n<td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(pedido.getIdPedido());
			jteOutput.writeContent("</td>\r\n                         <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(pedido.formatoFecha(pedido.getFecha()));
			jteOutput.writeContent("-");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(pedido.getHora());
			jteOutput.writeContent("</td>\r\n                                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(pedido.isEstado());
			jteOutput.writeContent("</td>\r\n                                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(pedido.getTotalPagar());
			jteOutput.writeContent("</td>\r\n                                        \r\n                                        <td> <button type=\"button\" class=\"btn btn-danger no-gutters\" onClick=\"borrar(");
			jteOutput.setContext("button", "onClick");
			jteOutput.writeUserContent(pedido.getIdPedido());
			jteOutput.writeContent(")\"> Anular </button></td>\r\n                                    </tr>\r\n                            ");
		}
		jteOutput.writeContent("\r\n                            </tbody>\r\n                        </table>\r\n");
		gg.jte.generated.tag.JtefooterGenerated.render(jteOutput, jteHtmlInterceptor);
	}
	public static void renderMap(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, java.util.Map<String, Object> params) {
		edu.unam.integrador.paginas.ModeloPedidos modelo = (edu.unam.integrador.paginas.ModeloPedidos)params.get("modelo");
		render(jteOutput, jteHtmlInterceptor, modelo);
	}
}

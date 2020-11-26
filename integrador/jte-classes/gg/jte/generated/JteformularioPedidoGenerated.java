package gg.jte.generated;
public final class JteformularioPedidoGenerated {
	public static final String JTE_NAME = "formularioPedido.jte";
	public static final int[] JTE_LINE_INFO = {0,0,0,0,2,2,2,11,11,11,17,17,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,19,19,26,26,26,50,50,50,64,64,66,66,66,67,67,67,68,68,68,69,69,69,71,71,71,71,71,71,73,73,86,86};
	public static void render(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, edu.unam.integrador.paginas.ModeloDetallesPedidos modelo) {
		jteOutput.writeContent("\r\n");
		gg.jte.generated.tag.JteheadersGenerated.render(jteOutput, jteHtmlInterceptor);
		jteOutput.writeContent("\r\n<div class=\"container\">\r\n<div class=\"align-items-center\">\r\n\r\n        <div class=\"card\"  style=\"\"> \r\n            <div class=\"card-footer\">\r\n                <div style=\"margin-left: 3em;\"> \r\n                    <h2><b>Ingresar Pedido</b></h2>\r\n                    <br>\r\n                    <form action=\"/pedidos/agregardetalle/");
		jteOutput.setContext("form", "action");
		jteOutput.writeUserContent(modelo.idPedido);
		jteOutput.writeContent("\" method=\"post\">\r\n                        <label for=\"unProducto\" class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Producto</label>\r\n                        <div class=\"form-group row\">\r\n                            <div class=\"col-sm-20\">  \r\n                                <select name=\"producto\" class=\"selectpicker\" data-style=\"btn-success\">\r\n                                    <option> </option>\r\n                                    ");
		for (var producto : modelo.productos) {
			jteOutput.writeContent("\r\n                                        <option value=\"");
			jteOutput.setContext("option", "value");
			jteOutput.writeUserContent(producto.getIdProducto());
			jteOutput.writeContent("\" >");
			jteOutput.setContext("option", null);
			jteOutput.writeUserContent(producto.getIdProducto());
			jteOutput.writeContent(" - ");
			jteOutput.setContext("option", null);
			jteOutput.writeUserContent(producto.getCodProducto());
			jteOutput.writeContent(" - ");
			jteOutput.setContext("option", null);
			jteOutput.writeUserContent(producto.getCategoria());
			jteOutput.writeContent(" - ");
			jteOutput.setContext("option", null);
			jteOutput.writeUserContent(producto.getMarca());
			jteOutput.writeContent(" - ");
			jteOutput.setContext("option", null);
			jteOutput.writeUserContent(producto.getMedida());
			jteOutput.writeContent(" - ");
			jteOutput.setContext("option", null);
			jteOutput.writeUserContent(producto.getUnidad());
			jteOutput.writeContent(" - ");
			jteOutput.setContext("option", null);
			jteOutput.writeUserContent(producto.getStock());
			jteOutput.writeContent(" - ");
			jteOutput.setContext("option", null);
			jteOutput.writeUserContent(producto.getPrecioUnitario());
			jteOutput.writeContent(" - ");
			jteOutput.setContext("option", null);
			jteOutput.writeUserContent(producto.getDetalle());
			jteOutput.writeContent(" </option>\r\n                                    ");
		}
		jteOutput.writeContent("\r\n                                </select>\r\n                            </div>\r\n                        </div>\r\n                        <label for=\"unCliente\" class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Cliente</label>    \r\n                        <div class=\"form-group row\">\r\n                            <div class=\"col-sm-10\">\r\n                                <input class=\"form-control\" type=\"text\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.nombreUsuario);
		jteOutput.writeContent("\" name=\"unCliente\" readonly/>\r\n                            </div>\r\n                        </div>\r\n                        <label for=\"cantidad\" class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Cantidad</label>\r\n                        <div class=\"form-group row\">\r\n                            <div class=\"col-sm-10\">\r\n                                <input class=\"form-control\" type=\"number\" name=\"cantidad\"/>\r\n                            </div>\r\n                        </div>\r\n                        <div class=\"text-center\" style=\"margin-right: 4em;\">\r\n                            <button type=\"submit\" class=\"btn btn-primary\"> Agregar </button>\r\n                        </div>\r\n                    </form>\r\n                </div>\r\n            </div>\r\n        </div>\r\n    </div>\r\n</div>\r\n\r\n<div class=\"card\" style=\"width: 95%; left: 45px; right: 25px; margin-bottom: 3rem;\"> \r\n    <div class=\"card-footer\">\r\n        <div style=\"margin-left: 3em; \">\r\n            <h2><b>Lista de Pedido</b></h2>\r\n            <br>\r\n            <form action=\"/pedidos/finalizar/");
		jteOutput.setContext("form", "action");
		jteOutput.writeUserContent(modelo.idPedido);
		jteOutput.writeContent("\" method=\"post\">\r\n                <div style=\"margin-top: 6em; margin-left: 15em; margin-right: 15em;\">\r\n                    <div class=\"table-responsive\">\r\n                        <table class=\"table table-hover table-striped\">\r\n                            <thead>\r\n                                <tr>  \r\n                                    <th>Producto</th>\r\n                                    <th>Cantidad</th>\r\n                                    <th>Precio</th>\r\n                                    <th>Neto</th>\r\n                                    <th> </th>\r\n                                </tr>\r\n                            </thead>\r\n                            <tbody>\r\n                            ");
		for (var detallepedido : modelo.detallePedidos ) {
			jteOutput.writeContent("\r\n                                    <tr>\r\n<td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(detallepedido.getProducto().toString());
			jteOutput.writeContent("</td>\r\n                                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(detallepedido.getCantidad());
			jteOutput.writeContent("</td>\r\n                                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(detallepedido.getProducto().getPrecioUnitario());
			jteOutput.writeContent("</td>\r\n                                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(detallepedido.getTotalFila());
			jteOutput.writeContent("</td>\r\n                                        \r\n                                        <td> <button type=\"button\" class=\"btn btn-danger no-gutters\" onClick=\"borrar(");
			jteOutput.setContext("button", "onClick");
			jteOutput.writeUserContent(detallepedido.getIdDetallePedido());
			jteOutput.writeContent(",");
			jteOutput.setContext("button", "onClick");
			jteOutput.writeUserContent(modelo.idPedido);
			jteOutput.writeContent(")\"> Quitar </button></td>\r\n                                    </tr>\r\n                            ");
		}
		jteOutput.writeContent("\r\n                            </tbody>\r\n                        </table>\r\n\r\n                    </div>\r\n                    <button type=\"submit\" class=\"btn btn-primary\"> Finalizar </button>\r\n                    <a href=\"/\" style=\"float: right;\" type=\"button\" class=\"btn btn-primary\"> Volver </a>\r\n                </div>\r\n            </form>\r\n        </div>\r\n    </div>\r\n</div>\r\n<script src=\"/js/detallepedido.js\"></script>\r\n");
		gg.jte.generated.tag.JtefooterGenerated.render(jteOutput, jteHtmlInterceptor);
	}
	public static void renderMap(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, java.util.Map<String, Object> params) {
		edu.unam.integrador.paginas.ModeloDetallesPedidos modelo = (edu.unam.integrador.paginas.ModeloDetallesPedidos)params.get("modelo");
		render(jteOutput, jteHtmlInterceptor, modelo);
	}
}

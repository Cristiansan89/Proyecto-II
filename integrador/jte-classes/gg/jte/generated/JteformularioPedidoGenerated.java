package gg.jte.generated;
public final class JteformularioPedidoGenerated {
	public static final String JTE_NAME = "formularioPedido.jte";
	public static final int[] JTE_LINE_INFO = {0,0,0,0,2,2,2,8,8,8,14,14,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,16,16,23,23,23,23,23,23,44,44,44,58,58,60,60,60,61,61,61,62,62,62,63,63,63,64,64,64,64,64,64,66,66,74,74,74,80,80,80,81,81,81,88,88,88,104,104};
	public static void render(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, edu.unam.integrador.paginas.ModeloDetallesPedidos modelo) {
		jteOutput.writeContent("\n");
		gg.jte.generated.tag.JteheaderGenerated.render(jteOutput, jteHtmlInterceptor);
		jteOutput.writeContent("\n\n<div class=\"card\" id=\"estilo_card_pedido\"> \n    <div class=\"card-footer\">\n        <h2>Ingresar Pedido</h2>\n        <div id=\"estilo_card_form\">\n            <form action=\"/pedidos/agregardetalle/");
		jteOutput.setContext("form", "action");
		jteOutput.writeUserContent(modelo.idPedido);
		jteOutput.writeContent("\" method=\"post\">\n                <label for=\"unProducto\" class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Producto</label>\n                <div class=\"form-group row\">\n                    <div class=\"col-sm-10 form-inline\">  \n                        <select name=\"producto\" class=\"custom-select\" id=\"formulario\">\n                            <option> </option>\n                            ");
		for (var producto : modelo.productos) {
			jteOutput.writeContent("\n                                <option value=\"");
			jteOutput.setContext("option", "value");
			jteOutput.writeUserContent(producto.getIdProducto());
			jteOutput.writeContent("\">");
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
			jteOutput.writeContent(" - Stock: ");
			jteOutput.setContext("option", null);
			jteOutput.writeUserContent(producto.getStock());
			jteOutput.writeContent(" - $");
			jteOutput.setContext("option", null);
			jteOutput.writeUserContent(producto.precioDecimal());
			jteOutput.writeContent(" - ");
			jteOutput.setContext("option", null);
			jteOutput.writeUserContent(producto.getDetalle());
			jteOutput.writeContent(" </option>\n                            ");
		}
		jteOutput.writeContent("\n                        </select>\n                    </div>\n                </div>\n                <label for=\"unCliente\" class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Cliente</label>    \n                <div class=\"form-group row\">\n                    <div class=\"col-sm-10\">\n                        <input class=\"form-inline\" type=\"text\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.nombre);
		jteOutput.writeContent(" ");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.apellido);
		jteOutput.writeContent("\" name=\"unCliente\" readonly/>\n                    </div>\n                </div>\n                <label for=\"cantidad\" class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Cantidad</label>\n                <div class=\"form-group row\">\n                    <div class=\"col-sm-10\">\n                        <input class=\"form-inline\" type=\"number\" name=\"cantidad\"/>\n                    </div>\n                </div>\n                <div class=\"text-center\" style=\"margin-right: 6em;\">\n                    <button type=\"submit\" class=\"btn btn-success\"> Agregar </button>\n                </div>\n            </form>\n        </div>\n    </div>\n</div>\n\n<div class=\"card\" id=\"estilo_card_list\"> \n    <div class=\"card-footer\">\n        <div>\n            <h2> Lista de Pedido </h2>\n            <form action=\"/pedidos/finalizar/");
		jteOutput.setContext("form", "action");
		jteOutput.writeUserContent(modelo.idPedido);
		jteOutput.writeContent("\" method=\"post\">\n                <div id=\"estilo_list_pedido\">\n                    <div class=\"table-responsive\">\n                        <table class=\"table table-hover table-striped\">\n                            <thead>\n                                <tr>  \n                                    <th>Producto</th>\n                                    <th>Cantidad</th>\n                                    <th>Precio</th>\n                                    <th>Neto</th>\n                                    <th> </th>\n                                </tr>\n                            </thead>\n                            <tbody>\n                                ");
		for (var detallepedido : modelo.detallePedidos ) {
			jteOutput.writeContent("\n                                    <tr>\n                                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(detallepedido.getProducto().toString());
			jteOutput.writeContent("</td>\n                                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(detallepedido.getCantidad());
			jteOutput.writeContent("</td>\n                                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(detallepedido.getProducto().precioDecimal());
			jteOutput.writeContent("</td>\n                                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(detallepedido.stringSubTotal());
			jteOutput.writeContent("</td>\n                                        <td> <button type=\"button\" class=\"btn btn-danger no-gutters\" onClick=\"borrar(");
			jteOutput.setContext("button", "onClick");
			jteOutput.writeUserContent(detallepedido.getIdDetallePedido());
			jteOutput.writeContent(",");
			jteOutput.setContext("button", "onClick");
			jteOutput.writeUserContent(modelo.idPedido);
			jteOutput.writeContent(")\"> Quitar </button></td>\n                                    </tr>\n                                ");
		}
		jteOutput.writeContent("\n                                \n                            </tbody>\n                            <thead>\n                                <tr class=\"alert-secondary\">\n                                    <td> </td>\n                                    <td> </td>\n                                    <td><b>SubTotal</b></td>\n                                    <td><b>");
		jteOutput.setContext("b", null);
		jteOutput.writeUserContent(modelo.subtotal);
		jteOutput.writeContent("</b></td>\n                                    <td> </td>\n                                </tr> \n                                <tr class=\"bg-light\">\n                                    <td> </td>\n                                    <td> </td>\n                                    <td><b>Descuento ");
		jteOutput.setContext("b", null);
		jteOutput.writeUserContent(modelo.valdescuento);
		jteOutput.writeContent("%</b></td>\n                                    <td><b>");
		jteOutput.setContext("b", null);
		jteOutput.writeUserContent(modelo.descuento);
		jteOutput.writeContent("</b></td>\n                                    <td> </td>\n                                </tr> \n                                <tr class=\"bg-warning\">\n                                    <td> </td>\n                                    <td> </td>\n                                    <td><b>Total</b></td>\n                                    <td><b>");
		jteOutput.setContext("b", null);
		jteOutput.writeUserContent(modelo.total);
		jteOutput.writeContent("</b></td>\n                                    <td> </td>\n                                </tr>\n                            </thead>\n                        </table>\n                    </div>\n                </div>\n                <div class=\"text-center\">\n                    <button type=\"submit\" class=\"btn btn-primary\"> Finalizar </button>\n                    <a href=\"/\" style=\"float:center;\" type=\"button\" class=\"btn btn-secondary\"> Volver </a>\n                </div>\n            </form>\n        </div>\n    </div>\n</div>\n<script src=\"/js/detallepedido.js\"></script>\n");
		gg.jte.generated.tag.JtefooterGenerated.render(jteOutput, jteHtmlInterceptor);
	}
	public static void renderMap(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, java.util.Map<String, Object> params) {
		edu.unam.integrador.paginas.ModeloDetallesPedidos modelo = (edu.unam.integrador.paginas.ModeloDetallesPedidos)params.get("modelo");
		render(jteOutput, jteHtmlInterceptor, modelo);
	}
}

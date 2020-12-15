package gg.jte.generated;
public final class JtelistaDetallePedidoGenerated {
	public static final String JTE_NAME = "listaDetallePedido.jte";
	public static final int[] JTE_LINE_INFO = {0,0,0,0,2,2,2,9,9,9,10,10,10,11,11,11,12,12,12,13,13,13,32,32,34,34,34,35,35,35,36,36,36,37,37,37,39,39,46,46,46,51,51,51,52,52,52,58,58,58,67,67};
	public static void render(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, edu.unam.integrador.paginas.ModeloDetallesPedidos modelo) {
		jteOutput.writeContent("\n");
		gg.jte.generated.tag.JteheaderGenerated.render(jteOutput, jteHtmlInterceptor);
		jteOutput.writeContent("\n\n<div id=\"cuerpo_datos\">\n    <div class=\"card-footer\">\n        <div id=\"estilo_card_form\"> \n            <h2>Datos del Cliente</h2>\n            <br>\n            <label class=\"col-sm-8 col-form-label font-weight-bold text-uppercase\" id=\"text-size\">Apellido: ");
		jteOutput.setContext("label", null);
		jteOutput.writeUserContent(modelo.apellido);
		jteOutput.writeContent("</label>\n            <label class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Nombre: ");
		jteOutput.setContext("label", null);
		jteOutput.writeUserContent(modelo.nombre);
		jteOutput.writeContent("</label>\n            <label class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Cuil: ");
		jteOutput.setContext("label", null);
		jteOutput.writeUserContent(modelo.cuil);
		jteOutput.writeContent("</label>\n            <label class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Domicilio: ");
		jteOutput.setContext("label", null);
		jteOutput.writeUserContent(modelo.domicilio);
		jteOutput.writeContent("</label>\n            <label class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Tel&eacute;fono: ");
		jteOutput.setContext("label", null);
		jteOutput.writeUserContent(modelo.telefono);
		jteOutput.writeContent("</label>\n        </div>\n    </div>\n</div>\n<br>\n<div id=\"estilo_list\">\n    <h2><b>Lista de Pedido</b></h2>\n    <br>\n    <div class=\"table-responsive\">\n        <table class=\"table table-hover table-striped\">\n            <thead>\n                <tr>  \n                    <th>Producto</th>\n                    <th>Cantidad</th>\n                    <th>Precio</th>\n                    <th>Neto</th>\n                </tr>\n            </thead>\n            <tbody>\n                    ");
		for (var detallepedido : modelo.detallePedidos ) {
			jteOutput.writeContent("\n                    <tr>\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(detallepedido.getProducto().toString());
			jteOutput.writeContent("</td>\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(detallepedido.getCantidad());
			jteOutput.writeContent("</td>\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(detallepedido.getProducto().getPrecioUnitario());
			jteOutput.writeContent("</td>\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(detallepedido.getTotalFila());
			jteOutput.writeContent("</td>\n                    </tr>\n                ");
		}
		jteOutput.writeContent("\n            </tbody>\n            <thead>\n                <tr class=\"alert-secondary\">\n                    <td> </td>\n                    <td> </td>\n                    <td><b>SubTotal</b></td>\n                    <td><b>");
		jteOutput.setContext("b", null);
		jteOutput.writeUserContent(modelo.subtotal);
		jteOutput.writeContent("</b></td>\n                </tr> \n                <tr class=\"bg-light\">\n                    <td> </td>\n                    <td> </td>\n                    <td><b>Descuento ");
		jteOutput.setContext("b", null);
		jteOutput.writeUserContent(modelo.valdescuento);
		jteOutput.writeContent("%</b></td>\n                    <td><b>");
		jteOutput.setContext("b", null);
		jteOutput.writeUserContent(modelo.descuento);
		jteOutput.writeContent("</b></td>\n                </tr> \n                <tr class=\"bg-warning\">\n                    <td> </td>\n                    <td> </td>\n                    <td><b>Total</b></td>\n                    <td><b>");
		jteOutput.setContext("b", null);
		jteOutput.writeUserContent(modelo.total);
		jteOutput.writeContent("</b></td>\n                </tr>\n            </thead>\n        </table>\n    </div>\n    <a href=\"/pedidos\" style=\"float: left;\" type=\"button\" class=\"btn btn-primary\"> Volver </a>\n</div>\n\n\n");
		gg.jte.generated.tag.JtefooterGenerated.render(jteOutput, jteHtmlInterceptor);
	}
	public static void renderMap(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, java.util.Map<String, Object> params) {
		edu.unam.integrador.paginas.ModeloDetallesPedidos modelo = (edu.unam.integrador.paginas.ModeloDetallesPedidos)params.get("modelo");
		render(jteOutput, jteHtmlInterceptor, modelo);
	}
}

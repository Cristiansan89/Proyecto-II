package gg.jte.generated;
public final class JtelistaDetallePedidoGenerated {
	public static final String JTE_NAME = "listaDetallePedido.jte";
	public static final int[] JTE_LINE_INFO = {0,0,0,0,3,3,3,17,17,17,20,20,20,25,25,25,28,28,28,33,33,33,51,51,53,53,53,54,54,54,55,55,55,56,56,56,58,58,65,65,65,70,70,70,71,71,71,77,77,77,87,87};
	public static void render(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, edu.unam.integrador.paginas.ModeloDetallesPedidos modelo) {
		jteOutput.writeContent("\n\n");
		gg.jte.generated.tag.JteheaderGenerated.render(jteOutput, jteHtmlInterceptor);
		jteOutput.writeContent("\n\n<br>\n<div id=\"estilo_list\">\n    <h2><b>Pedido</b></h2>\n    <br>\n    <div class=\"card\" id=\"estilo_card_data\"> \n        <div class=\"card-footer\">\n            <div class=\"table-responsive\">\n                <p class=\"ml-3 h3 font-weight-bold\" id=\"text-size-titulo\"><ins>Datos del Cliente</ins></p>    \n                <table class=\"table table-hover\" >\n                    <thead>\n                        <tr style=\"border: hidden\">\n                            <td>\n                                <label class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size-data\">Apellido: <span class=\"text-uppercase\">");
		jteOutput.setContext("span", null);
		jteOutput.writeUserContent(modelo.apellido);
		jteOutput.writeContent("</span></label>\n                            </td>\n                            <td>\n                                <label class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size-data\">Nombre: <span class=\"text-uppercase\">");
		jteOutput.setContext("span", null);
		jteOutput.writeUserContent(modelo.nombre);
		jteOutput.writeContent("</span></label>\n                            </td>\n                        </tr>\n                        <tr style=\"border: hidden\">\n                            <td>\n                                <label class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size-data\">Cuil: ");
		jteOutput.setContext("label", null);
		jteOutput.writeUserContent(modelo.cuil);
		jteOutput.writeContent("</label>\n                            </td>\n                            <td>\n                                <label class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size-data\">Tel&eacute;fono: ");
		jteOutput.setContext("label", null);
		jteOutput.writeUserContent(modelo.telefono);
		jteOutput.writeContent("</label>\n                            </td>\n                        </tr>\n                        <tr style=\"border: hidden\">\n                            <td>\n                                <label class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size-data\">Domicilio: <span class=\"text-uppercase\">");
		jteOutput.setContext("span", null);
		jteOutput.writeUserContent(modelo.domicilio);
		jteOutput.writeContent("</span></label>                        \n                            </td>\n                        </tr>\n                    </thead>\n                </table>\n            </div>\n        </div>\n    </div>\n    <table class=\"table table-hover table-striped\">\n        <thead>\n            <tr>  \n                <th>Producto</th>\n                <th>Cantidad</th>\n                <th>Precio</th>\n                <th>Neto</th>\n            </tr>\n        </thead>\n        <tbody>\n                ");
		for (var detallepedido : modelo.detallePedidos ) {
			jteOutput.writeContent("\n                <tr>\n                    <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(detallepedido.getProducto().toString());
			jteOutput.writeContent("</td>\n                    <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(detallepedido.getCantidad());
			jteOutput.writeContent("</td>\n                    <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(detallepedido.getProducto().getPrecioUnitario());
			jteOutput.writeContent("</td>\n                    <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(detallepedido.getSubTotal());
			jteOutput.writeContent("</td>\n                </tr>\n            ");
		}
		jteOutput.writeContent("\n        </tbody>\n        <thead>\n            <tr class=\"alert-secondary\">\n                <td> </td>\n                <td> </td>\n                <td><b>SubTotal</b></td>\n                <td><b>");
		jteOutput.setContext("b", null);
		jteOutput.writeUserContent(modelo.subtotal);
		jteOutput.writeContent("</b></td>\n            </tr> \n            <tr class=\"bg-light\">\n                <td> </td>\n                <td> </td>\n                <td><b>Descuento ");
		jteOutput.setContext("b", null);
		jteOutput.writeUserContent(modelo.valdescuento);
		jteOutput.writeContent("%</b></td>\n                <td><b>");
		jteOutput.setContext("b", null);
		jteOutput.writeUserContent(modelo.descuento);
		jteOutput.writeContent("</b></td>\n            </tr> \n            <tr class=\"bg-warning\">\n                <td> </td>\n                <td> </td>\n                <td><b>Total</b></td>\n                <td><b>");
		jteOutput.setContext("b", null);
		jteOutput.writeUserContent(modelo.total);
		jteOutput.writeContent("</b></td>\n            </tr>\n        </thead>\n    </table>\n    <center>\n        <a href=\"/pedidos/listapedido\" type=\"button\" class=\"btn btn-primary justify-content-center align-items-center\"> Volver </a>\n    </center>\n</div>\n\n\n");
		gg.jte.generated.tag.JtefooterGenerated.render(jteOutput, jteHtmlInterceptor);
	}
	public static void renderMap(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, java.util.Map<String, Object> params) {
		edu.unam.integrador.paginas.ModeloDetallesPedidos modelo = (edu.unam.integrador.paginas.ModeloDetallesPedidos)params.get("modelo");
		render(jteOutput, jteHtmlInterceptor, modelo);
	}
}

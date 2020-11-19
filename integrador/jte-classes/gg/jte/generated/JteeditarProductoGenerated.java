package gg.jte.generated;
public final class JteeditarProductoGenerated {
	public static final String JTE_NAME = "editarProducto.jte";
	public static final int[] JTE_LINE_INFO = {0,0,0,0,2,2,2,11,11,11,15,15,15,21,21,21,27,27,27,33,33,33,39,39,39,45,45,45,51,51,51,57,57,57,69,69};
	public static void render(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, edu.unam.integrador.paginas.ModeloProducto modelo) {
		jteOutput.writeContent("\n");
		gg.jte.generated.tag.JteheaderGenerated.render(jteOutput, jteHtmlInterceptor);
		jteOutput.writeContent("\n\n<h2>Cliente</h2>\n\n<div class=\"card\" style=\"width: 42rem; top: 7rem; left: 40rem; margin-bottom: 10rem;\"> \n    <div class=\"card-footer\">\n        <div style=\"margin-left: 3em; \">\n            <h2><b>Editar Producto</b></h2>\n            <br>\n            <form action=\"/productos/actualizar/");
		jteOutput.setContext("form", "action");
		jteOutput.writeUserContent(modelo.producto.getIdProducto());
		jteOutput.writeContent("\" method=\"post\">\n                <label for=\"codproducto\" class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">C&oacute;digo Producto</label>\n                <div class=\"form-group row\">\n                    <div class=\"col-sm-10\">\n                        <input class=\"form-control\" type=\"number\" name=\"codproducto\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.producto.getCodProducto());
		jteOutput.writeContent("\"/>\n                    </div>\n                </div>\n                <label for=\"categoria\" class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Categor&iacute;a</label>\n                <div class=\"form-group row\">\n                    <div class=\"col-sm-10\">\n                        <input class=\"form-control\" type=\"text\" name=\"categoria\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.producto.getCategoria());
		jteOutput.writeContent("\"/>\n                    </div>\n                </div>\n                <label for=\"marca\" class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Marca</label>\n                <div class=\"form-group row\">\n                    <div class=\"col-sm-10\">\n                        <input class=\"form-control\" type=\"text\" name=\"marca\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.producto.getMarca());
		jteOutput.writeContent("\"/>\n                    </div>\n                </div>\n                <label for=\"medida\" class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Medida</label>                \n                <div class=\"form-group row\">\n                    <div class=\"col-sm-10\">\n                        <input class=\"form-control\" type=\"text\" name=\"medida\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.producto.getMedida());
		jteOutput.writeContent("\"/>\n                    </div>\n                </div>\n                <label for=\"unidad\" class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Unidad</label>\n                <div class=\"form-group row\">\n                    <div class=\"col-sm-10\">\n                        <input class=\"form-control\" type=\"number\" name=\"unidad\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.producto.getUnidad());
		jteOutput.writeContent("\"/>\n                    </div>\n                </div>\n                <label for=\"stock\" class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Stock</label>\n                <div class=\"form-group row\">\n                    <div class=\"col-sm-10\">\n                        <input class=\"form-control\" type=\"number\" name=\"stock\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.producto.getStock());
		jteOutput.writeContent("\"/>\n                    </div>\n                </div>\n                <label for=\"preciounitario\" class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Precio Unitario</label>\n                <div class=\"form-group row\">\n                    <div class=\"col-sm-10\">\n                        <input class=\"form-control\" type=\"number\" name=\"preciounitario\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.producto.getPrecioUnitario());
		jteOutput.writeContent("\"/>\n                    </div>\n                </div>\n                <label for=\"detalle\" class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Detalle</label>\n                <div class=\"form-group row\">\n                    <div class=\"col-sm-10\">\n                        <input class=\"form-control\" type=\"text\" name=\"detalle\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.producto.getDetalle());
		jteOutput.writeContent("\"/>\n                    </div>\n                </div>\n                <div class=\"text-center\" style=\"margin-right: 4em;\">\n                    <button type=\"submit\" class=\"btn btn-primary\"> Modificar </button>\n                    <a href=\"/\" type=\"button\" class=\"btn btn-secondary\"> Volver </a>\n                </div>\n            </form>\n        </div>\n    </div>\n</div>\n\n");
		gg.jte.generated.tag.JtefooterGenerated.render(jteOutput, jteHtmlInterceptor);
	}
	public static void renderMap(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, java.util.Map<String, Object> params) {
		edu.unam.integrador.paginas.ModeloProducto modelo = (edu.unam.integrador.paginas.ModeloProducto)params.get("modelo");
		render(jteOutput, jteHtmlInterceptor, modelo);
	}
}

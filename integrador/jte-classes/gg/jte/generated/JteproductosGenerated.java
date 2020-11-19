package gg.jte.generated;
public final class JteproductosGenerated {
	public static final String JTE_NAME = "productos.jte";
	public static final int[] JTE_LINE_INFO = {0,0,0,0,2,2,2,23,23,25,25,25,26,26,26,27,27,27,28,28,28,29,29,29,30,30,30,31,31,31,32,32,32,33,33,33,34,34,34,36,36,45,45};
	public static void render(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, edu.unam.integrador.paginas.ModeloProductos modelo) {
		jteOutput.writeContent("\r\n");
		gg.jte.generated.tag.JteheaderGenerated.render(jteOutput, jteHtmlInterceptor);
		jteOutput.writeContent("\r\n\r\n<div style=\"margin-top: 6em; margin-left: 15em; margin-right: 15em;\">\r\n    <h2><b>Producto</b></h2>\r\n    <div class=\"table-responsive\">\r\n        <table class=\"table table-hover table-striped\">\r\n            <thead>\r\n                <tr>\r\n                    <th>ID Producto</th>\r\n                    <th>C&oacute;digo Producto</th>\r\n                    <th>Categor&iacute;a</th>\r\n                    <th>Marca</th>\r\n                    <th>Medida</th>\r\n                    <th>Unidad</th>\r\n                    <th>Stock</th>\r\n                    <th>Detalle</th>\r\n                    <th> </th>\r\n                    <th> </th>\r\n                </tr>\r\n            </thead>\r\n            <tbody>\r\n                ");
		for (var producto : modelo.productos) {
			jteOutput.writeContent("\r\n                    <tr>\r\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(producto.getIdProducto());
			jteOutput.writeContent("</td>\r\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(producto.getCodProducto());
			jteOutput.writeContent("</td>\r\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(producto.getCategoria());
			jteOutput.writeContent("</td>\r\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(producto.getMarca());
			jteOutput.writeContent("</td>\r\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(producto.getMedida());
			jteOutput.writeContent("</td>\r\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(producto.getUnidad());
			jteOutput.writeContent("</td>\r\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(producto.getStock());
			jteOutput.writeContent("</td>\r\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(producto.getDetalle());
			jteOutput.writeContent("</td>\r\n                        <td> <a type=\"button\" class=\"btn btn-info no-gutters\" href=\"/productos/");
			jteOutput.setContext("a", "href");
			jteOutput.writeUserContent(producto.getIdProducto());
			jteOutput.writeContent("\"> Editar </a></td>\r\n                        <td> <button type=\"button\" class=\"btn btn-danger no-gutters\" onClick=\"borrar(");
			jteOutput.setContext("button", "onClick");
			jteOutput.writeUserContent(producto.getIdProducto());
			jteOutput.writeContent(")\"> Eliminar </button></td>\r\n                    </tr>\r\n                ");
		}
		jteOutput.writeContent("\r\n            </tbody>\r\n        </table>\r\n    </div>\r\n    <a href=\"/\" style=\"float: right;\" type=\"button\" class=\"btn btn-primary\"> Volver </a>\r\n</div>\r\n\r\n<script src=\"/js/producto.js\"></script>\r\n\r\n");
		gg.jte.generated.tag.JtefooterGenerated.render(jteOutput, jteHtmlInterceptor);
	}
	public static void renderMap(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, java.util.Map<String, Object> params) {
		edu.unam.integrador.paginas.ModeloProductos modelo = (edu.unam.integrador.paginas.ModeloProductos)params.get("modelo");
		render(jteOutput, jteHtmlInterceptor, modelo);
	}
}

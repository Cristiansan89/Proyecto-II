package gg.jte.generated;
public final class JteproductosGenerated {
	public static final String JTE_NAME = "productos.jte";
	public static final int[] JTE_LINE_INFO = {0,0,0,0,2,2,2,20,20,24,24,28,28,30,30,30,31,31,31,32,32,32,33,33,33,34,34,34,35,35,35,36,36,36,37,37,37,38,38,38,39,39,40,40,40,41,41,41,42,42,44,44,54,54};
	public static void render(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, edu.unam.integrador.paginas.ModeloProductos modelo) {
		jteOutput.writeContent("\n");
		gg.jte.generated.tag.JteheaderGenerated.render(jteOutput, jteHtmlInterceptor);
		jteOutput.writeContent("\n\n<div id=\"estilo_list\">\n    <h2>Producto</h2>\n    <br>\n    <div class=\"table-responsive\">\n        <table class=\"table table-hover table-striped\">\n            <thead>\n                <tr>\n                    <th>ID Producto</th>\n                    <th>C&oacute;digo Producto</th>\n                    <th>Categor&iacute;a</th>\n                    <th>Marca</th>\n                    <th>Medida</th>\n                    <th>Unidad</th>\n                    <th>Stock</th>\n                    <th>Precio Unitario</th>\n                    <th>Detalle</th>\n                    ");
		if (modelo.rol.equals("admin")) {
			jteOutput.writeContent("\n                        <th> </th>\n                        <th> </th>\n                    \n                    ");
		}
		jteOutput.writeContent("\n                </tr>\n            </thead>\n            <tbody>\n                ");
		for (var producto : modelo.productos) {
			jteOutput.writeContent("\n                    <tr>\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(producto.getIdProducto());
			jteOutput.writeContent("</td>\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(producto.getCodProducto());
			jteOutput.writeContent("</td>\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(producto.getCategoria());
			jteOutput.writeContent("</td>\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(producto.getMarca());
			jteOutput.writeContent("</td>\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(producto.getMedida());
			jteOutput.writeContent("</td>\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(producto.getUnidad());
			jteOutput.writeContent("</td>\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(producto.getStock());
			jteOutput.writeContent("</td>\n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(producto.precioDecimal());
			jteOutput.writeContent("</td> \n                        <td>");
			jteOutput.setContext("td", null);
			jteOutput.writeUserContent(producto.getDetalle());
			jteOutput.writeContent("</td>\n                        ");
			if (modelo.rol.equals("admin")) {
				jteOutput.writeContent("\n                            <td> <a type=\"button\" class=\"btn btn-info no-gutters\" href=\"/productos/modificar/");
				jteOutput.setContext("a", "href");
				jteOutput.writeUserContent(producto.getIdProducto());
				jteOutput.writeContent("\"> Editar </a></td>\n                            <td> <button type=\"button\" class=\"btn btn-danger no-gutters\" onClick=\"borrar(");
				jteOutput.setContext("button", "onClick");
				jteOutput.writeUserContent(producto.getIdProducto());
				jteOutput.writeContent(")\"> Eliminar </button></td>\n                        ");
			}
			jteOutput.writeContent("\n                    </tr>\n                ");
		}
		jteOutput.writeContent("\n            </tbody>\n        </table>\n    </div>\n    \n    <a href=\"/\" style=\"float: right;\" type=\"button\" class=\"btn btn-primary\"> Volver </a>\n</div>\n\n<script src=\"/js/producto.js\"></script>\n\n");
		gg.jte.generated.tag.JtefooterGenerated.render(jteOutput, jteHtmlInterceptor);
	}
	public static void renderMap(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, java.util.Map<String, Object> params) {
		edu.unam.integrador.paginas.ModeloProductos modelo = (edu.unam.integrador.paginas.ModeloProductos)params.get("modelo");
		render(jteOutput, jteHtmlInterceptor, modelo);
	}
}

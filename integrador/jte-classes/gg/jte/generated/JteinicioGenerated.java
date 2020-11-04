package gg.jte.generated;
public final class JteinicioGenerated {
	public static final String JTE_NAME = "inicio.jte";
	public static final int[] JTE_LINE_INFO = {0,0,0,0,5,5,5,5,6,6,6,8};
	public static void render(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, edu.unam.integrador.PaginaInicio usuario) {
		jteOutput.writeContent("\r\n<html lang=\"en\">\r\n    <body>\r\n        <p>Hola!</p>\r\n        <p><b>Usuario </b> conectado es ");
		jteOutput.setContext("p", null);
		jteOutput.writeUserContent(usuario.nombreUsuario);
		jteOutput.writeContent(" </p>\r\n        <p><b>documento</b>: ");
		jteOutput.setContext("p", null);
		jteOutput.writeUserContent(usuario.documento);
		jteOutput.writeContent(")</p>\r\n    </body>\r\n</html>");
	}
	public static void renderMap(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, java.util.Map<String, Object> params) {
		edu.unam.integrador.PaginaInicio usuario = (edu.unam.integrador.PaginaInicio)params.get("usuario");
		render(jteOutput, jteHtmlInterceptor, usuario);
	}
}

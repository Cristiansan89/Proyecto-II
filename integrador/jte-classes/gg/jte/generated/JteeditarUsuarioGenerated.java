package gg.jte.generated;
public final class JteeditarUsuarioGenerated {
	public static final String JTE_NAME = "editarUsuario.jte";
	public static final int[] JTE_LINE_INFO = {0,0,0,0,2,2,2,9,9,9,14,14,14,20,20,20,62,62};
	public static void render(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, edu.unam.integrador.paginas.ModeloUsuario modelo) {
		jteOutput.writeContent("\n");
		gg.jte.generated.tag.JteheaderGenerated.render(jteOutput, jteHtmlInterceptor);
		jteOutput.writeContent("\n\n<div class=\"card\" id=\"estilo_card\"> \n    <div class=\"card-footer\">\n        <h2><b>Editar Usuario</b></h2>\n        <br>\n        <div id=\"estilo_card_form\">\n            <form action=\"/usuarios/actualizar/");
		jteOutput.setContext("form", "action");
		jteOutput.writeUserContent(modelo.usuario.getIdUsuario());
		jteOutput.writeContent("\" method=\"post\">\n                \n                <label for=\"mail\" class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Mail</label>\n                <div class=\"form-group row\">\n                    <div class=\"col-sm-10\">\n                        <input class=\"form-control\" type=\"email\" name=\"mail\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.usuario.getMail());
		jteOutput.writeContent("\" required/>\n                    </div>\n                </div>\n                <label for=\"nick\" class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Usuario</label>    \n                <div class=\"form-group row\">\n                    <div class=\"col-sm-10\">\n                        <input class=\"form-control\" type=\"text\" name=\"nick\" value=\"");
		jteOutput.setContext("input", "value");
		jteOutput.writeUserContent(modelo.nick);
		jteOutput.writeContent("\" readonly/>\n                    </div>\n                </div>\n                <label for=\"contrasena\" class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Contraseña</label>\n                <div class=\"form-group row\">\n                    <div class=\"col-sm-10\">\n                        <input class=\"form-control\" type=\"password\" id=\"contrasena\" name=\"contrasena\" required/>\n                    </div>\n                </div>\n                <label for=\"contrasena1\" class=\"col-sm-8 col-form-label font-weight-bold\" id=\"text-size\">Repetir Contraseña</label>\n                <div class=\"form-group row\">\n                    <div class=\"col-sm-10\">\n                        <input class=\"form-control\" type=\"password\" id=\"contrasena1\" name=\"contrasena1\" required/>\n                    </div>\n                </div>\n                <div id=\"msg\"></div>\n                <!-- Mensajes de Verificación -->\n                <div id=\"error\" class=\"alert alert-danger col-sm-10 ocultar\" role=\"alert\">\n                    Las Contraseñas no coinciden, vuelve a intentar !\n                </div>\n                <div id=\"ok\" class=\"alert alert-success col-sm-10 ocultar\" role=\"alert\">\n                    Las Contraseñas coinciden ! (Procesando formulario ... )\n                </div>\n                <!-- Fin Mensajes de Verificación -->\n                <div class=\"text-center\" id=\"estilo_bottom\">\n                    <button type=\"submit\" id=\"login\" class=\"btn btn-primary\"> Modificar </button>\n                    <a href=\"/\" type=\"button\" class=\"btn btn-secondary\"> Volver </a>\n                </div>\n            </form>\n        </div>\n    </div>\n</div>\n\n<script src=\"/js/usuario.js\"></>\n\n<script>\n    $(document).ready(function(){\n        $('#cuil').mask('00000000000');\n        $('#telefono').mask('0000000000');\n    });\n</script>\n\n");
		gg.jte.generated.tag.JtefooterGenerated.render(jteOutput, jteHtmlInterceptor);
	}
	public static void renderMap(gg.jte.html.HtmlTemplateOutput jteOutput, gg.jte.html.HtmlInterceptor jteHtmlInterceptor, java.util.Map<String, Object> params) {
		edu.unam.integrador.paginas.ModeloUsuario modelo = (edu.unam.integrador.paginas.ModeloUsuario)params.get("modelo");
		render(jteOutput, jteHtmlInterceptor, modelo);
	}
}

package edu.unam.integrador;

/**
 * Hello world!
 *
 */
import io.javalin.*;
import gg.jte.*;
import java.util.Collections;
import io.javalin.http.Context;

public class App 
{
    public static void main( String[] args )
    {   Javalin app = Javalin.create().start(8000);
        //app.get("/",clx->clx.render("hola.jte"));
        app.get("/",App::renderizarPaginaInicio);
        System.out.println( "Hello World!" );
    }
    private static void renderizarPaginaInicio(Context ctx) {
        var pagina = new PaginaInicio();
        pagina.nombreUsuario = "admin";
        pagina.documento = 123456789;
        ctx.render("inicio.jte", Collections.singletonMap("usuario", pagina));
    }
}

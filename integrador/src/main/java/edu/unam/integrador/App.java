package edu.unam.integrador;

import io.javalin.*;
import io.javalin.http.Context;
import java.util.Collections;
import org.sql2o.Sql2o;
import edu.unam.integrador.controladores.ClientesControlador;
import edu.unam.integrador.controladores.ProductosControlador;
import edu.unam.integrador.paginas.*;
import edu.unam.integrador.repositorio.RepositorioException;
import edu.unam.integrador.repositorio.Sql2oClientesRepositorio;
import edu.unam.integrador.repositorio.Sql2oProductosRepositorio;

import static io.javalin.apibuilder.ApiBuilder.*;

public class App {
    public static void main(String[] args) {

        // Conexión de sql2o
        var sql2o = new Sql2o("jdbc:postgresql://localhost:5432/distribuidora", "postgres", "410556");

        // Repositorio y Controladores

        var clientesRepositorio = new Sql2oClientesRepositorio(sql2o);
        var clientesControlador = new ClientesControlador(clientesRepositorio);

        var productosRepositorio = new Sql2oProductosRepositorio(sql2o);
        var productosControlador = new ProductosControlador(productosRepositorio);

        // Crear Servidor
        Javalin app = Javalin.create(config -> {
            config.addStaticFiles("/public");
        }).exception(RepositorioException.class, (e, ctx) -> {
            ctx.status(404);
        }).start(8000);

        app.get("/", App::mostrarIndex); // muestra el index
        app.post("/", App::validarUsuario);

        // Cliente
        app.get("/clientes", clientesControlador::listar);
        app.get("/clientes/nuevo", clientesControlador::nuevo);
        app.post("/clientes/crear", clientesControlador::crear);

        app.get("/clientes/modificar/:id", clientesControlador::modificar);
        app.post("/clientes/actualizar/:id", clientesControlador::actualizar);
        app.delete("/clientes/borrar/:id", clientesControlador::borrar);

        // Producto
        app.get("/productos", productosControlador::listar);
        app.get("/productos/nuevo", productosControlador::nuevo);
        app.post("/productos/crear", productosControlador::crear);

        app.get("/productos/modificar/:id", productosControlador::modificar);
        app.delete("/productos/borrar/:id", productosControlador::borrar);

    }

    private static void mostrarIndex(Context ctx) {
        var modelo = new ModeloIndex();
        // controlo por cookie
        if (ctx.cookie("nombreUsuario") != null) {
            modelo.nombreUsuario = ctx.cookie("nombreUsuario");
        } else {
            modelo.nombreUsuario = "";
        }
        ctx.render("inicio.jte", Collections.singletonMap("modelo", modelo));
    }

    private static void validarUsuario(Context ctx) {
        var valor = ctx.formParam("nombreUsuario", String.class).get();
        ctx.cookie("nombreUsuario", valor.trim());
        ctx.redirect("/");
    }

}
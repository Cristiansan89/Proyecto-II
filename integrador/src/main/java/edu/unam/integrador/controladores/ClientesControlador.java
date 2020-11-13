package edu.unam.integrador.controladores;

import java.sql.SQLException;
import java.util.Collections;

import edu.unam.integrador.paginas.ModeloCliente;
import edu.unam.integrador.modelo.Cliente;
import edu.unam.integrador.paginas.ModeloClientes;
import edu.unam.integrador.repositorio.ClientesRepositorio;
import edu.unam.integrador.repositorio.RepositorioException;
import io.javalin.http.Context;

public class ClientesControlador {

    private final ClientesRepositorio clientesRepositorio;

    public ClientesControlador(ClientesRepositorio clientesRepositorio) {
        this.clientesRepositorio = clientesRepositorio;
    }

    public void listar(Context ctx) throws SQLException {
        var modelo = new ModeloClientes();
        modelo.clientes = clientesRepositorio.listar();
        ctx.render("clientes.jte", Collections.singletonMap("modelo", modelo));
    }

    public void nuevo(Context ctx) throws SQLException {
        ctx.render("crearCliente.jte");

    }

    public void crear(Context ctx) throws SQLException {
        var cuil = ctx.formParam("cuil", Float.class).get();
        var nombre = ctx.formParam("nombre", String.class).get();
        var domicilio = ctx.formParam("domicilio", String.class).get();
        var telefono = ctx.formParam("telefono", Float.class).get();
        var cliente = new Cliente(nombre, cuil, domicilio, telefono);
        this.clientesRepositorio.crear(cliente);
        ctx.redirect("/");
    }

    public void borrar(Context ctx) throws SQLException, RepositorioException {
        System.out.println(ctx.pathParam("id", Integer.class).get());
        System.out.println(this.clientesRepositorio
                .borrar(this.clientesRepositorio.obtener(ctx.pathParam("id", Integer.class).get())));
        this.clientesRepositorio.borrar(this.clientesRepositorio.obtener(ctx.pathParam("id", Integer.class).get()));
        ctx.redirect("/clientes");
    }

    public void modificar(Context ctx) throws SQLException, RepositorioException {
        var modelo = new ModeloCliente();
        modelo.cliente = this.clientesRepositorio.obtener(ctx.pathParam("id", Integer.class).get());
        ctx.render("editarCliente.jte", Collections.singletonMap("modelo", modelo));
    }
}

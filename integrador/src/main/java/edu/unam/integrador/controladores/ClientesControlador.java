package edu.unam.integrador.controladores;

import io.javalin.http.Context;

import java.sql.SQLException;
import java.util.Collections;

import edu.unam.integrador.paginas.ModeloCliente;
import edu.unam.integrador.modelo.Cliente;
import edu.unam.integrador.paginas.ModeloClientes;
import edu.unam.integrador.repositorio.ClientesRepositorio;
import edu.unam.integrador.repositorio.RepositorioException;

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
        var nombre = ctx.formParam("nombre", String.class).get();
        var apellido = ctx.formParam("apellido", String.class).get();
        var cuil = ctx.formParam("cuil", Float.class).get();
        var domicilio = ctx.formParam("domicilio", String.class).get();
        var telefono = ctx.formParam("telefono", Float.class).get();
        var cliente = new Cliente(nombre, apellido, cuil, domicilio, telefono);
        this.clientesRepositorio.crear(cliente);
        ctx.redirect("/");
    }

    public void borrar(Context ctx) throws SQLException, RepositorioException {
        System.out.println(ctx.pathParam("id", Integer.class).get());
        this.clientesRepositorio.borrar(this.clientesRepositorio.obtener(ctx.pathParam("id", Integer.class).get()));
        ctx.redirect("/clientes");
    }

    public void modificar(Context ctx) throws SQLException, RepositorioException {
        var modelo = new ModeloCliente();
        modelo.cliente = this.clientesRepositorio.obtener(ctx.pathParam("id", Integer.class).get());
        ctx.render("editarCliente.jte", Collections.singletonMap("modelo", modelo));
    }

    public void actualizar(Context ctx) throws SQLException {
        var id = ctx.pathParam("id", Integer.class).get();
        Cliente cliente = this.clientesRepositorio.obtener(id);
        var nombre = ctx.formParam("nombre", String.class).get();
        var apellido = ctx.formParam("apellido", String.class).get();
        var cuil = ctx.formParam("cuil", Float.class).get();
        var domicilio = ctx.formParam("domicilio", String.class).get();
        var telefono = ctx.formParam("telefono", Float.class).get();
        cliente.setApellido(apellido);
        cliente.setCuil(cuil);
        cliente.setDomicilio(domicilio);
        cliente.setTelefono(telefono);
        cliente.setNombre(nombre);
        System.out.println(cliente.toString());
        this.clientesRepositorio.actualizar(cliente);
        ctx.redirect("/clientes");
    }
}

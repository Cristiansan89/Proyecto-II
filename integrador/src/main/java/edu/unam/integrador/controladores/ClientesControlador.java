package edu.unam.integrador.controladores;

import io.javalin.http.Context;

import java.sql.Date;
import java.sql.SQLException;
import java.util.Collections;

import edu.unam.integrador.paginas.ModeloCliente;
import edu.unam.integrador.paginas.ModeloUsuario;
import edu.unam.integrador.modelo.Cliente;
import edu.unam.integrador.modelo.Usuario;
import edu.unam.integrador.paginas.ModeloClientes;
import edu.unam.integrador.paginas.ModeloUsuarios;
import edu.unam.integrador.repositorio.ClientesRepositorio;
import edu.unam.integrador.repositorio.UsuariosRepositorio;
import edu.unam.integrador.repositorio.RepositorioException;

public class ClientesControlador {

    private final ClientesRepositorio clientesRepositorio;
    private final UsuariosRepositorio usuariosRepositorio;

    public ClientesControlador(ClientesRepositorio clientesRepositorio, UsuariosRepositorio usuariosRepositorio) {
        this.clientesRepositorio = clientesRepositorio;
        this.usuariosRepositorio = usuariosRepositorio;
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
        var mail = ctx.formParam("mail", String.class).get();
        var nick = ctx.formParam("nick", String.class).get();
        var contrasena = ctx.formParam("contrasena", String.class).get();

        var nombre = ctx.formParam("nombre", String.class).get();
        var apellido = ctx.formParam("apellido", String.class).get();
        var cuil = ctx.formParam("cuil", String.class).get();
        var domicilio = ctx.formParam("domicilio", String.class).get();
        var telefono = ctx.formParam("telefono", String.class).get();
        var cliente = new Cliente(nombre, apellido, cuil, domicilio, telefono);
        var clienteId = this.clientesRepositorio.crear(cliente);
        cliente.setIdCliente(clienteId);
        var usuario = new Usuario(mail, nick, contrasena, cliente);
        this.usuariosRepositorio.crear(usuario);
        ctx.redirect("/");

    }

    public void borrar(Context ctx) throws SQLException, RepositorioException {
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
        var cuil = ctx.formParam("cuil", String.class).get();
        var domicilio = ctx.formParam("domicilio", String.class).get();
        var telefono = ctx.formParam("telefono", String.class).get();
        cliente.setApellido(apellido);
        cliente.setCuil(cuil);
        cliente.setDomicilio(domicilio);
        cliente.setTelefono(telefono);
        cliente.setNombre(nombre);
        this.clientesRepositorio.actualizar(cliente);
        ctx.redirect("/clientes");
    }
}

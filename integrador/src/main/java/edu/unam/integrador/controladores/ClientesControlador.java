package edu.unam.integrador.controladores;

import java.sql.SQLException;
import java.util.Collections;

import edu.unam.integrador.paginas.ModeloClientes;
import edu.unam.integrador.modelo.Cliente;
import edu.unam.integrador.paginas.ModeloCliente;
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
        modelo.cliente = clientesRepositorio.listar();
        ctx.render("clientes.jte", Collections.singletonMap("modelo", modelo));
    }

    public void nuevo(Context ctx) throws SQLException {
        ctx.render("crearCliente.jte", Collections.singletonMap("modelo", null));
        
    }

    public void crear(Context ctx) throws SQLException{
        var cliente = new Cliente(ctx.formParam("nombre", String.class).get());
        this.clientesRepositorio.crear(cliente);
        ctx.redirect("/clientes");
    }

    
}

package edu.unam.integrador.controladores;

import edu.unam.integrador.repositorio.UsuariosRepositorio;
import edu.unam.integrador.repositorio.ClientesPreferencialRepositorio;
import edu.unam.integrador.repositorio.ClientesRepositorio;
import edu.unam.integrador.paginas.ModeloUsuarios;
import io.javalin.http.Context;
import java.sql.SQLException;
import java.util.Collections;

import edu.unam.integrador.modelo.Cliente;
import edu.unam.integrador.modelo.ClientePreferencial;
import edu.unam.integrador.modelo.Usuario;

public class UsuariosControlador {
    
    private final UsuariosRepositorio usuariosRepositorio;
    private final ClientesPreferencialRepositorio clientesPreferencialRepositorio;
    private final ClientesRepositorio clientesRepositorio;

    public UsuariosControlador(UsuariosRepositorio usuariosRepositorio, ClientesRepositorio clientesRepositorio, ClientesPreferencialRepositorio clientesPreferencialRepositorio) {
        this.usuariosRepositorio = usuariosRepositorio;
        this.clientesPreferencialRepositorio = clientesPreferencialRepositorio;
        this.clientesRepositorio = clientesRepositorio;
    }

    public void validarUsuario(Context ctx) throws SQLException {

        String nick = ctx.formParam("nick", String.class).get();
        String clave = ctx.formParam("contrasena", String.class).get();
        var resultado = this.usuariosRepositorio.clave(nick, clave);
        if (resultado) {
            ctx.cookie("nick", nick.trim());
            Usuario usuario = this.usuariosRepositorio.obtener(nick);
            ctx.cookie("rol", usuario.getRol());
            Cliente cliente = this.clientesRepositorio.obtener(nick);
            ClientePreferencial clientePreferencial = this.clientesPreferencialRepositorio.obtenerClientePreferencial(cliente.getIdCliente());
            clientePreferencial.getDescuento();
            this.clientesPreferencialRepositorio.actualizar(clientePreferencial);
            ctx.redirect("/");
        } else {
            ctx.redirect("/");
        }

    }

    public void mostrarIndex(Context ctx) {
        var modelo = new ModeloUsuarios();
        // controlo por cookie
        if (ctx.cookie("nick") != null) {
            modelo.nick = ctx.cookie("nick");
            modelo.rol = ctx.cookie("rol");
        } else {
            modelo.nick = "";
            modelo.rol="";
        }
        ctx.render("inicio.jte", Collections.singletonMap("modelo", modelo));
    }

    public void cerrarSesion(Context ctx){
        ctx.removeCookie("nick", "/");
        ctx.redirect("/");
    }

}

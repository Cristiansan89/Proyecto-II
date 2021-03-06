package edu.unam.integrador.controladores;

import edu.unam.integrador.repositorio.ClientesRepositorio;
import edu.unam.integrador.repositorio.UsuariosRepositorio;
import edu.unam.integrador.paginas.ModeloUsuario;
import edu.unam.integrador.paginas.ModeloUsuarios;
import io.javalin.http.Context;
import java.sql.SQLException;
import java.util.Collections;

import edu.unam.integrador.modelo.Cliente;
import edu.unam.integrador.modelo.Usuario;

public class UsuariosControlador {
    
    private final UsuariosRepositorio usuariosRepositorio;
    private final ClientesRepositorio clientesRepositorio;

    public UsuariosControlador(UsuariosRepositorio usuariosRepositorio, ClientesRepositorio clientesRepositorio) {
        this.usuariosRepositorio = usuariosRepositorio;
        this.clientesRepositorio = clientesRepositorio;
    }

    // Valida si ya existe el Usuario-Cliente
    public void validarUsuario(Context ctx) throws SQLException {
        String nick = ctx.formParam("nick", String.class).get();
        String clave = ctx.formParam("contrasena", String.class).get();
        var resultado = this.usuariosRepositorio.clave(nick, clave);
        if (resultado) {
            ctx.cookie("nick", nick.trim());
            Usuario usuario = this.usuariosRepositorio.obtener(nick);
            Cliente cliente = this.clientesRepositorio.obtenerCliente(nick);
            ctx.cookie("rol", usuario.getRol());
            ctx.cookie("cliente", String.valueOf(cliente.getIdCliente()));
            ctx.redirect("/");
        } else {
            ctx.redirect("/");
        }

    }

    // Inicio la Sesión
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

    // Cerrar la Sesion
    public void cerrarSesion(Context ctx){
        ctx.removeCookie("nick", "/");
        ctx.redirect("/");
    }

    // Modificar los datos de un Usuario
    public void modificar(Context ctx){
        var modelo = new ModeloUsuario();
        modelo.usuario = this.usuariosRepositorio.obtener(ctx.cookie("nick"));
        modelo.nick = ctx.cookie("nick");
        ctx.render("editarUsuario.jte", Collections.singletonMap("modelo", modelo));
    }

    // Actualiza los datos modificado del Usuario
    public void actualizar(Context ctx) throws SQLException {
        var id = ctx.pathParam("id", Integer.class).get();
        Usuario usuario = this.usuariosRepositorio.obtener(id);
        var mail = ctx.formParam("mail", String.class).get();
        var contrasena = ctx.formParam("contrasena", String.class).get();
        usuario.setMail(mail);
        usuario.setContrasena(contrasena);
        this.usuariosRepositorio.actualizar(usuario);
        ctx.redirect("/");
    }

}

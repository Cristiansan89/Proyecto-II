package edu.unam.integrador.controladores;

import edu.unam.integrador.repositorio.UsuariosRepositorio;
import edu.unam.integrador.paginas.ModeloUsuario;
import edu.unam.integrador.paginas.ModeloUsuarios;
import io.javalin.http.Context;
import java.sql.SQLException;
import java.util.Collections;

import edu.unam.integrador.modelo.Usuario;

public class UsuariosControlador {
    
    private final UsuariosRepositorio usuariosRepositorio;

    public UsuariosControlador(UsuariosRepositorio usuariosRepositorio) {
        this.usuariosRepositorio = usuariosRepositorio;
        
    }

    public void validarUsuario(Context ctx) throws SQLException {
        String nick = ctx.formParam("nick", String.class).get();
        String clave = ctx.formParam("contrasena", String.class).get();
        var resultado = this.usuariosRepositorio.clave(nick, clave);
        if (resultado) {
            ctx.cookie("nick", nick.trim());
            Usuario usuario = this.usuariosRepositorio.obtener(nick);
            ctx.cookie("rol", usuario.getRol());
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

    public void modificar(Context ctx){
        var modelo = new ModeloUsuario();
        modelo.usuario = this.usuariosRepositorio.obtener(ctx.cookie("nick"));
        modelo.nick = ctx.cookie("nick");
        ctx.render("editarUsuario.jte", Collections.singletonMap("modelo", modelo));
    }

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

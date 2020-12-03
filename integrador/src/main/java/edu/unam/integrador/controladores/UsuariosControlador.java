package edu.unam.integrador.controladores;

import edu.unam.integrador.repositorio.RepositorioException;
import edu.unam.integrador.repositorio.UsuariosRepositorio;
import io.javalin.http.Context;
import java.sql.SQLException;

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
            ctx.redirect("/");
        } else {
            ctx.redirect("/");
        }

    }

}

package edu.unam.integrador.repositorio;

import java.util.List;
import edu.unam.integrador.modelo.Usuario;

public interface UsuariosRepositorio {

    List<Usuario> listar() throws RepositorioException;

    int crear(Usuario usuario) throws RepositorioException;

    boolean borrar(Usuario usuario) throws RepositorioException;

    Usuario obtener(int id) throws RepositorioException;

    void actualizar(Usuario usuario) throws RepositorioException;

    boolean clave(String nick, String contrasena) throws RepositorioException;
}
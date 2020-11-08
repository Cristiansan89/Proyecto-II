package edu.unam.integrador.repositorio;

import java.util.List;
import edu.unam.integrador.modelo.Cliente;

public interface ClientesRepositorio {

    List<Cliente> listar() throws RepositorioException;
    int crear (Cliente cliente) throws RepositorioExceeption;
    /*boolean borrar (Cliente cliente) throws RepositorioException;
    Cliente obtener (int id) throws RepositorioException;
*/
}


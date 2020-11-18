package edu.unam.integrador.repositorio;

import java.util.List;
import edu.unam.integrador.modelo.Producto;
public interface ProductosRepositorio {
    
    List<Producto> listar() throws RepositorioException;
    int crear(Producto producto) throws RepositorioException;
    boolean borrar(Producto producto) throws RepositorioException;
    boolean modificar(Producto producto) throws RepositorioException;
    Producto obtener(int id) throws RepositorioException;
}

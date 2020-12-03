package edu.unam.integrador.repositorio;

import java.util.List;
import edu.unam.integrador.modelo.DetallePedido;

public interface DetallesPedidosRepositorio {

    List<DetallePedido> listar(int id) throws RepositorioException;
    int crear(DetallePedido detallePedido) throws RepositorioException;
    boolean borrar(DetallePedido detallePedido) throws RepositorioException;
    DetallePedido obtener(int id) throws RepositorioException;
    void actualizar(DetallePedido detallePedido) throws RepositorioException;
}

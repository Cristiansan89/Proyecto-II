package edu.unam.integrador.repositorio;

import java.util.List;
import edu.unam.integrador.modelo.Pedido;
import edu.unam.integrador.modelo.Producto;

public interface PedidosRepositorio {

    List<Pedido> listar() throws RepositorioException;
    List<Producto> listarProducto() throws RepositorioException;
    int nuevo(int id) throws RepositorioException;
    int crear(Pedido pedido) throws RepositorioException;
    // boolean anular(Pedido pedido) throws RepositorioException;
    Pedido obtener(int id) throws RepositorioException;
    Pedido obtenerClientePedido(String nick) throws RepositorioException;
    Pedido obtenerCliente(int id) throws RepositorioException;
    Pedido finalizar(Pedido pedido) throws RepositorioException;
}
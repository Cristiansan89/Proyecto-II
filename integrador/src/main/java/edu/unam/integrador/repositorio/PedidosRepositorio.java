package edu.unam.integrador.repositorio;

import java.util.List;
import edu.unam.integrador.modelo.Pedido;
import edu.unam.integrador.modelo.Producto;

public interface PedidosRepositorio {

    int nuevo(int id) throws RepositorioException;
    int crear(Pedido pedido) throws RepositorioException;
    Pedido obtener(int id) throws RepositorioException;
    Pedido obtenerCliente(int id) throws RepositorioException;
    Pedido finalizar(Pedido pedido) throws RepositorioException;
    public void entragado(Pedido pedido) throws RepositorioException;
    public void cancelar(Pedido pedido) throws RepositorioException;
    List<Pedido> listar() throws RepositorioException;
    List<Pedido> listarPedidoCliente(int idCliente) throws RepositorioException;
    List<Producto> listarProducto() throws RepositorioException;
    
}


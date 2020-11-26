package edu.unam.integrador.repositorio;

import java.util.List;
import edu.unam.integrador.modelo.DetallePedido;
import edu.unam.integrador.modelo.Pedido;

public class PedidosRepositorio {
    List<Pedido> listar() throws RepositorioException;
    int crear(Pedido pedido) throws RepositorioException;
    boolean borrar(Pedido pedido) throws RepositorioException;
    Cliente obtener(int id) throws RepositorioException;
    void actualizar(Pedido pedido) throws RepositorioException;
}

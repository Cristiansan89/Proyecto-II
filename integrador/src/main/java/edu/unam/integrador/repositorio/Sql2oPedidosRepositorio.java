
package edu.unam.integrador.repositorio;

import java.util.List;

import org.sql2o.Connection;
import org.sql2o.Sql2o;
import org.sql2o.Sql2oException;

import edu.unam.integrador.modelo.Pedido;
import edu.unam.integrador.modelo.Producto;

public class Sql2oPedidosRepositorio implements PedidosRepositorio {

    private final Sql2o sql2o;

    public Sql2oPedidosRepositorio(Sql2o sql2o) {
        this.sql2o = sql2o;
    }

    @Override
    public int nuevo(int id) {
        return 1;
    }

    @Override
    public List<Pedido> listar() throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "SELECT * FROM pedido;";
            return conn.createQuery(sql).throwOnMappingFailure(false).executeAndFetch(Pedido.class);
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public List<Producto> listarProducto() throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "SELECT * FROM Producto;";
            return conn.createQuery(sql).throwOnMappingFailure(false).executeAndFetch(Producto.class);
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public int crear(Pedido pedido) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "INSERT INTO Pedido (fecha, hora, totalPagar, \"idCliente\", estado) VALUES (current_date, CONCAT(extract(hour from now())::text,':', extract(minute from now())::text), 0,:clienteId, false);";
            return (int) conn.createQuery(sql).bind(pedido)
                    .addParameter("clienteId", pedido.getCliente().getIdCliente()).executeUpdate().getKey();
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public Pedido obtener(int id) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "SELECT * FROM pedido WHERE \"idPedido\" = :idPedido;";
            return conn.createQuery(sql).addParameter("idPedido", id).throwOnMappingFailure(false)
                    .executeAndFetchFirst(Pedido.class);
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public Pedido finalizar(Pedido pedido) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "UPDATE pedido set  estado=:estado WHERE \"idPedido\" = :idPedido;";
            conn.createQuery(sql).bind(pedido).addParameter("idPedido", pedido.getIdPedido()).executeUpdate().getKey();
            return pedido;
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }
}
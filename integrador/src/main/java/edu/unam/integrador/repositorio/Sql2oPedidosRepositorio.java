
package edu.unam.integrador.repositorio;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.sql2o.Connection;
import org.sql2o.Sql2o;
import org.sql2o.Sql2oException;

import edu.unam.integrador.modelo.Pedido;
import edu.unam.integrador.modelo.Producto;

public class Sql2oPedidosRepositorio implements PedidosRepositorio {

    private final Sql2o sql2o;
    private final ClientesRepositorio clientesRepositorio;

    
    public Sql2oPedidosRepositorio(Sql2o sql2o, ClientesRepositorio clientesRepositorio) {
        this.sql2o = sql2o;
        this.clientesRepositorio = clientesRepositorio;
    }

    @Override
    public int nuevo(int id) {
        return 1;
    }

    @Override
    public List<Pedido> listar() throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            var pedidos = new ArrayList<Pedido>();
            String sql = "SELECT * FROM pedido where estado = 'true';";
            var resultado = conn.createQuery(sql).executeAndFetchTable().asList();
            for (var o : resultado) {
                var cliente = this.clientesRepositorio.obtener((int) o.get("idcliente"));
                var pedido = new Pedido ((Date) o.get("fecha"), (String) o.get("hora"), (Double) o.get("descuento"), (Double) o.get("totalpagar"), cliente, (boolean) o.get("estado"));
                pedido.setIdPedido((int) o.get("idpedido"));
                pedido.setCliente(cliente);
                pedidos.add(pedido);
            }
            return pedidos;
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }
/*
    @Override
    public List<Pedido> listarTodo(int idPedido) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "SELECT * FROM pedido where idPedido = :idPedido;";
            return conn.createQuery(sql).addParameter("idPedido", idPedido).throwOnMappingFailure(false).executeAndFetch(Pedido.class);
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }
*/
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
            String sql = "INSERT INTO Pedido (fecha, hora, descuento, totalPagar, \"idCliente\", estado) VALUES (current_date, CONCAT(extract(hour from now())::text,':', extract(minute from now())::text), :descuento, 0, :idCliente, false);";
            return (int) conn.createQuery(sql).bind(pedido).addParameter("idCliente", pedido.getCliente().getIdCliente()).executeUpdate().getKey();
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public Pedido obtener(int id) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "SELECT * FROM Pedido WHERE \"idPedido\" = :idPedido;";
            return conn.createQuery(sql).addParameter("idPedido", id).throwOnMappingFailure(false)
                    .executeAndFetchFirst(Pedido.class);
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    

    @Override
    public Pedido obtenerCliente(int id) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "SELECT * FROM Pedido WHERE cliente.\"idCliente\" = pedido.\"idCliente\";";
            return conn.createQuery(sql).addParameter("idCliente", id).throwOnMappingFailure(false)
                    .executeAndFetchFirst(Pedido.class);
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public Pedido finalizar(Pedido pedido) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "UPDATE pedido set  estado = :estado, totalpagar = :totalPagar WHERE \"idPedido\" = :idPedido;";
            conn.createQuery(sql).bind(pedido).addParameter("idPedido", pedido.getIdPedido()).executeUpdate().getKey();
            return pedido;
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    
}
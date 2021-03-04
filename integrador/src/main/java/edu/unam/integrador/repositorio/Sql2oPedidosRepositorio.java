
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
    public int crear(Pedido pedido) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "INSERT INTO Pedido (fecha, hora, descuento, totalPagar, \"idCliente\", estado, condicion) VALUES (current_date, CONCAT(extract(hour from current_timestamp),':', extract(minute from current_timestamp)), :descuento, 0, :idCliente, false, 'En Espera');";
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

    @Override
    public void entragado(Pedido pedido) throws RepositorioException{
        String sql = "UPDATE pedido SET condicion= 'Entregado' Where \"idPedido\" = :idPedido";
        try (Connection conn = sql2o.open()) {
            conn.createQuery(sql)
                    .addParameter("idPedido", pedido.getIdPedido())
                    .executeUpdate();
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public void cancelar(Pedido pedido) throws RepositorioException{
        String sql = "UPDATE pedido SET condicion= 'Cancelado' Where \"idPedido\" = :idPedido";
        try (Connection conn = sql2o.open()) {
            conn.createQuery(sql)
                .addParameter("idPedido", pedido.getIdPedido())
                .executeUpdate();
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public List<Pedido> listar() throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            var pedidos = new ArrayList<Pedido>();
            String sql = "SELECT * FROM pedido where estado = 'true';";
            var resultado = conn.createQuery(sql).executeAndFetchTable().asList();
            for (var o : resultado) {
                var cliente = this.clientesRepositorio.obtener((int) o.get("idcliente"));
                var pedido = new Pedido ((Date) o.get("fecha"), (String) o.get("hora"), (Double) o.get("descuento"), (Double) o.get("totalpagar"), cliente, (boolean) o.get("estado"), (String) o.get("condicion"));
                pedido.setIdPedido((int) o.get("idpedido"));
                pedido.setCliente(cliente);
                pedidos.add(pedido);
            }
            return pedidos;
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public List<Pedido> listarPedidoCliente(int idCliente) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "SELECT * FROM pedido where \"idCliente\" = :idCliente and estado = 'true';";
            return conn.createQuery(sql).addParameter("idCliente", idCliente).throwOnMappingFailure(false).executeAndFetch(Pedido.class);
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }
    
    @Override
    public List<Producto> listarProducto() throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "SELECT * FROM Producto Order By \"idProducto\";";
            return conn.createQuery(sql).throwOnMappingFailure(false).executeAndFetch(Producto.class);
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }


}
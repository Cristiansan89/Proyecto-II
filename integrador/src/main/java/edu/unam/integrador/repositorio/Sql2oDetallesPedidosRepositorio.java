
package edu.unam.integrador.repositorio;

import java.util.ArrayList;
import java.util.List;

import javax.xml.namespace.QName;

import org.sql2o.Connection;
import org.sql2o.Sql2o;
import org.sql2o.Sql2oException;

import edu.unam.integrador.modelo.DetallePedido;
import edu.unam.integrador.modelo.Pedido;
import edu.unam.integrador.repositorio.PedidosRepositorio;
import edu.unam.integrador.repositorio.ProductosRepositorio;

public class Sql2oDetallesPedidosRepositorio implements DetallesPedidosRepositorio {

    private final Sql2o sql2o;
    private final PedidosRepositorio pedidospRepositorio;
    private final ProductosRepositorio productosRepositorio;

    public Sql2oDetallesPedidosRepositorio(Sql2o sql2o, PedidosRepositorio pedidospRepositorio, ProductosRepositorio productosRepositorio) {
        this.sql2o = sql2o;
        this.pedidospRepositorio = pedidospRepositorio;
        this.productosRepositorio = productosRepositorio;
    }

    @Override
    public List<DetallePedido> listar(int id) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            var detalles = new ArrayList<DetallePedido>();
            String sql = "SELECT * FROM detallepedido where detallepedido.idpedido = :id;";
            var resultado = conn.createQuery(sql).addParameter("id", id).executeAndFetchTable().asList();
            for (var o : resultado) {
                var pedido = this.pedidospRepositorio.obtener((int) o.get("idpedido"));
                var producto = this.productosRepositorio.obtener((int) o.get("idproducto"));
                var detalle = new DetallePedido((int) o.get("cantidad"), pedido, producto);
                detalle.setIdDetallePedido((int) o.get("iddetallepedido"));
                detalles.add(detalle);
            }
            return detalles;
        } catch (Sql2oException e) {
            System.out.println(e);
            throw new RepositorioException();
        }
    }

    @Override
    public int crear(DetallePedido detallePedido) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "INSERT INTO detallepedido(cantidad,idpedido,idproducto) VALUES (:cantidad, :idpedido, :idproducto);";
            return (int) conn.createQuery(sql).bind(detallePedido)
                    .addParameter("idproducto", detallePedido.getProducto().getIdProducto())
                    .addParameter("idpedido", detallePedido.getPedido().getIdPedido()).executeUpdate().getKey();
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public DetallePedido obtener(int id) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "SELECT * FROM DetallePedido WHERE \"idDetallePedido\" = :idDetallePedido;";
            return conn.createQuery(sql).addParameter("idDetallePedido", id).throwOnMappingFailure(false)
                    .executeAndFetchFirst(DetallePedido.class);
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public boolean borrar(DetallePedido detallePedido) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "DELETE FROM DetallePedido WHERE \"idDetallePedido\" = :idDetallePedido;";
            int filas = (int) conn.createQuery(sql).addParameter("idDetallePedido", detallePedido.getIdDetallePedido())
                    .executeUpdate().getResult();
            return filas > 0;
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public void actualizar(DetallePedido detallePedido) throws RepositorioException {
        String sql = "UPDATE DetallePedido SET  WHERE \"idDetallePedido\" = :idDetallePedido;";
        try (Connection conn = sql2o.open()) {
            conn.createQuery(sql).addParameter("idDetallePedido", detallePedido.getIdDetallePedido()).executeUpdate();
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

}

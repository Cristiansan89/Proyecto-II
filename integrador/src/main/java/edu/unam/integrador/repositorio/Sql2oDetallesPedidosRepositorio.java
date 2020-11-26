
package edu.unam.integrador.repositorio;

import java.util.List;

import org.sql2o.Connection;
import org.sql2o.Sql2o;
import org.sql2o.Sql2oException;

import edu.unam.integrador.modelo.DetallePedido;

public class Sql2oDetallesPedidosRepositorio implements DetallesPedidosRepositorio {
    
    private final Sql2o sql2o;

    public Sql2oDetallesPedidosRepositorio(Sql2o sql2o) {
        this.sql2o = sql2o;
    }

    /*
    @Override
    public List<DetallePedido> listar() throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "SELECT * FROM DetallePedido;";
            return conn.createQuery(sql).throwOnMappingFailure(false).executeAndFetch(DetallePedido.class);
        } catch (Sql2oException e) {
            System.out.println(e);
            throw new RepositorioException();
        }
    }

    @Override
    public int crear(DetallePedido detallePedido) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "INSERT INTO DetallePedido() VALUES ();";
            return (int) conn.createQuery(sql).bind(detallePedido).executeUpdate().getKey();
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public DetallePedido obtener(int id) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "SELECT * FROM DetallePedido WHERE \"idDetallePedido\" = :idDetallePedido;";
            return conn.createQuery(sql).addParameter("idDetallePedido", id).throwOnMappingFailure(false).executeAndFetchFirst(DetallePedido.class);
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public boolean borrar(DetallePedido detallePedido) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "DELETE FROM DetallePedido WHERE \"idDetallePedido\" = :idDetallePedido;";
            int filas = (int) conn.createQuery(sql).addParameter("idDetallePedido", DetallePedido.getIdDetallePedido()).executeUpdate().getResult();
            return filas > 0;
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public void actualizar(DetallePedido detallePedido) throws RepositorioException {
        String sql = "UPDATE DetallePedido SET  WHERE \"idDetallePedido\" = :idDetallePedido;";
        try (Connection conn = sql2o.open()) {
            conn.createQuery(sql)
                .addParameter("idDetallePedido", DetallePedido.getIdDetallePedido())
                .executeUpdate();
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }
    */ 
}

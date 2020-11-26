package edu.unam.integrador.repositorio;

import java.util.List;

import org.sql2o.Connection;
import org.sql2o.Sql2o;
import org.sql2o.Sql2oException;

import edu.unam.integrador.modelo.Producto;

public class Sql2oProductosRepositorio implements ProductosRepositorio {

    private final Sql2o sql2o;

    public Sql2oProductosRepositorio(Sql2o sql2o) {
        this.sql2o = sql2o;
    }

    @Override
    public List<Producto> listar() throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "SELECT * FROM Producto;";
            return conn.createQuery(sql).throwOnMappingFailure(false).executeAndFetch(Producto.class);
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public int crear(Producto producto) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "INSERT INTO producto (codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle) VALUES (:codProducto, :categoria, :marca, :medida, :unidad, :stock, :precioUnitario, :detalle);";
            return (int) conn.createQuery(sql).bind(producto).executeUpdate().getKey();
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public Producto obtener(int id) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "SELECT * FROM Producto WHERE \"idProducto\" = :idProducto;";
            return conn.createQuery(sql).addParameter("idProducto", id).throwOnMappingFailure(false)
                    .executeAndFetchFirst(Producto.class);
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public boolean borrar(Producto producto) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "DELETE FROM Producto WHERE \"idProducto\" = :idProducto;";
            int filas = (int) conn.createQuery(sql).addParameter("idProducto", producto.getIdProducto()).executeUpdate()
                    .getResult();
            return filas > 0;
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public boolean modificar(Producto producto) throws RepositorioException {
        return false;
    }

    @Override
    public void actualizar(Producto producto) throws RepositorioException {
        String sql = "UPDATE producto SET  codproducto= :codproducto, categoria= :categoria, marca= :marca, medida= :medida, unidad= :unidad, stock= :stock, preciounitario= :preciounitario, detalle= :detalle WHERE \"idProducto\" = :idProducto;";
        try (Connection conn = sql2o.open()) {
            conn.createQuery(sql).addParameter("idProducto", producto.getIdProducto())
                    .addParameter("codproducto", producto.getCodProducto())
                    .addParameter("categoria", producto.getCategoria()).addParameter("marca", producto.getMarca())
                    .addParameter("medida", producto.getMedida()).addParameter("unidad", producto.getUnidad())
                    .addParameter("stock", producto.getStock())
                    .addParameter("preciounitario", producto.getPrecioUnitario())
                    .addParameter("detalle", producto.getDetalle()).executeUpdate();
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }
}

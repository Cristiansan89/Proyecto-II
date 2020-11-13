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
            String sql = "INSERT INTO Producto(codproducto, categoria, marca, madida, unidad, stock , detalle) VALUES (:codproducto, :categoria, :marca, :madida, :unidad, :stock , :detalle);";
            return (int) conn.createQuery(sql).bind(producto).executeUpdate().getKey();
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public Producto obtener(int id) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "SELECT * FROM Producto WHERE id = :id;";
            return conn.createQuery(sql).addParameter("id", id).throwOnMappingFailure(false)
                    .executeAndFetchFirst(Producto.class);
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public boolean borrar(Producto producto) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "DELETE FROM Producto WHERE id = : id;";
            int filas = (int) conn.createQuery(sql).addParameter("id", producto.getIdProducto()).executeUpdate()
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
}

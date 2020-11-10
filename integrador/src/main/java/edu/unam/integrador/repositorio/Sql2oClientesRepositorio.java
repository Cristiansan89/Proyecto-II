package edu.unam.integrador.repositorio;

import java.util.List;

import org.sql2o.Connection;
import org.sql2o.Sql2o;
import org.sql2o.Sql2oException;


import edu.unam.integrador.modelo.Cliente;

public class Sql2oClientesRepositorio implements ClientesRepositorio {

    private final Sql2o sql2o;

    public Sql2oClientesRepositorio(Sql2o sql2o) {
        this.sql2o = sql2o;
    }

    @Override
    public List<Cliente> listar() throws RepositorioException {
        try (Connection conn = sql2o.open()){
            String sql = "SELECT * FROM Clientes;";
            return conn.createQuery(sql).throwOnMappingFailure(false).executeAndFetch(Cliente.class);
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public int crear(Cliente cliente) throws RepositorioException {
        try (Connection conn = sql2o.open()){
            String sql = "INSERT INTO Cliente(id, nombre, cuil, domicilio, telefono) VALUES (:nombre);";
            return (int) conn.createQuery(sql)
                .bind(cliente)
                .executeUpdate()
                .getKey();
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public Cliente obtener(int id) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "SELECT * FROM Cliente WHERE id = :id;";
            return conn.createQuery(sql)
                .addParameter("id", id)
                .throwOnMappingFailure(false)
                .executeAndFetchFirst(Cliente.class);
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public boolean borrar(Cliente cliente) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "DELETE FROM Cliente WHERE id = : id;";
            int filas = (int) conn.createQuery(sql)
                .addParameter("id", cliente.getIdCliente())
                .executeUpdate()
                .getResult();
            return filas > 0;
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public boolean modificar(Cliente cliente) throws RepositorioException {
        return false;
    }
}

package edu.unam.integrador.repositorio;

import java.util.List;

import org.sql2o.Connection;
import org.sql2o.Sql2o;
import org.sql2o.Sql2oException;

import edu.unam.integrador.modelo.ClientePreferencial;

public class Sql2oClientesPreferencialRepositorio implements ClientesPreferencialRepositorio {

    private final Sql2o sql2o;

    public Sql2oClientesPreferencialRepositorio(Sql2o sql2o) {
        this.sql2o = sql2o;
    }

    @Override
    public List<ClientePreferencial> listar() throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "SELECT * FROM ClientePreferencial;";
            return conn.createQuery(sql).throwOnMappingFailure(false).executeAndFetch(ClientePreferencial.class);
        } catch (Sql2oException e) {
            System.out.println(e);
            throw new RepositorioException();
        }
    }

    @Override
    public int crear(ClientePreferencial clientePreferencial) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "INSERT INTO ClientePreferencial(descuento, \"idCliente\") VALUES (0, :idCliente);";
            return (int) conn.createQuery(sql).bind(clientePreferencial)
                .addParameter("idCliente", clientePreferencial.getCliente().getIdCliente()).executeUpdate().getKey();
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }
    
    @Override
    public boolean borrar(ClientePreferencial clientePreferencial) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "DELETE FROM ClientePreferencial WHERE \"idClientePreferencial\" = :idClientePreferencial;";
            int filas = (int) conn.createQuery(sql).addParameter("idClientePreferencial", clientePreferencial.getIdClientePreferencial()).executeUpdate()
                    .getResult();
            return filas > 0;
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public ClientePreferencial obtener(int id) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "SELECT * FROM ClientePreferencial WHERE \"idClientePreferencial\" = :idClientePreferencial;";
            return conn.createQuery(sql).addParameter("idClientePreferencial", id).throwOnMappingFailure(false)
                    .executeAndFetchFirst(ClientePreferencial.class);
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }
    
    @Override
    public ClientePreferencial obtenerCliente(int id) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "SELECT * FROM ClientePreferencial WHERE \"idCliente\" = :idCliente;";
            return conn.createQuery(sql).addParameter("idCliente", id).throwOnMappingFailure(false)
                    .executeAndFetchFirst(ClientePreferencial.class);
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

}

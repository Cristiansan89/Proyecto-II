
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
        try (Connection conn = sql2o.open()) {
            String sql = "SELECT * FROM Cliente;";
            return conn.createQuery(sql).throwOnMappingFailure(false).executeAndFetch(Cliente.class);
        } catch (Sql2oException e) {
            System.out.println(e);
            throw new RepositorioException();
        }
    }

    @Override
    public int crear(Cliente cliente) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "INSERT INTO Cliente(nombre, apellido, cuil, domicilio, telefono, \"fechaIngreso\") VALUES (:nombre, :apellido, :cuil, :domicilio, :telefono, current_date);";
            return (int) conn.createQuery(sql).bind(cliente).executeUpdate().getKey();
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public Cliente obtener(int id) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "SELECT * FROM Cliente WHERE \"idCliente\" = :idCliente;";
            return conn.createQuery(sql).addParameter("idCliente", id).throwOnMappingFailure(false)
                    .executeAndFetchFirst(Cliente.class);
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public Cliente obtenerClientePedido(int id) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "SELECT Cliente.\"idCliente\" FROM Pedido, Cliente WHERE pedido.\"idCliente\" = cliente.\"idCliente\" AND pedido.\"idPedido\" = :id;";
            return conn.createQuery(sql).addParameter("id", id).throwOnMappingFailure(false).executeAndFetchFirst(Cliente.class);
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public boolean borrar(Cliente cliente) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "DELETE FROM Cliente WHERE \"idCliente\" = :idCliente;";
            int filas = (int) conn.createQuery(sql).addParameter("idCliente", cliente.getIdCliente()).executeUpdate()
                    .getResult();
            return filas > 0;
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public void actualizar(Cliente cliente) throws RepositorioException {
        String sql = "UPDATE cliente SET  nombre= :nombre, apellido= :apellido, cuil= :cuil, domicilio= :domicilio, telefono= :telefono WHERE \"idCliente\" = :idCliente;";
        try (Connection conn = sql2o.open()) {
            conn.createQuery(sql).addParameter("idCliente", cliente.getIdCliente())
                    .addParameter("nombre", cliente.getNombre()).addParameter("apellido", cliente.getApellido())
                    .addParameter("cuil", cliente.getCuil()).addParameter("domicilio", cliente.getDomicilio())
                    .addParameter("telefono", cliente.getTelefono()).executeUpdate();
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public Cliente obtenerCliente(String nick) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "SELECT * FROM Usuario WHERE nick = :nick;";
            return conn.createQuery(sql).addParameter("nick", nick).throwOnMappingFailure(false)
                    .executeAndFetchFirst(Cliente.class);
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

}

package edu.unam.integrador.repositorio;

import java.util.List;

import org.sql2o.Connection;
import org.sql2o.Sql2o;

import edu.unam.integrador.modelo.Cliente;

public class Sql2oClientesRepositorio implements ClientesRepositorio{

    private final Sql2o sql2o;

    public Sql2oClientesRepositorio(Sql2o sql2o) {
        this.sql2o = sql2o;
    }

    @Override
    public List<Cliente> listar() throws RepositorioException {
        try (Connection conn = sql2o.open()){
            String sql = "SELECT * FROM Clientes;";
            return conn.createQuery(sql).throwOnMappingFailure(false).executeAndFetch(Cliente.class);
        }
    }

    @Override
    public int crear(Cliente cliente) throws RepositorioException {
        try (Connection conn = sql2o.open()){
            String sql = "INSERT INTO Cliente(nombre) VALUES (:nombre);";
            return (int) conn.createQuery(sql)
                .bind(cliente)
                .executeUpdate()
                .getKey();
        }
    }

   
}

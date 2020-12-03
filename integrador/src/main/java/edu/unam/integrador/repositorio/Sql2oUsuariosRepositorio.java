package edu.unam.integrador.repositorio;

import java.util.List;

import org.sql2o.Connection;
import org.sql2o.Sql2o;
import org.sql2o.Sql2oException;

import edu.unam.integrador.modelo.Usuario;

public class Sql2oUsuariosRepositorio implements UsuariosRepositorio {

    private final Sql2o sql2o;

    public Sql2oUsuariosRepositorio(Sql2o sql2o) {
        this.sql2o = sql2o;
    }

    @Override
    public List<Usuario> listar() throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "SELECT * FROM Usuario;";
            return conn.createQuery(sql).throwOnMappingFailure(false).executeAndFetch(Usuario.class);
        } catch (Sql2oException e) {
            System.out.println(e);
            throw new RepositorioException();
        }
    }

    @Override
    public int crear(Usuario usuario) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "INSERT INTO Usuario(mail, nick, contrasena,  \"idCliente\") VALUES (:mail, :nick, PGP_SYM_ENCRYPT(:contrasena, 'AES_KEY'), :idCliente);";
            return (int) conn.createQuery(sql).bind(usuario)
                    .addParameter("idCliente", usuario.getCliente().getIdCliente()).executeUpdate().getKey();
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public Usuario obtener(int id) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "SELECT * FROM Usuario WHERE \"idUsuario\" = :idUsuario;";
            return conn.createQuery(sql).addParameter("idUsuario", id).throwOnMappingFailure(false)
                    .executeAndFetchFirst(Usuario.class);
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public boolean borrar(Usuario usuario) throws RepositorioException {
        try (Connection conn = sql2o.open()) {
            String sql = "DELETE FROM Usuario WHERE \"idUsuario\" = :idUsuario;";
            int filas = (int) conn.createQuery(sql).addParameter("idUsuario", usuario.getIdUsuario()).executeUpdate()
                    .getResult();
            return filas > 0;
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public void actualizar(Usuario usuario) throws RepositorioException {
        String sql = "UPDATE Usuario SET  mail= :mail, nick= :nick, contrasena = (PGP_SYM_ENCRYPT(:contrasena, 'AES_KEY')) WHERE \"idUsuario\" = :idUsuario;";
        try (Connection conn = sql2o.open()) {
            conn.createQuery(sql).addParameter("idUsuario", usuario.getIdUsuario())
                    .addParameter("mail", usuario.getMail()).addParameter("nick", usuario.getNick())
                    .addParameter("contrasena", usuario.getContrasena());
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }
    }

    @Override
    public boolean clave(String nick, String contrasena) throws RepositorioException {
        String sql = "SELECT COUNT(*) AS coincidencias  FROM Usuario Where nick = :nick AND PGP_SYM_DECRYPT(contrasena::bytea, 'AES_KEY') = :contrasena;";
        try (Connection conn = sql2o.open()) {
            int resultado = (int) conn.createQuery(sql).addParameter("nick", nick)
                    .addParameter("contrasena", contrasena).executeScalar(Integer.class);
            if (resultado == 1) {
                return true;
            } else {
                return false;
            }
        } catch (Sql2oException e) {
            throw new RepositorioException();
        }

    }
}

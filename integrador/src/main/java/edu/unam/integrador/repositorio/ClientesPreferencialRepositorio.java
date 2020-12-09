package edu.unam.integrador.repositorio;


import java.util.List;
import edu.unam.integrador.modelo.ClientePreferencial;

public interface ClientesPreferencialRepositorio {
    
    public List<ClientePreferencial> listar();
    public int crear(ClientePreferencial clientePreferencial);
    public boolean borrar(ClientePreferencial clientePreferencialario);
    public void actualizar(ClientePreferencial clientePreferencial);
    public ClientePreferencial obtener(int id);
    public ClientePreferencial obtenerClientePreferencial(int idCliente);

}

package edu.unam.integrador.repositorio;


import java.util.List;
import edu.unam.integrador.modelo.ClientePreferencial;

public interface ClientesPreferencialRepositorio {
    
    List<ClientePreferencial> listar();
    int crear(ClientePreferencial clientePreferencial);
    boolean borrar(ClientePreferencial clientePreferencialario);
    ClientePreferencial obtener(int id);
    ClientePreferencial obtenerCliente(int id);
    
}

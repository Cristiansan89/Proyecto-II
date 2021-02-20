package edu.unam.integrador.paginas;

import java.util.ArrayList;
import java.util.List;
import edu.unam.integrador.modelo.Pedido;

public class ModeloPedidos {
    public int idCliente;
    public String rol;
    public int idProducto;
    public List<Pedido> pedidos = new ArrayList<>();
}

package edu.unam.integrador.paginas;

import java.util.ArrayList;
import java.util.List;
import edu.unam.integrador.modelo.DetallePedido;
import edu.unam.integrador.modelo.Producto;


public class ModeloDetallesPedidos {
    public int idPedido;
    public List<DetallePedido> detallePedidos = new ArrayList<>();
    public List<Producto> productos = new ArrayList<>();
}

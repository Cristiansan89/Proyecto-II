package edu.unam.integrador.paginas;

import java.util.ArrayList;
import java.util.List;
import edu.unam.integrador.modelo.DetallePedido;
import edu.unam.integrador.modelo.Producto;


public class ModeloDetallesPedidos {
    public int idDetallePedido;
    public int idPedido;
    public int idProducto;
    public String apellido;
    public String nombre;
    public String cuil;
    public String domicilio;
    public String telefono;
    public List<DetallePedido> detallePedidos = new ArrayList<>();
    public List<Producto> productos = new ArrayList<>();
    public double valdescuento;
    public double descuento;
    public double subtotal;
    public double total;
}

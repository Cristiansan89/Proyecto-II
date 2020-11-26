package edu.unam.integrador.controladores;

import io.javalin.http.Context;
import java.sql.SQLException;
import java.util.Collections;
import java.util.Date;

import edu.unam.integrador.paginas.ModeloPedido;
import edu.unam.integrador.paginas.ModeloDetallePedido;
import edu.unam.integrador.modelo.Pedido;
import edu.unam.integrador.modelo.DetallePedido;
import edu.unam.integrador.paginas.ModeloPedidos;
import edu.unam.integrador.paginas.ModeloProductos;
import edu.unam.integrador.paginas.ModeloDetallesPedidos;
import edu.unam.integrador.repositorio.PedidosRepositorio;
import edu.unam.integrador.repositorio.ProductosRepositorio;
import edu.unam.integrador.repositorio.ClientesRepositorio;
import edu.unam.integrador.repositorio.DetallesPedidosRepositorio;
import edu.unam.integrador.repositorio.RepositorioException;
public class PedidosControlador {

    private final PedidosRepositorio pedidosRepositorio;
    private final ClientesRepositorio clientesRepositorio;
    private final ProductosRepositorio productosRepositorio;
  //  private final DetallesPedidosRepositorio detallesPedidosRepositorio;

    public PedidosControlador(PedidosRepositorio pedidosRepositorio, ClientesRepositorio clientesRepositorio, ProductosRepositorio productosRepositorio/*, DetallesPedidosRepositorio detallesPedidosRepositorio*/) {
        this.pedidosRepositorio = pedidosRepositorio;
        this.clientesRepositorio = clientesRepositorio;
        this.productosRepositorio = productosRepositorio;
       /* this.detallesPedidosRepositorio = detallesPedidosRepositorio;*/
    }

    public void listar(Context ctx) throws SQLException {
        var modelo = new ModeloPedidos();
        modelo.pedidos = pedidosRepositorio.listar();
        ctx.render("pedidos.jte", Collections.singletonMap("modelo", modelo));
    }

    public void listarProducto(Context ctx) throws SQLException {
        var modelo = new ModeloProductos();
        modelo.productos = pedidosRepositorio.listarProducto();
        modelo.nombreUsuario = ctx.cookie("nombreUsuario");
        ctx.render("formularioPedido.jte", Collections.singletonMap("modelo", modelo));
    }

    public void nuevo(Context ctx) throws SQLException {   
        ctx.render("crearPedido.jte");
    }
 
    public void agregar(Context ctx) throws SQLException {

    }

    public void crear(Context ctx) throws SQLException {
        //Poner en estado de solicitud de pedido "No realizado"
        var pedido = new Pedido();
        var id = this.pedidosRepositorio.crear(pedido);
        ctx.redirect("/pedidos/nuevo/"+String.valueOf(id));
    }

}

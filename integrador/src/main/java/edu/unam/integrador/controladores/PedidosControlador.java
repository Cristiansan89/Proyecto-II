package edu.unam.integrador.controladores;

import io.javalin.http.Context;
import java.sql.SQLException;
import java.util.Collections;

import edu.unam.integrador.modelo.Pedido;
import edu.unam.integrador.modelo.DetallePedido;
import edu.unam.integrador.paginas.ModeloPedidos;
import edu.unam.integrador.paginas.ModeloProductos;
import edu.unam.integrador.paginas.ModeloDetallesPedidos;
import edu.unam.integrador.repositorio.PedidosRepositorio;
import edu.unam.integrador.repositorio.ProductosRepositorio;
import edu.unam.integrador.repositorio.ClientesPreferencialRepositorio;
import edu.unam.integrador.repositorio.ClientesRepositorio;
import edu.unam.integrador.repositorio.DetallesPedidosRepositorio;
import edu.unam.integrador.repositorio.RepositorioException;

public class PedidosControlador {

    private final PedidosRepositorio pedidosRepositorio;
    private final ClientesRepositorio clientesRepositorio;
    private final ProductosRepositorio productosRepositorio;
    private final DetallesPedidosRepositorio detallesPedidosRepositorio;
    private final ClientesPreferencialRepositorio clientesPreferencialRepositorio;

    public PedidosControlador(PedidosRepositorio pedidosRepositorio, ClientesRepositorio clientesRepositorio,
        ProductosRepositorio productosRepositorio, DetallesPedidosRepositorio detallesPedidosRepositorio,
        ClientesPreferencialRepositorio clientesPreferencialRepositorio) {
            this.pedidosRepositorio = pedidosRepositorio;
            this.clientesRepositorio = clientesRepositorio;
            this.productosRepositorio = productosRepositorio;
            this.detallesPedidosRepositorio = detallesPedidosRepositorio;
            this.clientesPreferencialRepositorio = clientesPreferencialRepositorio;
    }


    public void listar(Context ctx) throws SQLException {
        var modelo = new ModeloPedidos();
        modelo.pedidos = this.pedidosRepositorio.listar();
        ctx.render("pedidos.jte", Collections.singletonMap("modelo", modelo));
    }

    public void listarProducto(Context ctx) throws SQLException {
        var modelo = new ModeloProductos();
        modelo.productos = pedidosRepositorio.listarProducto();
        var cliente = this.clientesRepositorio.obtenerCliente(ctx.cookie("nick"));
        modelo.nombre = cliente.getNombre();
        modelo.apellido = cliente.getApellido();
        ctx.render("formularioPedido.jte", Collections.singletonMap("modelo", modelo));
    }

    public void nuevo(Context ctx) throws SQLException {
        var id = ctx.pathParam("id", Integer.class).get();
        var modelo = new ModeloDetallesPedidos();
        modelo.productos = pedidosRepositorio.listarProducto();
        modelo.detallePedidos = this.detallesPedidosRepositorio.listar(id);
        modelo.subtotal = 0;
        modelo.total = 0;
        modelo.descuento = 0;  
        var cliente = clientesRepositorio.obtenerCliente(ctx.cookie("nick"));
        var obtenerCliente = clientesRepositorio.obtener(cliente.getIdCliente());
        modelo.nombre = obtenerCliente.getNombre();
        modelo.apellido = obtenerCliente.getApellido();
        var preferencial = clientesPreferencialRepositorio.obtenerCliente(cliente.getIdCliente());
        modelo.valdescuento = preferencial.getDescuento();
        for (DetallePedido detalle : modelo.detallePedidos) {
            modelo.subtotal += detalle.getSubTotal();
            modelo.descuento = detalle.getTotalFila();;
            modelo.total = modelo.subtotal - modelo.descuento;
        }
        modelo.idPedido = id;
        ctx.render("formularioPedido.jte", Collections.singletonMap("modelo", modelo));
    }

    public void agregar(Context ctx) throws SQLException {
        var idpedido = ctx.pathParam("id", Integer.class).get();
        Integer idproducto = ctx.formParam("producto", Integer.class).get();
        var cantidad = ctx.formParam("cantidad", Integer.class).get();
        var producto = this.productosRepositorio.obtener(idproducto);
        if (producto.getStock() > cantidad) {
            var pedido = this.pedidosRepositorio.obtener(idpedido);
            var detalle = new DetallePedido(cantidad, pedido, producto);
            this.detallesPedidosRepositorio.crear(detalle);
            ctx.redirect("/pedidos/nuevo/" + String.valueOf(idpedido));
        } else {
            ctx.redirect("/pedidos/nuevo/" + String.valueOf(idpedido));
        }

    }

    public void crear(Context ctx) throws SQLException {
        var modelo = new ModeloDetallesPedidos();
        var cliente = clientesRepositorio.obtenerCliente(ctx.cookie("nick"));
        var pedido = new Pedido(cliente);
        var preferencial = clientesPreferencialRepositorio.obtenerCliente(cliente.getIdCliente());
        modelo.valdescuento = preferencial.getDescuento();
        pedido.setDescuento(preferencial.getDescuento());
        var id = this.pedidosRepositorio.crear(pedido);
        ctx.redirect("/pedidos/nuevo/" + String.valueOf(id));
    }

    public void eliminardetalle(Context ctx) throws SQLException, RepositorioException {
        this.detallesPedidosRepositorio.borrar(this.detallesPedidosRepositorio.obtener(ctx.pathParam("id", Integer.class).get()));
        ctx.redirect("/pedidos/nuevo/" + ctx.pathParam("idpedido", Integer.class).get());
    }

    public void finalizar(Context ctx) throws SQLException, RepositorioException {
        var pedido = this.pedidosRepositorio.obtener(ctx.pathParam("id", Integer.class).get());
        var detallePedidos = this.detallesPedidosRepositorio.listar(pedido.getIdPedido());
        var totalPagar = 0;
        for (DetallePedido detalle : detallePedidos) {
            totalPagar += detalle.getTotalFila();
        }
        pedido.setEstado(true);
        pedido.setTotalPagar(Double.valueOf(totalPagar));
        this.pedidosRepositorio.finalizar(pedido);
        ctx.redirect("/");
    }
    
}

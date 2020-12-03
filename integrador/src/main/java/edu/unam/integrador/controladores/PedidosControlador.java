package edu.unam.integrador.controladores;

import io.javalin.http.Context;
import java.sql.SQLException;
import java.util.Collections;
import java.util.Date;

import edu.unam.integrador.paginas.ModeloPedido;
import edu.unam.integrador.paginas.ModeloDetallePedido;
import edu.unam.integrador.modelo.Pedido;
import edu.unam.integrador.modelo.Cliente;
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
    private final DetallesPedidosRepositorio detallesPedidosRepositorio;

    public PedidosControlador(PedidosRepositorio pedidosRepositorio, ClientesRepositorio clientesRepositorio, ProductosRepositorio productosRepositorio, DetallesPedidosRepositorio detallesPedidosRepositorio) {
        this.pedidosRepositorio = pedidosRepositorio;
        this.clientesRepositorio = clientesRepositorio;
        this.productosRepositorio = productosRepositorio;
        this.detallesPedidosRepositorio = detallesPedidosRepositorio;
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
        var id = ctx.pathParam("id", Integer.class).get();
        var modelo = new ModeloDetallesPedidos();
        modelo.productos = pedidosRepositorio.listarProducto();
        modelo.nombreUsuario = ctx.cookie("nombreUsuario");
        modelo.detallePedidos = this.detallesPedidosRepositorio.listar(id);
        modelo.total = 0;
        for (DetallePedido detalle : modelo.detallePedidos) {
            modelo.total += detalle.getTotalFila();
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
        // Poner en estado de solicitud de pedido "No realizado"
        var cliente = this.clientesRepositorio.obtener(23);
        var pedido = new Pedido(cliente);
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

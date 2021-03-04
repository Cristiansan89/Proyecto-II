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

    // Crea un Pedido Vacíp asociado al Cliente para completar su Detalle de Pedido
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

    // Agrega un Producto en el Detalle de Pedido de un Pedido asociado al Cliente
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

    // Actualiza el subtotal y total en el Detalle de Pedido e renderiza el jte
    public void nuevo(Context ctx) throws SQLException {
        var id = ctx.pathParam("id", Integer.class).get();
        var modelo = new ModeloDetallesPedidos();
        modelo.productos = pedidosRepositorio.listarProducto();
        modelo.detallePedidos = this.detallesPedidosRepositorio.listar(id);
        var cliente = clientesRepositorio.obtenerCliente(ctx.cookie("nick"));
        var obtenerCliente = clientesRepositorio.obtener(cliente.getIdCliente());
        modelo.nombre = obtenerCliente.getNombre();
        modelo.apellido = obtenerCliente.getApellido();
        var preferencial = clientesPreferencialRepositorio.obtenerCliente(cliente.getIdCliente());
        modelo.valdescuento = preferencial.getDescuento();
        double valorSubTotal = 0;
        double totalDescuento = 0;
        double precioTotal = 0;
        for (DetallePedido detalle : modelo.detallePedidos) {
            valorSubTotal += detalle.getSubTotal();
            modelo.subtotal = String.format("%.2f", valorSubTotal);
            totalDescuento = (valorSubTotal * modelo.valdescuento)/100;
            modelo.descuento = String.format("%.2f", totalDescuento);
            precioTotal = Math.round((valorSubTotal - totalDescuento) * 100)/100d;
            modelo.total = String.format("%.2f", precioTotal);
        }
        modelo.idPedido = id;
        ctx.render("formularioPedido.jte", Collections.singletonMap("modelo", modelo));
    }

    // Eliminar un Producto agregado en el Detalle Pedido
    public void eliminardetalle(Context ctx) throws SQLException, RepositorioException {
        this.detallesPedidosRepositorio.borrar(this.detallesPedidosRepositorio.obtener(ctx.pathParam("id", Integer.class).get()));
        ctx.redirect("/pedidos/nuevo/" + ctx.pathParam("idpedido", Integer.class).get());
    }

    // Finalizar el Pedido guardando asi en la BD el Pedido con sus Detalle de Pedido
    public void finalizar(Context ctx) throws SQLException, RepositorioException {
        var modelo = new ModeloDetallesPedidos();
        var pedido = this.pedidosRepositorio.obtener(ctx.pathParam("id", Integer.class).get());
        var detallePedidos = this.detallesPedidosRepositorio.listar(pedido.getIdPedido());
        double totalPagar = 0;
        var cliente = clientesRepositorio.obtenerCliente(ctx.cookie("nick"));
        var obtenerCliente = clientesRepositorio.obtener(cliente.getIdCliente());
        modelo.nombre = obtenerCliente.getNombre();
        modelo.apellido = obtenerCliente.getApellido();
        var preferencial = clientesPreferencialRepositorio.obtenerCliente(cliente.getIdCliente());
        modelo.valdescuento = preferencial.getDescuento();
        double valorSubTotal = 0;
        double totalDescuento = 0;
        double precioTotal = 0;
        for (DetallePedido detalle : detallePedidos) {
            valorSubTotal += detalle.getSubTotal();
            modelo.subtotal = String.format("%.2f", valorSubTotal);
            totalDescuento = (valorSubTotal * modelo.valdescuento)/100;
            modelo.descuento = String.format("%.2f", totalDescuento);
            precioTotal = Math.round((valorSubTotal - totalDescuento) * 100)/100d;
            modelo.total = String.format("%.2f", precioTotal);
        }
        totalPagar += precioTotal;
        pedido.setEstado(true);
        pedido.setTotalPagar(totalPagar);
        this.pedidosRepositorio.finalizar(pedido);
        ctx.redirect("/");
    }
    
    // El Administrador del Sistema da como Entregado el Pedido de Producto al Cliente
    public void entregado(Context ctx) throws SQLException {
        var id = ctx.pathParam("id", Integer.class).get();
        Pedido pedido = this.pedidosRepositorio.obtener(id);
        this.pedidosRepositorio.entragado(pedido);
        ctx.redirect("/pedidos/listapedido");
    }

    // El Cliente puede Cancelar un Pedido realizado
    public void cancelar(Context ctx) throws SQLException {
        var id = ctx.pathParam("id", Integer.class).get();
        Pedido pedido = this.pedidosRepositorio.obtener(id);
        System.out.println(pedido);
        this.pedidosRepositorio.cancelar(pedido);
        ctx.redirect("/pedido/listapedido/cliente/" + String.valueOf(id));
    }

    // Lista los Pedido -> Vista por Administrador
    public void listar(Context ctx) throws SQLException {
        var modelo = new ModeloPedidos();
        modelo.pedidos = this.pedidosRepositorio.listar();
        modelo.rol = ctx.cookie("rol");
        ctx.render("pedidos.jte", Collections.singletonMap("modelo", modelo));
    }

    // Lista los Pedido de un Cliente -> Vista por Cliente
    public void listarPedidoCliente(Context ctx) throws SQLException {
        var modelo = new ModeloPedidos();
        var cliente = this.clientesRepositorio.obtenerCliente(ctx.cookie("nick"));
        modelo.rol = ctx.cookie("rol");
        modelo.idCliente = cliente.getIdCliente();
        modelo.pedidos = this.pedidosRepositorio.listarPedidoCliente(cliente.getIdCliente());
        ctx.render("pedidos.jte", Collections.singletonMap("modelo", modelo));
    }

    // Lista Producto para Agregar al Detalle Pedido
    public void listarProducto(Context ctx) throws SQLException {
        var modelo = new ModeloProductos();
        modelo.productos = pedidosRepositorio.listarProducto();
        var cliente = this.clientesRepositorio.obtenerCliente(ctx.cookie("nick"));
        modelo.nombre = cliente.getNombre();
        modelo.apellido = cliente.getApellido();
        ctx.render("formularioPedido.jte", Collections.singletonMap("modelo", modelo));
    }

}

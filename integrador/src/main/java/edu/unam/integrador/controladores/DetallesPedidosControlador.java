package edu.unam.integrador.controladores;

import io.javalin.http.Context;
import java.sql.SQLException;
import java.util.Collections;

import edu.unam.integrador.modelo.DetallePedido;
import edu.unam.integrador.paginas.*;
import edu.unam.integrador.repositorio.ClientesRepositorio;
import edu.unam.integrador.repositorio.DetallesPedidosRepositorio;
import edu.unam.integrador.repositorio.PedidosRepositorio;

public class DetallesPedidosControlador {

    private final PedidosRepositorio pedidosRepositorio;
    private final ClientesRepositorio clientesRepositorio;
    private final DetallesPedidosRepositorio detallesPedidosRepositorio;

    public DetallesPedidosControlador(PedidosRepositorio pedidosRepositorio, ClientesRepositorio clientesRepositorio,
        DetallesPedidosRepositorio detallesPedidosRepositorio) {
            this.pedidosRepositorio = pedidosRepositorio;
            this.clientesRepositorio = clientesRepositorio;
            this.detallesPedidosRepositorio = detallesPedidosRepositorio;
    }
    
    public void listarDetalle(Context ctx) throws SQLException{
        var modelo = new ModeloDetallesPedidos();
        var pedido = pedidosRepositorio.obtener(ctx.pathParam("id", Integer.class).get());
        var obtenerCliente = clientesRepositorio.obtenerClientePedido(pedido.getIdPedido());
        var cliente = clientesRepositorio.obtener(obtenerCliente.getIdCliente());
        modelo.valdescuento = pedido.getDescuento();
        modelo.apellido = cliente.getApellido();
        modelo.nombre = cliente.getNombre();
        modelo.cuil = cliente.getCuil();
        modelo.domicilio = cliente.getDomicilio();
        modelo.telefono = cliente.getTelefono();
        modelo.detallePedidos = detallesPedidosRepositorio.listar(ctx.pathParam("id", Integer.class).get());
        //modelo.subtotal = 0;
        modelo.total = 0;
        modelo.descuento = 0; 
        double valorSubTotal = 0;
        for (DetallePedido detalle : modelo.detallePedidos) {
            //modelo.subtotal += detalle.getSubTotal();
            valorSubTotal += detalle.getSubTotal();
            modelo.subtotal = String.format("%.2f", valorSubTotal);
            modelo.descuento = (valorSubTotal * modelo.valdescuento)/100;
            modelo.total = Math.round((valorSubTotal - modelo.descuento) * 100)/100d;
        }
        ctx.render("listaDetallePedido.jte", Collections.singletonMap("modelo", modelo));
    }

}
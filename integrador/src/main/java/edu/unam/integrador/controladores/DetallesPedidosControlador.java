package edu.unam.integrador.controladores;

import io.javalin.http.Context;
import java.sql.SQLException;
import java.util.Collections;

import edu.unam.integrador.modelo.DetallePedido;
import edu.unam.integrador.paginas.*;
import edu.unam.integrador.repositorio.ClientesPreferencialRepositorio;
import edu.unam.integrador.repositorio.ClientesRepositorio;
import edu.unam.integrador.repositorio.DetallesPedidosRepositorio;
import edu.unam.integrador.repositorio.PedidosRepositorio;

public class DetallesPedidosControlador {

    private final PedidosRepositorio pedidosRepositorio;
    private final ClientesRepositorio clientesRepositorio;
    private final DetallesPedidosRepositorio detallesPedidosRepositorio;
    private final ClientesPreferencialRepositorio clientesPreferencialRepositorio;

    public DetallesPedidosControlador(PedidosRepositorio pedidosRepositorio, ClientesRepositorio clientesRepositorio,
            DetallesPedidosRepositorio detallesPedidosRepositorio,
            ClientesPreferencialRepositorio clientesPreferencialRepositorio) {
                this.pedidosRepositorio = pedidosRepositorio;
                this.clientesRepositorio = clientesRepositorio;
                this.detallesPedidosRepositorio = detallesPedidosRepositorio;
                this.clientesPreferencialRepositorio = clientesPreferencialRepositorio;
    }
    
    public void listarDetalle(Context ctx) throws SQLException{
        var modelo = new ModeloDetallesPedidos();
        var pedido = pedidosRepositorio.obtener(ctx.pathParam("id", Integer.class).get());
        System.out.println(pedido);
       // System.out.println(idCliente.getIdCliente() + idCliente.getApellido());
        //var cliente = this.clientesRepositorio.obtener(idCliente.getIdCliente());
        modelo.valdescuento = pedido.getDescuento();
       // modelo.apellido = cliente.getIdCliente();
        //modelo.nombre = cliente.getNombre();
        //modelo.cuil = cliente.getCuil();
        //modelo.domicilio = cliente.getDomicilio();
        //modelo.telefono = cliente.getTelefono();
        
        modelo.apellido = "s";
        modelo.nombre = "s";
        modelo.cuil = "12";
        modelo.domicilio = "12";
        modelo.telefono = "12";

        modelo.detallePedidos = detallesPedidosRepositorio.listar(ctx.pathParam("id", Integer.class).get());
        modelo.subtotal = 0;
        modelo.total = 0;
        modelo.descuento = 0; 
        for (DetallePedido detalle : modelo.detallePedidos) {
            modelo.subtotal += detalle.getTotalFila();
            modelo.descuento = (modelo.subtotal * modelo.valdescuento)/100;
            modelo.total = modelo.subtotal - modelo.descuento;
        }
        ctx.render("listaDetallePedido.jte", Collections.singletonMap("modelo", modelo));
    }

}

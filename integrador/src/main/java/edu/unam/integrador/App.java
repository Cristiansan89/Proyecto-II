package edu.unam.integrador;

import io.javalin.*;
import org.sql2o.Sql2o;
import edu.unam.integrador.controladores.ClientesControlador;
import edu.unam.integrador.controladores.ProductosControlador;
import edu.unam.integrador.controladores.PedidosControlador;
import edu.unam.integrador.controladores.UsuariosControlador;
import edu.unam.integrador.controladores.DetallesPedidosControlador;
import edu.unam.integrador.repositorio.RepositorioException;
import edu.unam.integrador.repositorio.Sql2oClientesRepositorio;
import edu.unam.integrador.repositorio.Sql2oDetallesPedidosRepositorio;
import edu.unam.integrador.repositorio.Sql2oPedidosRepositorio;
import edu.unam.integrador.repositorio.Sql2oProductosRepositorio;
import edu.unam.integrador.repositorio.Sql2oUsuariosRepositorio;
import edu.unam.integrador.repositorio.Sql2oClientesPreferencialRepositorio;

public class App {

    public static void main(String[] args) {

        // Conexión de sql2o
        var sql2o = new Sql2o("jdbc:postgresql://localhost:5432/distribuidora", "postgres", "gpl");

        // Repositorio y Controladores

        var clientesPreferencialRepositorio = new Sql2oClientesPreferencialRepositorio(sql2o);
        var clientesRepositorio = new Sql2oClientesRepositorio(sql2o);
        var productosRepositorio = new Sql2oProductosRepositorio(sql2o);
        var pedidosRepositorio = new Sql2oPedidosRepositorio(sql2o, clientesRepositorio);
        var usuariosRepositorio = new Sql2oUsuariosRepositorio(sql2o);
        
        var usuariosControlador = new UsuariosControlador(usuariosRepositorio, clientesRepositorio);
        var clientesControlador = new ClientesControlador(clientesRepositorio, usuariosRepositorio, clientesPreferencialRepositorio);
        var productosControlador = new ProductosControlador(productosRepositorio);
        var detallePedidoControlador = new Sql2oDetallesPedidosRepositorio(sql2o, pedidosRepositorio, productosRepositorio);
        var pedidosControlador = new PedidosControlador(pedidosRepositorio, clientesRepositorio, productosRepositorio, detallePedidoControlador, clientesPreferencialRepositorio);
        var detallesPedidosControlador = new DetallesPedidosControlador(pedidosRepositorio, clientesRepositorio, detallePedidoControlador);
    
        // Crear Servidor
        Javalin app = Javalin.create(config -> {
            config.addStaticFiles("/public");
        }).exception(RepositorioException.class, (e, ctx) -> {
            ctx.status(404);
        }).start(8000);

        app.get("/", usuariosControlador::mostrarIndex); // muestra el index
        app.post("/", usuariosControlador::validarUsuario);
        app.get("/cerrar", usuariosControlador::cerrarSesion);

        // Cliente
        app.get("/clientes", clientesControlador::listar);
        app.get("/clientes/nuevo", clientesControlador::nuevo);
        app.post("/clientes/crear", clientesControlador::crear);
        app.get("/clientes/modificar/:id", clientesControlador::modificar);
        app.post("/clientes/actualizar/:id", clientesControlador::actualizar);
        app.delete("/clientes/borrar/:id", clientesControlador::borrar);

        // Producto
        app.get("/productos", productosControlador::listar);
        app.get("/productos/nuevo", productosControlador::nuevo);
        app.post("/productos/crear", productosControlador::crear);
        app.get("/productos/modificar/:id", productosControlador::modificar);
        app.post("/productos/actualizar/:id", productosControlador::actualizar);
        app.delete("/productos/borrar/:id", productosControlador::borrar);

        // Pedido y Detalle Pedido
        app.get("/pedidos/listapedido", pedidosControlador::listar);
        app.get("/pedidos/listadetalle/:id", detallesPedidosControlador::listarDetalle);
        app.get("/pedidos/crear", pedidosControlador::crear);
        app.post("/pedidos/agregardetalle/:id", pedidosControlador::agregar);
        app.get("/pedidos/nuevo/:id", pedidosControlador::nuevo);
        app.get("/pedidos/formulario", pedidosControlador::listarProducto);
        app.delete("/detallepedido/borrar/:id/:idpedido", pedidosControlador::eliminardetalle);
        app.post("/pedidos/finalizar/:id", pedidosControlador::finalizar);
        
        // Usuario
        app.get("/usuarios/modificar/:id", usuariosControlador::modificar);
        app.post("/usuarios/actualizar/:id", usuariosControlador::actualizar);
    }

}
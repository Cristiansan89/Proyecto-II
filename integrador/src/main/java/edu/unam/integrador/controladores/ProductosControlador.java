package edu.unam.integrador.controladores;

import io.javalin.http.Context;
import java.sql.SQLException;
import java.util.Collections;

import edu.unam.integrador.paginas.ModeloProducto;
import edu.unam.integrador.modelo.Producto;
import edu.unam.integrador.paginas.ModeloProductos;
import edu.unam.integrador.repositorio.ProductosRepositorio;
import edu.unam.integrador.repositorio.RepositorioException;

public class ProductosControlador {
    private final ProductosRepositorio productosRepositorio;

    public ProductosControlador(ProductosRepositorio productosRepositorio) {
        this.productosRepositorio = productosRepositorio;
    }

    public void listar(Context ctx) throws SQLException {
        var modelo = new ModeloProductos();
        modelo.productos = productosRepositorio.listar();
        ctx.render("productos.jte", Collections.singletonMap("modelo", modelo));
    }

    public void nuevo(Context ctx) throws SQLException {
        ctx.render("crearProducto.jte");

    }

    public void crear(Context ctx) throws SQLException {
        var codproducto = ctx.formParam("codProducto", Integer.class).get();
        var categoria = ctx.formParam("categoria", String.class).get();
        var marca = ctx.formParam("marca", String.class).get();
        var medida = ctx.formParam("medida", Double.class).get();
        var unidad = ctx.formParam("unidad", String.class).get();
        var stock = ctx.formParam("stock", Integer.class).get();
        var preciounitario = ctx.formParam("precioUnitario", Double.class).get();
        var detalle = ctx.formParam("detalle", String.class).get();
        var producto = new Producto(codproducto, categoria, marca, medida, unidad, stock, preciounitario, detalle);
        this.productosRepositorio.crear(producto);
        ctx.redirect("/");
    }

    public void borrar(Context ctx) throws SQLException, RepositorioException {
        System.out.println(ctx.pathParam("id", Integer.class).get());
        this.productosRepositorio.borrar(this.productosRepositorio.obtener(ctx.pathParam("id", Integer.class).get()));
        ctx.redirect("/productos");
    }

    public void modificar(Context ctx) throws SQLException, RepositorioException {
        var modelo = new ModeloProducto();
        modelo.producto = this.productosRepositorio.obtener(ctx.pathParam("id", Integer.class).get());
        ctx.render("editarProducto.jte", Collections.singletonMap("modelo", modelo));
    }

    public void actualizar(Context ctx) throws SQLException {
        var id = ctx.pathParam("id", Integer.class).get();
        Producto producto = this.productosRepositorio.obtener(id);
        var codProducto = ctx.formParam("codproducto", Integer.class).get();
        var categoria = ctx.formParam("categoria", String.class).get();
        var marca = ctx.formParam("marca", String.class).get();
        var medida = ctx.formParam("medida", Double.class).get();
        var unidad = ctx.formParam("unidad", String.class).get();
        var stock = ctx.formParam("stock", Integer.class).get();
        var precioUnitario = ctx.formParam("preciounitario", Double.class).get();
        var detalle = ctx.formParam("detalle", String.class).get();
        producto.setCodProducto(codProducto);
        producto.setCategoria(categoria);
        producto.setMarca(marca);
        producto.setMedida(medida);
        producto.setUnidad(unidad);
        producto.setStock(stock);
        producto.setPrecioUnitario(precioUnitario);
        producto.setDetalle(detalle);
        this.productosRepositorio.actualizar(producto);
        ctx.redirect("/productos");
    }
}

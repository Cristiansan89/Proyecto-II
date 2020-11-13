package edu.unam.integrador.controladores;
import edu.unam.integrador.repositorio.ProductosRepositorio;
import edu.unam.integrador.repositorio.RepositorioException;
import io.javalin.http.Context;
import java.sql.SQLException;
import java.util.Collections;
import edu.unam.integrador.paginas.ModeloProductos;
import edu.unam.integrador.modelo.Producto;
import edu.unam.integrador.paginas.ModeloProducto;
public class ProductosControlador {
    private final ProductosRepositorio productoRepositorio;

    public ProductosControlador(ProductosRepositorio productoRepositorio) {
        this.productoRepositorio = productoRepositorio;
    }

    public void listar(Context ctx) throws SQLException {
        var modelo = new ModeloProductos();
        modelo.productos = productoRepositorio.listar();
        ctx.render("producto.jte", Collections.singletonMap("modelo", modelo));
    }

    public void nuevo(Context ctx) throws SQLException {
        ctx.render("crearProducto.jte");

    }

    public void crear(Context ctx) throws SQLException {
        var codproducto = ctx.formParam("codproducto", Integer.class).get();
        var categoria = ctx.formParam("categoria", String.class).get();
        var marca = ctx.formParam("marca", String.class).get();
        var medida = ctx.formParam("medida", String.class).get();
        var unidad = ctx.formParam("unidad", String.class).get();
        var stock = ctx.formParam("stock", Integer.class).get();
        var detalle = ctx.formParam("detalle", String.class).get();
        var producto = new Producto(codproducto, categoria, marca, medida, unidad, stock , detalle);
        this.productoRepositorio.crear(producto);
        ctx.redirect("/");
    }

    public void borrar(Context ctx) throws SQLException, RepositorioException {
        System.out.println(ctx.pathParam("id", Integer.class).get());
        this.productoRepositorio.borrar(this.productoRepositorio.obtener(ctx.pathParam("id", Integer.class).get()));
        ctx.redirect("/productos");
    }

    public void modificar(Context ctx) throws SQLException, RepositorioException {
        var modelo = new ModeloProducto();
        modelo.producto = this.productoRepositorio.obtener(ctx.pathParam("id", Integer.class).get());
        ctx.render("editarCliente.jte", Collections.singletonMap("modelo", modelo));
    }
}

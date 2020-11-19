package edu.unam.integrador.modelo;

public class DetallePedido {
    private int idDetallePedido;
    private int cantidad;
    private Producto producto;

    public DetallePedido() {
    }

    public DetallePedido(int cantidad, Producto producto) {
        this.cantidad = cantidad;
        this.producto = producto;
    }

    public int getIdDetallePedido() {
        return idDetallePedido;
    }

    public void setIdDetallePedido(int idDetallePedido) {
        this.idDetallePedido = idDetallePedido;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }

    @Override
    public String toString() {
        return "DetallePedido [cantidad=" + cantidad + ", idDetallePedido=" + idDetallePedido + ", producto=" + producto
                + "]";
    }

}

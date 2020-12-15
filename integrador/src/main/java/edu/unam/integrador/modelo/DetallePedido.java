package edu.unam.integrador.modelo;

public class DetallePedido {
    private int idDetallePedido;
    private int cantidad;
    private Pedido pedido;
    private Producto producto;

    public DetallePedido() {
    }

    public DetallePedido(int cantidad, Pedido pedido, Producto producto) {
        this.cantidad = cantidad;
        this.pedido = pedido;
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

    public double getSubTotal(){
        return this.getProducto().getPrecioUnitario() * this.getCantidad();
    }

    public double getTotalFila() {
        return (((this.getProducto().getPrecioUnitario() * this.getCantidad()) * this.pedido.getDescuento()) / 100);
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public Producto getProducto() {
        return this.producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }


    public Pedido getPedido() {
        return pedido;
    }

    public void setPedido(Pedido pedido) {
        this.pedido = pedido;
    }

    @Override
    public String toString() {
        return "ID Detalle Pedido: " + idDetallePedido + ", Pedido: " + pedido
            + ", Producto: " + producto + ", Cantidad: " + cantidad;
    }
}

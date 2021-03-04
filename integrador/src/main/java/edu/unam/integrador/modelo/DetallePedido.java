package edu.unam.integrador.modelo;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Locale;

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

    public double getSubTotal(){
        double subTotal = this.getProducto().getPrecioUnitario() * this.getCantidad();
        double redondeoSubTotal = Math.round(subTotal * 100) / 100d;
        return redondeoSubTotal;
    }

    public double getTotalFila() {
        double totalFila = (((this.getProducto().getPrecioUnitario() * this.getCantidad()) * this.pedido.getDescuento()) / 100);
        double redondeoTotalFila = Math.round(totalFila * 100) / 100d;
        return redondeoTotalFila;
    }

    public String stringSubTotal(){
        String valorSubTotal = String.format("%.2f", this.getSubTotal());
        return valorSubTotal;
    }

    public String stringTotalFila(){
        String valorTotalFila = String.format("%.2f", this.getTotalFila());
        return valorTotalFila;
    }

    @Override
    public String toString() {
        return idDetallePedido + ", " + pedido + ", " + producto + ", " + cantidad;
    }
}

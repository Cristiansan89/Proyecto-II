package edu.unam.integrador.modelo;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

public class Pedido {
    private int idPedido;
    private Date fecha;
    private String hora;
    private Double descuento;
    private Double totalPagar;
    private Cliente cliente;
    private boolean estado;
    private String condicion;

    public Pedido() {
    }

    public Pedido(Cliente cliente){
        this.cliente = cliente;
    }

    public Pedido(Date fecha, String hora, Double descuento, Double totalPagar, Cliente cliente, boolean estado, String condicion) {
        this.fecha = fecha;
        this.hora = hora;
        this.descuento = descuento;
        this.totalPagar = totalPagar;
        this.cliente = cliente;
        this.estado = estado;
        this.condicion = condicion;
    }

    public int getIdPedido() {
        return idPedido;
    }

    public void setIdPedido(int idPedido) {
        this.idPedido = idPedido;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }

    public Double getDescuento(){
        return descuento;
    }

    public void setDescuento(Double descuento){
        this.descuento = descuento;
    }

    public Double getTotalPagar() {
        return totalPagar;
    }

    public void setTotalPagar(Double totalPagar) {
        this.totalPagar = totalPagar;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public boolean isEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }

    public String getCondicion() {
        return condicion;
    }

    public void setCondicion(String condicion) {
        this.condicion = condicion;
    }

    public String tipoEstadoStr(){
        String text;
        if(this.estado){
            text = "Pedido Realizado";
        }else{
            text = "Pedido No Realizado";
        }
        return text;
    }

    public String formatoFecha(Date fecha) {
        String formato = "dd/MM/yyyy";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(formato);
        String formatoFecha = simpleDateFormat.format(fecha);
        return formatoFecha;
    }


    @Override
    public String toString() {
        return  "ID Pedido: " + idPedido + ", Fecha: " + this.formatoFecha(fecha) + ", Hora: " + hora + ", Estado: " + this.tipoEstadoStr() + ", Condición: " + condicion + ", Descuento: " + descuento + 
            ", Total a Pagar: " + totalPagar + ", Cliente: " + cliente;
    }

}

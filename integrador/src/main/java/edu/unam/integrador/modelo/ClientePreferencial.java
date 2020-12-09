package edu.unam.integrador.modelo;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;


public class ClientePreferencial {
    private int idClientePreferencial;
    private double descuento;
    private Cliente cliente;

    public ClientePreferencial() {
    }

    public ClientePreferencial(int idClientePreferencial, double descuento, Cliente cliente) {
        this.idClientePreferencial = idClientePreferencial;
        this.descuento = descuento;
        this.cliente = cliente;
    }

    public int getIdClientePreferencial() {
        return idClientePreferencial;
    }

    public void setIdClientePreferencial(int idClientePreferencial) {
        this.idClientePreferencial = idClientePreferencial;
    }

    public double getDescuento() {
        double descuento = 0;
        Calendar fechaActual = new GregorianCalendar(); 
        Calendar fechaIngreso = new GregorianCalendar(); 
        fechaActual.setTime(new Date());
        fechaIngreso.setTime(this.cliente.getFechaIngreso());
        int difA = fechaActual.get(Calendar.YEAR) - fechaIngreso.get(Calendar.YEAR);
        int difM = difA * 12 + fechaActual.get(Calendar.MONTH) - fechaIngreso.get(Calendar.MONTH);

        if ((difM >= 6) && (difM < 12)){
            descuento = 5;
        } else if ((difM >= 12) && (difM < 18)){
            descuento = 10;
        } else if ((difM >= 18) && (difM < 24)){
            descuento = 15;
        } 
        return descuento;
    }

    public void setDescuento(double descuento) {
        this.descuento = descuento;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    @Override
    public String toString() {
        return "ID Cliente Preferencial: " + idClientePreferencial + ", Descuento: " + descuento;
    }

}
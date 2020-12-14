package edu.unam.integrador.modelo;



public class ClientePreferencial {
    private int idClientePreferencial;
    private double descuento;
    private Cliente cliente;

    public ClientePreferencial() {
    }

    public ClientePreferencial(Cliente cliente) {
        this.cliente = cliente;
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
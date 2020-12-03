package edu.unam.integrador.modelo;

public class ClientePreferencial {
    private int idClientePreferencial;
    private double descuento;

    public ClientePreferencial() {
    }

    public ClientePreferencial(int idClientePreferencial, double descuento) {
        this.idClientePreferencial = idClientePreferencial;
        this.descuento = descuento;
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

    @Override
    public String toString() {
        return "ClientePreferencial (ID Cliente Preferencial: " + idClientePreferencial + ", Descuento: " + descuento + ")";
    }

    
}

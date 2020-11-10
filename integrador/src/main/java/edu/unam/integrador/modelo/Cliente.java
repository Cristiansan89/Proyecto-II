package edu.unam.integrador.modelo;

public class Cliente {
    
    private int idCliente;
    private String nombre;
    private int cuil;
    private String domicilio;
    private int telefono;

    public Cliente() {
    }

    public Cliente(int idCliente, String nombre, int cuil, String domicilio, int telefono) {
        this.idCliente = idCliente;
        this.nombre = nombre;
        this.cuil = cuil;
        this.domicilio = domicilio;
        this.telefono = telefono;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getCuil() {
        return cuil;
    }

    public void setCuil(int cuil) {
        this.cuil = cuil;
    }

    public String getDomicilio() {
        return domicilio;
    }

    public void setDomicilio(String domicilio) {
        this.domicilio = domicilio;
    }

    public int getTelefono() {
        return telefono;
    }

    public void setTelefono(int telefono) {
        this.telefono = telefono;
    }

    @Override
    public String toString() {
        return "Cliente [cuil=" + cuil + ", domicilio=" + domicilio + ", idCliente=" + idCliente + ", nombre=" + nombre
                + ", telefono=" + telefono + "]";
    }
    
}

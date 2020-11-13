package edu.unam.integrador.modelo;

public class Cliente {

    private int idCliente;
    private String nombre;
    private float cuil;
    private String domicilio;
    private float telefono;

    public Cliente() {
    }

    public Cliente(String nombre, float cuil, String domicilio, float telefono) {

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

    public float getCuil() {
        return cuil;
    }

    public void setCuil(float cuil) {
        this.cuil = cuil;
    }

    public String getDomicilio() {
        return domicilio;
    }

    public void setDomicilio(String domicilio) {
        this.domicilio = domicilio;
    }

    public float getTelefono() {
        return telefono;
    }

    public void setTelefono(float telefono) {
        this.telefono = telefono;
    }

    @Override
    public String toString() {
        return "Cliente [cuil=" + cuil + ", domicilio=" + domicilio + ", idCliente=" + idCliente + ", nombre=" + nombre
                + ", telefono=" + telefono + "]";
    }

}

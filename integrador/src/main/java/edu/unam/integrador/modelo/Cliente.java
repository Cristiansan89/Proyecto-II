package edu.unam.integrador.modelo;

public class Cliente {

    private int idCliente;
    private String nombre;
    private String apellido;
    private float cuil;
    private String domicilio;
    private float telefono;

    public Cliente() {
    }

    public Cliente(String nombre, String apellido, float cuil, String domicilio, float telefono) {
        this.nombre = nombre;
        this.apellido = apellido;
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

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
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
        return "Cliente [nombre=" + nombre + ", apellido=" + apellido + ", cuil=" + cuil + ", domicilio=" + domicilio + ", telefono=" + telefono + "]";
    }

    


}

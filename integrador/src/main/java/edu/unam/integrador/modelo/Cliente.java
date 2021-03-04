package edu.unam.integrador.modelo;

import java.util.Date;

public class Cliente {

    private int idCliente;
    private String nombre;
    private String apellido;
    private String cuil;
    private String domicilio;
    private String telefono;
    private Date fechaIngreso;

    public Cliente() {
    }

    public Cliente(String nombre, String apellido, String cuil, String domicilio, String telefono) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.cuil = cuil;
        this.domicilio = domicilio;
        this.telefono = telefono;
    }

    
    public Cliente(int idCliente, String nombre, String apellido, String cuil, String domicilio, String telefono, Date fechaIngreso) {
        this.idCliente = idCliente;
        this.nombre = nombre;
        this.apellido = apellido;
        this.cuil = cuil;
        this.domicilio = domicilio;
        this.telefono = telefono;
        this.fechaIngreso = fechaIngreso;
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

    public String getCuil() {
        return cuil;
    }

    public void setCuil(String cuil) {
        this.cuil = cuil;
    }

    public String getDomicilio() {
        return domicilio;
    }

    public void setDomicilio(String domicilio) {
        this.domicilio = domicilio;
    }

    public String getTelefono() {
        return this.telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public Date getFechaIngreso() {
        return fechaIngreso;
    }

    public void setFechaIngreso(Date fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    @Override
    public String toString() {
        return idCliente  + ", " + nombre + ", " + apellido  + ", " + cuil + ", " + domicilio  +  ", " + telefono + ", " + fechaIngreso;
    }


}

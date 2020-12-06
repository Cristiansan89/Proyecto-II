package edu.unam.integrador.modelo;

public class Usuario {
    private int idUsuario;
    private String mail;
    private String nick;
    private String contrasena;
    private String rol;
    private Cliente cliente;

    public Usuario() {
    }

    public Usuario(String mail, String nick, String contrasena, Cliente cliente) {
        this.mail = mail;
        this.nick = nick;
        this.contrasena = contrasena;
        this.cliente = cliente;
    }

    public Usuario(int idUsuario, String mail, String nick, String contrasena, String rol, Cliente cliente) {
        this.idUsuario = idUsuario;
        this.mail = mail;
        this.nick = nick;
        this.contrasena = contrasena;
        this.rol = rol;
        this.cliente = cliente;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getNick() {
        return nick;
    }

    public void setNick(String nick) {
        this.nick = nick;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public String getRol() {
        return rol;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    @Override
    public String toString() {
        return "ID Usuario: " + idUsuario + ", Nombre Usuario: " + nick + ", Mail: " + mail + ", Rol: " + rol;
    }

    
}

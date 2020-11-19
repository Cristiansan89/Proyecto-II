package edu.unam.integrador.modelo;

public class Pedido {
    private int idPedido;
    private Date fecha;
    private Date hora;
    private Double precioPagar;
    private Cliente cliente;

    public Pedido() {
    }

    public Pedido(Date fecha, Date hora, Double precioPagar) {
        this.fecha = fecha;
        this.hora = hora;
        this.precioPagar = precioPagar;
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

    public Date getHora() {
        return hora;
    }

    public void setHora(Date hora) {
        this.hora = hora;
    }

    public Double getPrecioPagar() {
        return precioPagar;
    }

    public void setPrecioPagar(Double precioPagar) {
        this.precioPagar = precioPagar;
    }

    @Override
    public String toString() {
        return "Pedido [fecha=" + fecha + ", hora=" + hora + ", idPedido=" + idPedido + ", precioPagar=" + precioPagar
                + "]";
    }

}

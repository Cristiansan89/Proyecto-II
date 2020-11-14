package edu.unam.integrador.modelo;

public class Producto {
    private int idProducto;
    private int CodProducto;
    private String categoria;
    private String marca;
    private String medida;
    private String unidad;
    private int stock;
    private String detalle;

    public Producto() {
    }

    public Producto(int codProducto, String categoria, String marca, String medida, String unidad, int stock, String detalle) {
        this.CodProducto = codProducto;
        this.categoria = categoria;
        this.marca = marca;
        this.medida = medida;
        this.unidad = unidad;
        this.stock = stock;
        this.detalle = detalle;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public int getCodProducto() {
        return CodProducto;
    }

    public void setCodProducto(int codProducto) {
        CodProducto = codProducto;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public String getMedida() {
        return medida;
    }

    public void setMedida(String medida) {
        this.medida = medida;
    }

    public String getUnidad() {
        return unidad;
    }

    public void setUnidad(String unidad) {
        this.unidad = unidad;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getDetalle() {
        return detalle;
    }

    public void setDetalle(String detalle) {
        this.detalle = detalle;
    }

    @Override
    public String toString() {
        return "Producto [CodProducto=" + CodProducto + ", categoria=" + categoria + ", detalle=" + detalle
                + ", idProducto=" + idProducto + ", marca=" + marca + ", medida=" + medida + ", stock=" + stock
                + ", unidad=" + unidad + "]";
    }


}

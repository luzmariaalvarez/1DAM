package app;

public class Producto {
    private final String nombre;
    private final double precio;

    public Producto(String nombre, double precio) {
        if (nombre == null || nombre.isBlank()) {
            throw new IllegalArgumentException("Nombre inválido");
        }
        if (precio <= 0) {
            throw new IllegalArgumentException("Precio inválido");
        }
        this.nombre = nombre;
        this.precio = precio;
    }

    public String getNombre() { return nombre; }
    public double getPrecio() { return precio; }
}

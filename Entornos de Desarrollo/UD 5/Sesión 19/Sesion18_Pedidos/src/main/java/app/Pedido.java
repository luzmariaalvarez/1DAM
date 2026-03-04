package app;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Pedido {
    private final List<Producto> productos = new ArrayList<>();

    public void addProducto(Producto p) {
        if (p == null) throw new IllegalArgumentException("Producto null");
        productos.add(p);
    }

    public List<Producto> getProductos() {
        return Collections.unmodifiableList(productos);
    }
}

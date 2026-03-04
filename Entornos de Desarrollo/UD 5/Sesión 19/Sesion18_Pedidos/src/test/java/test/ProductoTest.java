package test;

import app.Producto;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class ProductoTest {

    @Test
    void noPermiteNombreVacio() {
        assertThrows(IllegalArgumentException.class, () -> new Producto("", 10));
    }

    @Test
    void noPermitePrecioNegativo() {
        assertThrows(IllegalArgumentException.class, () -> new Producto("Pan", -1));
    }

    @Test
    void creaProductoCorrecto() {
        Producto p = new Producto("Pan", 1.5);
        assertEquals("Pan", p.getNombre());
        assertEquals(1.5, p.getPrecio());
    }
}

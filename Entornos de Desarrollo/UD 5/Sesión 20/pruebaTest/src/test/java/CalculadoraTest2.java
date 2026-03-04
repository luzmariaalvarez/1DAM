import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Clase de pruebas para Operaciones.
 */
public class CalculadoraTest2 {

    private final Operaciones ope = new Operaciones(); // Instancia de la clase Operaciones

    @Test
    public void testSumar() {
        // Prueba con números positivos
        int resultado = ope.Sumar(5, 3);
        assertEquals(8, resultado, "La suma de 5 + 3 debe ser 8");

        // Prueba con números negativos
        resultado = ope.Sumar(-5, -3);
        assertEquals(-8, resultado, "La suma de -5 + -3 debe ser -8");

        // Prueba con un positivo y un negativo
        resultado = ope.Sumar(5, -3);
        assertEquals(2, resultado, "La suma de 5 + -3 debe ser 2");
    }

    @Test
    public void testRestar() {
        // Prueba con números positivos
        int resultado = ope.Restar(5, 3);
        assertEquals(2, resultado, "La resta de 5 - 3 debe ser 2");

        // Prueba con números negativos
        resultado = ope.Restar(-5, -3);
        assertEquals(-2, resultado, "La resta de -5 - -3 debe ser -2");

        // Prueba con un positivo y un negativo
        resultado = ope.Restar(5, -3);
        assertEquals(8, resultado, "La resta de 5 - -3 debe ser 8");
    }
}

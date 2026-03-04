import static org.junit.jupiter.api.Assertions.assertEquals;

class OperacionesTest {
    Operaciones operaciones = new Operaciones();
    @org.junit.jupiter.api.Test
    void sumar() {
        // Prueba con números positivos
        int resultado = operaciones.Sumar(5, 3);
        assertEquals(8, resultado, "La suma de 5 + 3 debe ser 8");

        // Prueba con números negativos
        resultado = operaciones.Sumar(-5, -3);
        assertEquals(-8, resultado, "La suma de -5 + -3 debe ser -8");

        // Prueba con un positivo y un negativo
        resultado = operaciones.Sumar(5, -3);
        assertEquals(2, resultado, "La suma de 5 + -3 debe ser 2");

    }

    @org.junit.jupiter.api.Test
    void restar() {
        // Prueba con números positivos
        int resultado = operaciones.Restar(5, 3);
        assertEquals(2, resultado, "La resta de 5 - 3 debe ser 2");

        // Prueba con números negativos
        resultado = operaciones.Restar(-5, -3);
        assertEquals(-2, resultado, "La resta de -5 - -3 debe ser -2");

        // Prueba con un positivo y un negativo
        resultado = operaciones.Restar(5, -3);
        assertEquals(8, resultado, "La resta de 5 - -3 debe ser 8");
    }

}
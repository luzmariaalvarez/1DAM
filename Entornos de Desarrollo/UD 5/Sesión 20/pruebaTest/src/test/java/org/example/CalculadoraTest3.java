package org.example;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class CalculadoraTest3 {


    private final Calculadora calculadora = new Calculadora(); // Instancia de la clase Operaciones

    @Test
    public void testSumar() {
        // Prueba con números positivos
        int resultado = calculadora.Sumar(5, 3);
        assertEquals(8, resultado, "La suma de 5 + 3 debe ser 8");

        // Prueba con números negativos
        resultado = calculadora.Sumar(-5, -3);
        assertEquals(-8, resultado, "La suma de -5 + -3 debe ser -8");

        // Prueba con un positivo y un negativo
        resultado = calculadora.Sumar(5, -3);
        assertEquals(2, resultado, "La suma de 5 + -3 debe ser 2");

        resultado = calculadora.Sumar(2,4);
        assertEquals(6,resultado, "La suma de 2 + 6 debe ser 6");
    }

    @Test
    public void testRestar() {
        // Prueba con números positivos
        int resultado = calculadora.Restar(5, 3);
        assertEquals(2, resultado, "La resta de 5 - 3 debe ser 2");

        // Prueba con números negativos
        resultado = calculadora.Restar(-5, -3);
        assertEquals(-2, resultado, "La resta de -5 - -3 debe ser -2");

        // Prueba con un positivo y un negativo
        resultado = calculadora.Restar(5, -3);
        assertEquals(8, resultado, "La resta de 5 - -3 debe ser 8");
    }
}
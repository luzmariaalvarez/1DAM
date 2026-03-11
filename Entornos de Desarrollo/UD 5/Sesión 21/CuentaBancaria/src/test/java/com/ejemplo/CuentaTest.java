package com.ejemplo;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class CuentaTest {

    @Test
    void ingresarDinero() {
        Cuenta cuenta = new Cuenta();

        cuenta.ingresar(100);

        assertEquals(100, cuenta.getSaldo());
    }

    @Test
    void retirarDinero() {
        Cuenta cuenta = new Cuenta();

        cuenta.ingresar(100);
        cuenta.retirar(40);

        assertEquals(60, cuenta.getSaldo());
    }

    @Test
    void retirarMasDeLoDisponible() {
        Cuenta cuenta = new Cuenta();

        cuenta.ingresar(50);

        assertThrows(IllegalArgumentException.class, () -> {
            cuenta.retirar(100);
        });
    }

    @Test
    void retirarTodoElSaldo() {
        Cuenta cuenta = new Cuenta();

        cuenta.ingresar(80);
        cuenta.retirar(80);

        assertEquals(0, cuenta.getSaldo());
    }
}
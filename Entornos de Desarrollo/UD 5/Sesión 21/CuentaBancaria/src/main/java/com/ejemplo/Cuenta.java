package com.ejemplo;

public class Cuenta {

    private double saldo;

    public void ingresar(double cantidad) {
        saldo += cantidad;
    }

    public void retirar(double cantidad) {
        if (cantidad > saldo) {
            throw new IllegalArgumentException("Saldo insuficiente");
        }
        saldo -= cantidad;
    }

    public double getSaldo() {
        return saldo;
    }
}
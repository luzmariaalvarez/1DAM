package org.example;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {

        Calculadora calc = new Calculadora();

        int suma = calc.Sumar(5, 3);
        int resta = calc.Restar(5, 3);

        System.out.println("Suma: " + suma);
        System.out.println("Resta: " + resta);
    }
}
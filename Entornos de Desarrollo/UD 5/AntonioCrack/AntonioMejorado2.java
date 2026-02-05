/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.antoniocrack;

import java.util.Scanner;
import java.util.Arrays;

public class AntonioMejorado2 {
   
    public static void main(String[] args) {
        // Declaración de variables
        Scanner sc = new Scanner(System.in);
        int[] numbers = new int[10];
        int pares = 0;
        int impares = 0;

        // Pedir los 10 números
        for (int i = 0; i < numbers.length; i++) {
            System.out.print("Introduce el número " + (i + 1) + ": ");
            numbers[i] = sc.nextInt();
        }

        // Ordenar de menor a mayor
        Arrays.sort(numbers);

        // Contar pares e impares
        for (int i = 0; i < numbers.length; i++) {
            if (numbers[i] % 2 == 0) {
                pares++;
            } else {
                impares++;
            }
        }

        // Mostrar resultados
        System.out.println("\nNúmeros ordenados de menor a mayor:");
        for (int i = 0; i < numbers.length; i++) {
            System.out.print(numbers[i] + " ");
        }

        System.out.println("\n\nCantidad de números pares: " + pares);
        System.out.println("Cantidad de números impares: " + impares);

        sc.close();
    }
}

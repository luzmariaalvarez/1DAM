/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.antoniocrack;
import java.util.Scanner;
import java.util.Arrays;

public class AntonioMejorado5 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("Escribe un número para calcular pares e impares");
        int cantidadNumeros = sc.nextInt();
        int[] numeros = new int[cantidadNumeros];
        int pares = 0;

        System.out.println("Escribe " + numeros.length + " números:");
        for (int i = 0; i < numeros.length; i++) {
            numeros[i] = sc.nextInt();
            if (numeros[i] % 2 == 0) pares++;
        }

        Arrays.sort(numeros);
        System.out.println("Ordenados: " + Arrays.toString(numeros));
        System.out.println("Pares: " + pares + " Impares: " + (numeros.length - pares));
    }
}

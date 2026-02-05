/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.antoniocrack;
import java.util.Scanner;
import java.util.Arrays;

public class AntonioMejorado4 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int[] numeros = new int[10];
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

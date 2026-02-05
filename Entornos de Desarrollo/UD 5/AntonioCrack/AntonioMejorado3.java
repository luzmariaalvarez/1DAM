/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.antoniocrack;
import java.util.Scanner;
import java.util.Arrays;

/**
 *
 * @author usuario
 */
import java.util.Scanner;
import java.util.Arrays;

public class AntonioMejorado3 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int[] n = new int[10];
        int pares = 0;

        System.out.println("Escribe 10 números:");
        for (int i = 0; i < 10; i++) {
            n[i] = sc.nextInt();
            if (n[i] % 2 == 0) pares++;
        }

        Arrays.sort(n);
        System.out.println("Ordenados: " + Arrays.toString(n));
        System.out.println("Pares: " + pares + " Impares: " + (10 - pares));
    }
   }
    
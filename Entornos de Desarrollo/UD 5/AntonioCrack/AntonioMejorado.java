package com.mycompany.antoniocrack;

import java.util.Scanner;

public class AntonioMejorado {
    
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int[] n = new int[10];
        int pares = 0, impares = 0;

        for (int i = 0; i < 10; i++) {
            System.out.print("Numero " + (i + 1) + ": ");
            n[i] = sc.nextInt();
            if (n[i] % 2 == 0) pares++; else impares++;
        }

        for (int i = 0; i < 10; i++) {
            for (int j = 0; j < 9; j++) {
                if (n[j] > n[j + 1]) {
                    int aux = n[j];
                    n[j] = n[j + 1];
                    n[j + 1] = aux;
                }
            }
        }

        System.out.println("\nOrdenados:");
        for (int i = 0; i < 10; i++) System.out.print(n[i] + " ");

        System.out.println("\nPares: " + pares);
        System.out.println("Impares: " + impares);
    }
}

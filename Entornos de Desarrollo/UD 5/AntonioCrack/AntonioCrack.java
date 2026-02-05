/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.mycompany.antoniocrack;


import java.util.Scanner;

/**
 *
 * @author Antonio "el crack"
 */
public class AntonioCrack {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
       //Me han pedido que haga un programa que coge 10 numeros sin decimales por teclado, 
       //despues los muestra de menor a mayor por pntalla
       // y que diga cuantos pares hay que son los que se dividen por 2 y da 0, 
       //también tengo que poner cuantos impares que es lo de antes pero
           //al veres
           //declaracion de bariables
        int a,b,c,d,e,f,g,h,i,j,k,l,x,y;
        System.out.println("numeros");
        Scanner sn1 = new Scanner (System.in);
        Scanner sn2 = new Scanner (System.in);
        Scanner sn3 = new Scanner (System.in);
        Scanner sn4 = new Scanner (System.in);
        Scanner sn5 = new Scanner (System.in);
        Scanner sn6 = new Scanner (System.in);
        Scanner sn7 = new Scanner (System.in);
        Scanner sn8 = new Scanner (System.in);
        Scanner sn9 = new Scanner (System.in);
        Scanner sna = new Scanner (System.in);
// los numeros no puedo ordenarlos todabia
        a=sn1.nextInt();
        x=0;
        b=sn1.nextInt();
        c=sn1.nextInt();
        d=sn1.nextInt();
        e=sn1.nextInt();
        f=sn1.nextInt();
        g=sn1.nextInt();
        h=sn1.nextInt();
        i=sn1.nextInt();
        j=sn1.nextInt();
        
        
        x=0;
        
        while(x < 10)
        if(a>b){
            y=a;
            a=b;
            b=y;
        }
                if(b>c){
                    y=b;
                    b=c;
                    c=y;
        }
                        if(c>d){
            y=c;c=d;d=y;
        }
                                if(d>e){
          y=d;d=e;e=y;
        }
                                        if(e>f){
           y=e;e=f;f=y;
        }
                                                if(f>g){
            y=f;f=g;g=y;
        }
                                                        if(g>h){
            y=g;g=h;h=y;
        }
                                                                if(h>i){
            y=h;h=i;i=y;
        }
                                                                        if(i>j){
            y=i;i=j;j=y;
        }
        x++;
        /*henseño ls numers poer no saln bien*/
        System.out.println(a+b+c+d+e+f+g+h+i+j);
        float z;
        z=a%2;
        if (z==0) {
            System.out.println("PAR");
        } 
                z=b%2;
        if (z==0) {
            System.out.println("PAR");
        } 
                z=c%2;
        if (z==0) {
            System.out.println("PAR");
        } 
                z=d%2;
        if (z==0) {
            System.out.println("PAR");
        } 
                z=e%2;
        if (z==0) {
            System.out.println("PAR");
        } 
                z=f%2;
        if (z==0) {
            System.out.println("PAR");
        } 
                z=g%2;
        if (z==0) {
            System.out.println("PAR");
        } 
                z=h%2;
        if (z==0) {
            System.out.println("PAR");
        } 
                z=i%2;
        if (z==0) {
            System.out.println("PAR");
        } 
                z=j%2;
        if (z==0) {
            System.out.println("PAR");
        } 
        
    }
    
}
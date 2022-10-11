/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author sp21-bse-015
 */
import java.util.Scanner;

public class cardGame {

    public static void main(String[] args) {
        Scanner inp = new Scanner(System.in);
        char[] a = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u'};
        char[] a1 = new char[7];
        char[] a2 = new char[7];
        char[] a3 = new char[7];
        for (int m = 0; m < 3; m++) {
            int j = 0;
            for (int i = 0; i < a.length; i += 3) {

                a1[j] = a[i];
                a2[j] = a[i + 1];
                a3[j] = a[i + 2];
                j++;

            }

            for (int k = 0; k < a1.length; k++) {
                System.out.println(a1[k] + "\t" + a2[k] + "\t" + a3[k]);

            }
            System.out.println("_____________________");
            System.out.println("Select your column");
            int choice = inp.nextInt();
            System.out.println("_____________________");
            if (choice == 1) {
                for (int l = 0; l < 7; l++) {
                    a[l] = a2[l];
                    a[l + 7] = a1[l];
                    a[l + 14] = a3[l];

                }
            } else if (choice == 2) {
                for (int l = 0; l < 7; l++) {
                    a[l] = a1[l];
                    a[l + 7] = a2[l];
                    a[l + 14] = a3[l];

                }
            } else if (choice == 3) {
                for (int l = 0; l < 7; l++) {

                    a[l] = a1[l];
                    a[l + 7] = a3[l];
                    a[l + 14] = a2[l];
                    j++;
                }

            }
        }
        System.out.println("Your character is: \t" + a[10]);
    }
}

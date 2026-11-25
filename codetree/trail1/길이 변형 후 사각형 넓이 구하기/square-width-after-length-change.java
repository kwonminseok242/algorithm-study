import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        // Please write your code here.
        Scanner sc = new Scanner(System.in);
        int garo = sc.nextInt();
        int sero = sc.nextInt();
        garo += 8; sero *=3;
        System.out.println(garo);
        System.out.println(sero);
        System.out.println(garo*sero);

    }
}
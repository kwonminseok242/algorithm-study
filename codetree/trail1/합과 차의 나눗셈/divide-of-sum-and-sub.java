import java.util.Scanner;
import java.util.concurrent.SynchronousQueue;
public class Main {
    public static void main(String[] args) {
        // Please write your code here.
        Scanner sc = new Scanner(System.in);
        float a = sc.nextInt();
        float b = sc.nextInt();
        float c = (a+b)/(a-b);
        System.out.printf("%.2f",c);

    }
}
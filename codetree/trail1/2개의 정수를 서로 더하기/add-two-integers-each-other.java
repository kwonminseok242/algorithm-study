import java.nio.channels.ScatteringByteChannel;
import java.util.Scanner;
public class Main {
    public static void main(String[] args) {
        // Please write your code here.
        Scanner sc = new Scanner(System.in);
        int a = sc.nextInt();
        int b = sc.nextInt();
        a += b;
        b += a;
        System.out.printf("%d %d",a,b);

    }
}
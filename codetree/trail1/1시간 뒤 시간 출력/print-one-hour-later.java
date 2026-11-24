import java.util.Scanner;
public class Main {
    public static void main(String[] args) {
        // Please write your code here.
        Scanner sc = new Scanner(System.in);
        String time = sc.next();
        String[] Arr = time.split(":");
        System.out.println((Integer.parseInt(Arr[0])+ 1) + ":" + Arr[1]);
    }
}
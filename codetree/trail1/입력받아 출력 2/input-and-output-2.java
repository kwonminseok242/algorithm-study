import java.util.Scanner;
public class Main {
    public static void main(String[] args) {
        // Please write your code here.
        Scanner sc = new Scanner(System.in);
        String id = sc.next();
        String[] arr = id.split("-");
        System.out.println(arr[0]+arr[1]);
    }
}
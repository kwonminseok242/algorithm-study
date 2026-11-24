import java.util.Scanner;
public class Main {
    public static void main(String[] args) {
        // Please write your code here.
        Scanner sc = new Scanner(System.in);
        String date = sc.next();
        String[] arr = date.split("-");
        System.out.println(arr[2] + "." + arr[0] + "." + arr[1]);
    }
}
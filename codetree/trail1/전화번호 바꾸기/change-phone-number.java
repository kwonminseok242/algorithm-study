import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        // Please write your code here.
        Scanner sc = new Scanner(System.in);
        String phone = sc.next();
        String[] arr = phone.split("-");
        System.out.println(arr[0] + "-" + arr[2] + "-" + arr[1]);
        
    }
}
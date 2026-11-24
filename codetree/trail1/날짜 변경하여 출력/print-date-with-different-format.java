import java.util.Scanner;
public class Main {
    public static void main(String[] args) {
        // Please write your code here.
        Scanner sc = new Scanner(System.in);
        String date = sc.next();
        String[] arr = date.split("\\."); // 혹은 [.]으로 써야함 regex 로 정규표현식으로 보기 때문에
        System.out.println(arr[1] + "-" + arr[2] + "-" + arr[0]);
    }
}
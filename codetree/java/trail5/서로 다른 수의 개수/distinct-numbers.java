import java.util.Scanner;
import java.util.HashSet;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        HashSet<Integer> s = new HashSet<>();

        int n = sc.nextInt();
        for (int i = 0; i < n; i++) {
            s.add(sc.nextInt());
        }
        System.out.println(s.size());
        // Please write your code here.
    }
}
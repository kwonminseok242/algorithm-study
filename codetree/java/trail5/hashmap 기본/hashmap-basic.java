import java.util.Scanner;
import java.util.HashMap;
public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        HashMap<Integer, Integer> map = new HashMap<>();
        // Please write your code here.

        for (int i = 0; i < n; i++) {
            String cmd = sc.next();
            if (cmd.equals("add")) {
                int k = sc.nextInt();
                int v = sc.nextInt();
                map.put(k,v);
            }
            else if (cmd.equals("remove")) {
                int k = sc.nextInt();
                map.remove(k);
            }
            else {
                int k = sc.nextInt();
                if (map.containsKey(k)) {
                    System.out.println(map.get(k));
                }
                else {
                    System.out.println("None");
                }
            }


        }
    }
}
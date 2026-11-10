import java.util.HashMap;
import java.util.Scanner;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int m = sc.nextInt();
        
        String[] words = new String[n + 1]; // 타입이 String이라는 것이고 [] 는 배열이라는 표시, String을 n+1 킨 담는 배열을 새로 만들겠다는것
        HashMap<String, Integer> map = new HashMap<>();

        for (int i = 1; i <= n; i++) { // 1부터 사용하려고 위에서 배열을 n+1로 만듬
            words[i] = sc.next();
            map.put(words[i], i);
        }

        String[] queries = new String[m]; // String타입 [] 빈 배열, m개의 배열 생성
        for (int i = 0; i < m; i++) {
            String q = sc.next();
            if (Character.isDigit(q.charAt(0))){
                int idx = Integer.parseInt(q);
                System.out.println(words[idx]);
            } else {
                System.out.println(map.get(q));
            }
        }
    }
}
import java.util.Scanner;
import java.util.HashMap;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int N = sc.nextInt();
        // 해쉬맵을 이용해서 키 안에 횟수를 저장해놓으면 될것같음.
        HashMap<String, Integer> map = new HashMap<>();

        // 1단계 : 개수 세기
        for (int i = 0; i < N; i++) {
            String str = sc.next();
            map.put(str, map.getOrDefault(str,0) + 1);
        
        
        }

        // 2단계 : 최댓값 찾기
        int ans = 0;
        for (int cnt : map.values()) {
            ans = Math.max(ans, cnt);
        }
        
        System.out.println(ans);
        // Please write your code here.
    }
}
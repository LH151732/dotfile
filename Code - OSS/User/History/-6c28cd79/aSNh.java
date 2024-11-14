import java.util.Scanner;

public static boolean isPalindrome(String str) {
    // 将字符串转为小写并去除所有空格
    str = str.toLowerCase().replaceAll("\\s", "");
    
    int left = 0;
    int right = str.length() - 1;

    while (left < right) {
        if (str.charAt(left) != str.charAt(right)) {
            return false;
        }
        left++;
        right--;
    }
    return true;
}

public class Palindrome {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        
        System.out.print("Input a Palindrome: ");
        String input =  sc.next();

        if (input.isPalindrome()) {
            System.out.println("It is Palindrome!");
        } else {
            System.out.println("It is not a Palindrome!");
        }
    }
}
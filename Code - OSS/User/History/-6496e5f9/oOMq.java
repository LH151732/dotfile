import java.util.Scanner;

public class checkString {
    public boolean isPalindrome(String str) {
        int n = str.length();
        for (int i = 0; i < n / 2; i++) {
            if (str.charAt(i) != str.charAt(n - i - 1)) {
                return false;
            }
        }

        return true;
    }

    public static void main(String[] args) {
        checkString checker = new checkString();

        Scanner sc = new Scanner(System.in);

        System.out.print("Get your Palindrome check: ");
        String input = sc.nextLine(); 

        if (checker.isPalindrome(input)) { 
            System.out.println("It is a Palindrome String!");
        } else {
            System.out.println("Do you think that is Palindrome?! Wrong guess.");
        }
        sc.close(); 
    }
}
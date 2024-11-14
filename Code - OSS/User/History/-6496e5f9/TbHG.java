import java.util.Scanner;

public class checkString {
    // 检查是否是回文字符串的方法
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
        // 创建 `checkString` 类的新实例
        checkString checker = new checkString();

        // 使用扫描器获取输入
        Scanner sc = new Scanner(System.in);

        System.out.print("Get your Palindrome check: ");
        String input = sc.nextLine(); // 使用 nextLine 获取整行输入

        // 调用 checker 对象的 isPalindrome 方法
        if (checker.isPalindrome(input)) { // 调用实例方法应该通过对象
            System.out.println("It is a Palindrome String!");
        } else {
            System.out.println("Do you think that is Palindrome?! Wrong guess.");
        }
        sc.close(); // 记得关闭 Scanner 避免泄漏资源喵~
    }
}
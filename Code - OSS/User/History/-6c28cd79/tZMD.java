public class isPalindrome {
    // 判断是否是回文的方法
    public static boolean isPalindrome(String str) {
        // 定义两个指针，left从字符串头开始，right从尾部开始
        int left = 0;
        int right = str.length() - 1;

        // 判断从字符串两边同时向中间推进，是否每对字符都相等
        while (left < right) {
            // 如果某一对字符不相等，立即返回 false
            if (str.charAt(left) != str.charAt(right)) {
                return false; 
            }
            // 左指针右移，右指针左移
            left++;
            right--;
        }
        // 如果所有字符都匹配，返回 true 表示是回文
        return true;
    }

    public static void main(String[] args) {
        // 测试示例
        System.out.println(isPalindrome("racecar"));  // 输出: true
        System.out.println(isPalindrome("hello"));    // 输出: false
    }
}
import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;

public class Maximum {
    static ArrayList<Integer> numbers = new ArrayList<>();
    static Scanner sc = new Scanner(System.in);

    // 判断字符串是否是整数并添加到 ArrayList
    public static void isInteger(String str) {
        try {
            int number = Integer.parseInt(str);
            numbers.add(number);  // 添加到 numbers 列表中
        } catch (NumberFormatException e) {
            System.out.println("The string is Not a valid integer!");
        }
    }

    // 获取最大元素并排序
    public static void getMax() {
        if (numbers.isEmpty()) {
            System.out.println("No numbers were entered.");
            return;  // 如果没有输入数字，直接返回
        }

        // 使用 Collections.sort() 对列表进行排序
        Collections.sort(numbers);

        // 最大值是排序后的最后一个元素
        int maxNumber = numbers.get(numbers.size() - 1);
        System.out.println("The max number is " + maxNumber);
    }

    public static void main(String[] args) {
        // 不断输入直到用户输入 "exit"
        while (true) {
            System.out.print("Please input an integer (type 'exit' to stop): ");
            String input = sc.nextLine();

            // 用 .equals() 比较字符串内容
            if (input.equals("exit")) {
                break;
            } else {
                isInteger(input);  // 检查并尝试转换为整数
            }
        }

        // 输出最大值
        getMax();
    }
}
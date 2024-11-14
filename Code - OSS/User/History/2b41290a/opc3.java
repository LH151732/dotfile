public class Length {
    public static void main(String[] args) {
        // 检查是否有至少一个命令行参数传递进来
        if (args.length > 0) {
            String input = args[0];
            System.out.println(input);  // 使用 println 防止格式化安全问题
        } else {
            System.out.println("No input provided!");
        }
    }
}
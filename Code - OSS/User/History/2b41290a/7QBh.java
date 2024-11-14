public class Length {
    public static void main(String[] args) {
        if (args.length > 0) {
            String input = args[0];
            System.out.printf(input);
        } else {
            System.out.println("No input provided!");
        }
    }
}
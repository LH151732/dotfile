import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;

public class Maximum {
    static ArrayList<Integer> numbers = new ArrayList<>();
    static Scanner sc = new Scanner(System.in);

    public static void isInteger(String str) {
        try {
            int number = Integer.parseInt(str);
            numbers.add(number);
        } catch (NumberFormatException e) {
            System.out.println("The string is Not a valid integer!");
        }
    }

    public static void getMax() {
        Collections.sort(numbers);

        int maxNumber = numbers.get(numbers.size() - 1);
        System.out.println("The max number is " + maxNumber);
    }

    public static void main(String[] args) {
        while (true) {
            System.out.print("Please input an integer (type 'exit' to stop): ");
            String input = sc.nextLine();

            if (input.equals("exit")) {
                break;
            } else {
                isInteger(input);
            }
        }
        getMax();
    }
}
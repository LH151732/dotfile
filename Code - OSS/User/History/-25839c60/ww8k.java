import java.util.ArrayList;
import java.util.Collection;
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

  public static void getMax(int numbers) {
    Collections.sort(numbers);
    System.out.println("The max nunber is " + numbers[0]);
  }

  public static void main(String[] args) {
    while (true) {
      System.out.print("Please Input a int (exit to stop): ");
      String input = sc.nextLine();
      if (input == "exit") {
        break;
      } else {
        isInteger(input);
      }
    }
    getMax(numbers);
  }
}

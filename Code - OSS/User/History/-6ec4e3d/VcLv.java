import java.util.ArrayList;
import java.util.Scanner;

public class Average {

  private static Scanner sc = new Scanner(System.in);
  private static ArrayList<Integer> numbers = new ArrayList<>();

  public static int getUser() {
    System.out.println("Enter a number: ('-1' to stop)");
    String input = sc.nextLine();
    int number = Integer.parseInt(input);
    return number;
  }

  public static void main(String[] args) {

    int sum = 0;

    while (true) {
      Integer number = getUser();
      if (number >= 0) {
        numbers.add(number);
      } else {
        break;
      }
    }

    for (int count : numbers) {
      sum += count;
      double avg = double(sum) / numbers.size();
    }
    System.out.println("The total number is " + sum);
    System.out.println("The average is " + avg);
  }
}

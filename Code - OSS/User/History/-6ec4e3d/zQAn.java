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
        
       int i = 0;
        int sum = 0;
        int avg = 0;

       while (i == 0) {
            Integer number = getUser();
            if (number >= 0) {
                number.add(number);
            } else {
                i++;
            }
       }
        
       for(int count : numbers) {
            sum += count;
            avg = sum / 2;
       }
        System.out.println("The total number is " + sum);
        System.out.println("The average is " + avg);

    }
}
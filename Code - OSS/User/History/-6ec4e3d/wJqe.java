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

       while (i == 0) {
            Integer number = getUser();
            numbers.add(number);
            if(number < 0 ) {
                break;
            }
       }
        
       for(int count : numbers) {
            sum += count;

       }

    }
}
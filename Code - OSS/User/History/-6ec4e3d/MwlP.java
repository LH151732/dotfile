import java.util.ArrayList;
import java.util.Scanner;

public class Average {
    
    private static Scanner sc = new Scanner(System.in);
    private ArrayList<Integer> numbers;
    
    public static int getUser() {
        System.out.println("Enter a number: ('exit' to stop)");
        String input = sc.nextLine();
        int number = Integer.parseInt(input);
        return number;
    }

    public static void main(String[] args) {
        
        
        

    }
}
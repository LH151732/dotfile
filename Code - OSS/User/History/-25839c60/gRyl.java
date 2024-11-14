import java.util.ArrayList;
import java.util.Scanner;

import javax.print.attribute.standard.NumberOfInterveningJobs;

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
    
    public static void main(String[] args) {
        while(true) {
            System.out.print("Please Input a int (exit to stop): ");
            String input = sc.nextLine();
            isInteger(input);
        }
    }
}
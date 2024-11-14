import java.util.*;

public class InputScanner {

    public static void main(String[] args) {
        
        Scanner sc = new Scanner(System.in);

        System.out.println("Enter an integer: ");
        int integerInput = sc.nextInt();
        System.out.println("You entered: " + integerInput);
        
        System.out.println("Enter a float: ");
        double doubleInput = sc.nextDouble();
        System.out.println("You entered: " + doubleInput);

        sc.nextLine();
        System.out.println("Enter a string: ");
        String stringInput = sc.nextLine();
        System.out.print("You entered: " + stringInput);
        
        sc.close();
    }
}
import java.util.ArrayList;
import java.util.Scanner;

public class Maximum {
    
    static Scanner sc = new Scanner(System.in);
    static ArrayList<Integer> numbers = new ArrayList<>();
    Object number = 0;

    public static void getUser(int number) {
        number = sc.nextInt();
        if(number instanceof Integer ) {
            numbers.add(number);
        }else {
            System.out.println("This is not an Integer nunber!");
        }

    }
}
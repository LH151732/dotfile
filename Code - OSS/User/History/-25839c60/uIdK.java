import java.util.ArrayList;
import java.util.Scanner;

public class Maximum {
    
    static Scanner sc = new Scanner(System.in);
    static ArrayList<Integer> numbers = new ArrayList<>();
    Object number = 0;

    public static void getUser(int number) {
        if(number instanceof Integer ) {
            numbers.add(number);
        }

    }
}
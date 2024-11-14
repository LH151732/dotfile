import java.io.FileNotFoundException;
import java.util.Scanner;

public class FileIO {

    File f = new File("READNE");
    try {
        Scanner sc = new Scanner(f);
    } catch (FileNotFoundException e) {
        System.out.println("File not found!");
    }
}
import java.util.Scanner;

public class FileIO {

    file f = new File("READNE");
    try {
        Scanner sc = new Scanner(f);
    } catch (FileNetFoundException e) {
        System.out.println("File not found!");
    }
}
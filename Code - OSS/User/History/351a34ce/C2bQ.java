import java.util.ArrayList;
import java.util.Iterator;

public class Iteratoes {

    public static void main(String[] args) {
        ArrayList<String> furit = new ArrayList<>();
        furit.add("Apple");
        furit.add("Orange");
        furit.add("Banana");

        Iterator<String> iterator = furit.iterator();
        while (iterator.hasNext()) {
            System.out.println(iterator.next());
        }
        
    }
}
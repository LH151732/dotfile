import java.util.ArrayList;
import java.util.Iterator;

public class Iterator {

    public static void main(String[] args) {
        ArrayList<String> furit = new ArrayList<>();
        furit.add("Apple");
        furit.add("Orange");
        furit.add("Banana");

        Iterator<Stirng> iterator = furit.iterator();
        while (iterator.hasNext()) {
            System.out.println(iterator.next());
        }
        
    }
}
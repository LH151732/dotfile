import java.util.ArrayList;
import java.util.Iterator;

public class remove {

    public static void main(String[] args) {
        ArrayList<String> list = new ArrayList<>();
        list.add("Apple");
        list.add("Banana");
        list.add("Orange");

        Iterator<String> iterator = list.iterator();
        while (iterator.hasNext()) {
            String item = iterator.next();
            if (item.equals("Banana")) {
                iterator.remove();
            }
        }
    }
}
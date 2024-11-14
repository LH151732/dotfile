class Main<T> {

    private T item;

    public void setItem(T item) {
        this.item = item;
    }
    
    public T getItem() {
        return item;
    }
}

public class Box {
    
    public static void main(String[] args) {
        Main<Integer> intMain = new Main<>();
        intMain.setItem(123);
        System.out.println("integer value:" + intMain.getItem());
        
        Main<String> strMain = new Main<>();
        strMain.setItem("Hello");
        System.out.println("String value:" + intMain.getItem());
    }

    
}



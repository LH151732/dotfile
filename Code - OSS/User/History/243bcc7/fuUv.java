class Utils [
    public static <T> void printArray(T[] array) {
        for (T element : array) {
            System.out.println(element);
        }
    }
]

public class Main {

    public static void main(String[] args) {
        Integer[] intArray = {1, 2, 3, 4};
        String[] strArray = {"A", "B", "C"};
        
        Utils.printArray(intArray);
        Utils.printArray(strArray);
    }
}
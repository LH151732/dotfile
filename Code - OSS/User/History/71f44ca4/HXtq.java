interface A {
    public default void myMethod() {
        System.out.println("A");
    }
}

interface B {
    public default void myMethod() {
        System.out.println();
    }
}

public class Interfacedemo implements A, B {
    
     public static void main(String[] args) {
    
 }
    
}
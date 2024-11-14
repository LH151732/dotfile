interface A {
    public default void myMethod() {
        System.out.println("A");
    }
}

interface B {
    public default void myMethod() {
        System.out.println("B");
    }
}

class MyClass implements A, B {
}

public class Interfacedemo {

    public static void main(String[] args) {
        
        new MyClass().myMethod();
        
    }
}
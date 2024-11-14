class Parent {
    public final void display() {
        System.out.println("The is a final method!");
    }
}


public class Child {

    public static void main(String[] args) {
        Parent parent = new Parent();
        parent.display();
    }
}
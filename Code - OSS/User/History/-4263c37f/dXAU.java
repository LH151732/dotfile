interface Animal {
    void makeSound();
}

public class Dog implements Animal{

    public void makeSound() {
        System.out.println("Dog barks");
    }
}
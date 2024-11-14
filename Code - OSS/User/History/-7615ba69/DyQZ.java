import java.util.Scanner;

public class Book {

    private static String title;
    private static String author;
    private static double price;        
    
    static Scanner sc =  new Scanner(System.in);
    
    public Book(String title, String author, double price) {
        this.title = title;
        this.author = author;
        this.price = price;
    }
    
    public double getDiscountedPrice(double discount) {
        return price - (price * discount)
    }
    
    @Override
    public String toString() {
       return "Title:" + title + ", Author: " + author;
    }
    
}
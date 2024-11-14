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
    
    public static void main(String[] args) {
        Book myBook = new Book("Java", "Hao Li", 53.11);

        System.out.println(myBook.toString());
        
        double discount = 0.4;
    }
    
}
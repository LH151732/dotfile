public class StringTest {
    
    public static void main(String[] args) {
        String text  = "String is always special!";

        System.out.println(text.indexOf('i') + " " + text.contains("way"));
        
        text = text.substring(0, 10 ) + "fun";

        String[] str = text.split(" ");
        System.out.println(str.length + " " + str[0].length());
    }
    
}

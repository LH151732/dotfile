public class RecursionDemo {
   
    public void myMethod(int n) {
        if (n/2 ==0 ) System.out.println("P"); 
        else{
           System.out.println("O"); 
            myMethod(n - 1);
        }
    }
}

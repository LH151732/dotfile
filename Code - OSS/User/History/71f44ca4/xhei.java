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

public class Interfacedemo implements A, B {
    // 解决方法冲突，通过覆盖 myMethod 并指定是从哪个接口调用
    @Override
    public void myMethod() {
        // 手动选择使用哪个接口的默认方法
        A.super.myMethod();  // 调用接口 A 的 myMethod
    }

    public static void main(String[] args) {
        new Interfacedemo().myMethod();  // 创建对象并调用 myMethod
    }
}
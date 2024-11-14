class Node<T> {
    public T element;
    public Node<T> next;

    public Node(T element) {
        this.element = element;
        this.next = null;
    }
}

public class LinkedList<T> {
    Node<T> root;

    public LinkedList() {
        root = null;
    }

    public void add(T element) {
        Node<T> newNode = new Node<>(element);
        if (root == null) {
            root = newNode;
        } else {
            Node<T> cursor = root;
            while (cursor.next != null) {
                cursor = cursor.next;
            }
            cursor.next = newNode;
        }
    }

    public int size() {
        int count = 0;
        Node<T> cursor = root;
        while (cursor != null) {
            count++;
            cursor = cursor.next;
        }
        return count;
    }

    public static void main(String[] args) {
        // 测试链表大小
        LinkedList<String> list = new LinkedList<>();
        list.add("A");
        list.add("B");
        list.add("C");

        System.out.println("链表大小: " + list.size());  // 输出: 链表大小: 3
    }
}
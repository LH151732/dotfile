class Node<T> {
    public T element;  // 节点中的数据
    public Node<T> next;  // 指向下一个节点的引用

    public Node(T element) {
        this.element = element;  // 初始化节点的数据
        next = null;  // 默认为 null，表示该节点没有指向任何节点
    }
}

public class LinkedList<T> {
    Node<T> root;  // 链表的头节点

    // 链表的构造函数
    public LinkedList() {
        root = null;  // 初始时，链表为空，root 为空
    }

    // 添加元素到链表末尾
    public void add(T element) {
        Node<T> newNode = new Node<>(element);  // 创建一个新节点
        if (root == null) {  // 如果链表是空的
            root = newNode;  // 第一个节点指向 root
        } else {
            Node<T> cursor = root;  // 否则，从 root 开始
            while (cursor.next != null) {  // 寻找链表的末端
                cursor = cursor.next;
            }
            cursor.next = newNode;  // 将新节点添加到链表末尾
        }
    }

    // 计算链表大小（待实现！）
    public int size() {
        // TODO: 这里是你要实现的
    }
}
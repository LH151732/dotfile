/**
 * 节点类，用于存储链表中的单个元素
 * @param <T> 泛型参数，允许节点存储任意类型的数据
 */
class Node<T> {
    // 存储节点的实际数据
    public T element;
    // 指向下一个节点的引用
    public Node<T> next;

    /**
     * 节点构造函数
     * @param element 要存储的数据元素
     */
    public Node(T element) {
        this.element = element;
        this.next = null;
    }
}

/**
 * 单向链表的实现类
 * @param <T> 泛型参数，定义链表可以存储的数据类型
 */
public class LinkedList<T> {
    // 链表的头节点
    Node<T> root;

    /**
     * 链表构造函数，初始化一个空链表
     */
    public LinkedList() {
        root = null;
    }

    /**
     * 向链表末尾添加新元素
     * @param element 要添加的元素
     */
    public void add(T element) {
        // 创建新节点
        Node<T> newNode = new Node<>(element);
        // 如果链表为空，将新节点设为头节点
        if (root == null) {
            root = newNode;
        } else {
            // 遍历到链表末尾并添加新节点
            Node<T> cursor = root;
            while (cursor.next != null) {
                cursor = cursor.next;
            }
            cursor.next = newNode;
        }
    }

    /**
     * 计算链表中的元素个数
     * @return 返回链表的长度
     */
    public int size() {
        int count = 0;
        // 使用游标遍历整个链表
        Node<T> cursor = root;
        while (cursor != null) {
            count++;
            cursor = cursor.next;
        }
        return count;
    }

    /**
     * 主方法，用于测试链表的基本功能
     */
    public static void main(String[] args) {
        // 测试链表大小
        LinkedList<String> list = new LinkedList<>();
        list.add("A");
        list.add("B");
        list.add("C");

        System.out.println("链表大小: " + list.size());  // 输出: 链表大小: 3
    }
}

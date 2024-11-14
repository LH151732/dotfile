// Define the Node class for the binary tree
class Node {
    int value;         
    Node left, right;  // Left and right child nodes (subtrees)

    // Constructor to initialize the node with a value and set its left and right child to null
    public Node(int item) {
        value = item;
        left = right = null;  // Initially, the node has no children
    }
}

// Define the Binary Search Tree (BST) class
public class BST {

    // Insert a new node into the Binary Search Tree (BST)
    public Node insert(Node root, int value) {
        // If the root node is null, create a new node
        if (root == null) {
            root = new Node(value);  // Create and return a new node
            return root;
        }

        // Recursively insert to either the left or right subtree
        if (value < root.value) {  // If the new value is less than the root's value
            root.left = insert(root.left, value);    // Insert into the left subtree
        } else {  // If the new value is greater or equal to the root's value
            root.right = insert(root.right, value);  // Insert into the right subtree
        }

        return root;  // Return the root node after insertion
    }

    // Search for a value in the Binary Search Tree (BST)
    public Node search(Node root, int key) {
        // If the tree is empty, or the key is found at the current node, return the node
        if (root == null || root.value == key) {
            return root;
        }

        // If the key is smaller than the current node, search in the left subtree
        if (key < root.value) {
            return search(root.left, key);
        }

        // Otherwise, search in the right subtree
        return search(root.right, key);
    }

    // Main function
    public static void main(String[] args) {
        BST tree = new BST(); // Create a new Binary Search Tree object
        Node root = null;     // Initialize the root node as null
        
        // Insert nodes into the Binary Search Tree
        root = tree.insert(root, 10);  // Insert node with value 10
        root = tree.insert(root, 5);   // Insert node with value 5
        root = tree.insert(root, 20);  // Insert node with value 20
        root = tree.insert(root, 3);   // Insert node with value 3
        root = tree.insert(root, 8);   // Insert node with value 8
        root = tree.insert(root, 7);
        
        // Search for the key 7
        if (tree.search(root, 7) != null) {
            System.out.println("Key found 7!");  // If the key 7 is found
        } else {
            System.out.println("Key missing 7!"); // If the key 7 is not found
        }
    }
}

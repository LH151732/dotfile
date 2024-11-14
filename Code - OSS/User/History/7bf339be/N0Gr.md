$ Week 2 & 1 <Stack & Queue>

# LIFO (Last in, First out) - Stack
  Stanard Stack
  Use <push> to input array & <pop> to take out array

Eg.
```plaintext
Initialize an empty stack

Push(item):
    Add item to the top of the stack

Pop():
    If stack is not empty:
        Remove and return the item from the top of the stack
    Else:
        Return error (e.g., "Stack is empty")

Peek():
    If stack is not empty:
        Return the item from the top of the stack
    Else:
        Return error (e.g., "Stack is empty")

IsEmpty():
    If stack size is 0:
        Return true
    Else:
        Return false
```
loginc process:

```plaintext
Initialize stack
Push(1)
Push(2)
Push(3)
Pop()  => returns 3
Peek() => returns 2
Pop()  => returns 2\
```


## FIFO(First in Fisrt out) - Queue 

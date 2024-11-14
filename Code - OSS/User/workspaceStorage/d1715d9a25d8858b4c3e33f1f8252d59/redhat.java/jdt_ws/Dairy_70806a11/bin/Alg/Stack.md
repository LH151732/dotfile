$ Week 2 & 1 <Stack & Queue>

# **LIFO** (Last in, First out) - Stack
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
   Stanard queue
   Use <enqueue> to input array & <queue> to take out array

Eg.
```plaintext
Initialize an empty queue

Enqueue(item):
    Add item to the back of the queue

Dequeue():
    If queue is not empty:
        Remove and return the item from the front of the queue
    Else:
        Return error (e.g., "Queue is empty")

Front():
    If queue is not empty:
        Return the item from the front of the queue
    Else:
        Return error (e.g., "Queue is empty")

IsEmpty():
    If queue size is 0:
        Return true
    Else:
        Return false
```
logic process:
```plaintext
Initialize queue
Enqueue(1)
Enqueue(2)
Enqueue(3)
Dequeue() => returns 1
Front()   => returns 2
Dequeue() => returns 2
```

1. 栈 ：元素像在一摞盘子上操作，需先移除上层元素才可操作下层.
2. 队列 ：类似于排队，先来的先服务.
     
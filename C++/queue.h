#include <stdexcept>
#include <iostream>

using namespace std;

template <class T>
class Queue {

  struct Node {
    T item;
    Node* next;
  };

  Node* head = nullptr;
  Node* tail = nullptr;
  int size = 0;

  public:

    ~Queue() {
      while (head != nullptr) {
        dequeue();
      }
    }


    Queue() = default;

    Queue(const Queue& q) = delete;

    Queue& operator=(const Queue& q) = delete;

    Queue(Queue&& q): size(q.size), head(q.head), tail(q.tail) {
      q.head = nullptr;
      q.tail = nullptr;
      q.size = 0;
    }

    Queue& operator=(Queue&& q) {
      if (&q != this) {
        size = q.size;
        head = q.head;
        tail = q.tail;
        q.head = nullptr;
        q.tail = nullptr;
        q.size = 0;
      }
      return *this;
    }

    void enqueue (T item) {
      Node* node = new Node {item, nullptr};
      if (size == 0) {
        head = node;
        tail = node;
      } else {
        tail->next = node;
        tail = node;
      }
      size++;
    }

    T dequeue () {
      if (size == 0) {
        throw underflow_error("Trying to dequeue an empty queue.");
      }
      Node* temp = head;
      T tempValue = temp->item;
      head = temp->next;
      size--;
      delete temp;
      return tempValue;
    }

    int get_size () {
      return size;
    }
};

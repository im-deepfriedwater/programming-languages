#include "queue.h"
#include <cassert>
#include <iostream>

using namespace std;

int main () {
  Queue<int> q;
  // q.enqueue(3);
  try {
    cout << q.dequeue();

  } catch (const underflow_error& e) {
    cerr << "Error: " << e.what() << "\n";
  }
}
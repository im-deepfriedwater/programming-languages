1.

A[0][0] = 0x55f48c30f1c0
A[3][7] = 0x55f48c30f2e8

The size of the struct we declared is 5 bytes because int is 4 and char is 1.
However, there is padding so each slot, starting from A[0][0], would be 8 bytes each.
This is because the stack should be kept aligned with multiples of 4 byte boundaries.
So instead of 5 bytes, it will be the next largest 4 multiple, 8.
Therefore the difference between A[0][0] and A[3][7] should be 37 * 8, which is 296.
296 in hex would be 0x128, which is the difference of 0x55f48c30f2e8 and 0x55f48c30f1c0.

2.

double *a[n];
This declares an array a of n double pointers.
double (*b)[n];
This declares a pointer to an array of n doubles.
double (*c[n])();
This declares an array c of n pointers to functions that return doubles.
double (*d())[n];
This declares a function returning a pointer to an array of n doubles.


3.

double (*f(double (*)(double, double[]), double)) (double, ...);

double (*)(double, double[]) is function pointer that takes in a double and a double array and returns a double.
Then the function pointed to by f takes the function pointer above and a double and returns a function.
Then the returned function (by f) takes in a double and any type and any variable after the double and returns a double.
Therefore this declaration declares a function that takes in a double and any number of any type variables.


4.

class Base {
public:
  int a;
  std::string b;
};

class Derived: public Base {
public:
  float c;
  int b;
};


It contains two b fields and they are both accessible.
The string b field is in base namespace which is in derived.
The string b is accessible when we refer derived as a pointer like below.
Since there are two variables of different types named b, we use namespace to look up specific b from the Base.

Derived* dp = new Derived;
cout << dp->Base::b << endl;


5.

The output of the program was 2 5 2 with new lines after each number.
For static scoping, the program looks at the scope that the variable is used and then it checks each outer scopes all the way up to the global scope.
First, g is called which calls f. Then f looks for x to output in its scope, then goes to the scope above it, which is the global scope and finds int x = 2.
Then we go back g and finds the int x = 5 in the current scope (in function g) and prints out 5.
Finally, it goes back to the main function and searches for x in the current scope (in main) but does not find x in there.
So it looks at the scope above it which is the global scope and finds int x = 2, and prints out 2.
If C++ was dynamically scoped, the output would have been 5 5 2.

6.

a) void scrambleRaw(T[]& a)
b) void scrambleStd(std::array<T>& a)

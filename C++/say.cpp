#include <cassert>
#include <string>
#include <iostream>

using namespace std;

struct Say {
private:
  string sentence;
public:
  Say(string word = ""): sentence(word) {}
  Say operator()(string word) {
    return Say{sentence + " " + word};
  }

  string operator()() {
    return sentence == "" ? sentence : sentence.substr(1, sentence.length() - 1);
  }
};

int main () {
  Say say;

  assert(say() == "");
  assert(say("hi")() == "hi");
  assert(say("hi")("there")() == "hi there");
  assert(say("dog")("says")("meow")() == "dog says meow");
  assert(say("hello")("my")("name")("is")("Colette")() == "hello my name is Colette");

  return 0;
}

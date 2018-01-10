#include <iostream>
#include <string>
#include <map>
#include <set>
#include <functional>
#include <algorithm>

using namespace std;

int main(int argc, char** argv) {
  if (argc < 2) {
    cerr << "This program requires at least one word.\n";
    return -1;
  }

  map<string, int> word_count;

  char** first_word = argv + 1;
  for_each(first_word, first_word + argc - 1, [&word_count] (char* word_array) {
    string word = "";
    for_each(word_array, word_array + strlen(word_array), [&word, &word_count] (char c) {
      if (!isalpha(c)) {
        if (word != "") {
          word_count[word] += 1;
          word = "";
        }
      } else {
        word += tolower(c);
      }
    });
    if (word != "") {
      word_count[word] += 1;
    }
    word = "";
  });

  set<pair<int, string>, greater<pair<int, string>>> descending_word_count;

  for (map<string, int>::iterator iter = word_count.begin(); iter != word_count.end(); ++iter) {
    descending_word_count.insert(make_pair(iter -> second, iter -> first));
  }

  for (set<pair<int, string>, greater<pair<int, string>>>::iterator iter = descending_word_count.begin(); iter != descending_word_count.end(); ++iter) {
    cout << iter ->first << " => " << iter ->second << endl;
  }
}

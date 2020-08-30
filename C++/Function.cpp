#include <iostream>
#include <vector>
#include <string>
#include <sstream>
#include "Function.h"

using std::cout;
using std::endl;
using std::vector;
using std::string;
using std::stringstream;

Function::Function(int n, vector<int> values): n(n), values(values) {}

Function::Function(int n): n(n), values(n) {}

Function::Function(Function& f): n(f.n), values(f.n) {
  cout << "Waa." << endl;
  for(vector<int>::iterator it = values.begin(), jt = f.values.begin(); it != values.end(), jt != f.values.end(); it++, jt++) {
    *it = *jt;
  }
}

Function& Function::incrementFunction() {
  values.back()++;
  for(vector<int>::reverse_iterator it = values.rbegin()
    ; it != values.rend() && *it == n; it++) {
      if(it+1 != values.rend()) ++*(it+1);
      *it = 0;
      //cout << *it << ' ' << ++*(it+1) << endl;
  }
  return *this;
}

Function& Function::operator++(int) {
  return incrementFunction();
}

Function& Function::operator+=(int num) {
  for(int i=0; i<num; i++) {
    incrementFunction();
  }
  return *this;
}

Function& Function::compose(Function& first) {
  Function &comp = *(new Function(n));
  for(vector<int>::iterator it = comp.values.begin(), jt = first.values.begin()
    ; it != comp.values.end(), jt != first.values.end(); it++, jt++) {
    *it = values[*jt];
  }
  return comp;
}

Function& Function::operator*(Function& first) {
  return compose(first);
}

string Function::toString() {
  stringstream ss;
  
  //cout << "TEST" << endl;
  for(vector<int>::const_iterator it = values.cbegin()
    ; it != values.cend(); it++) {
    ss << *it;
  }
  return ss.str();
}

ostream& operator<<(ostream &os, Function &f) {
  //cout << "test" << endl;
  os << f.toString();
  return os;
}

int main() {
  Function test(3);
  cout << "Not error yet..." << endl;
  for(int i=0; i<30; i++) {
    cout << test++ << endl;
  }
  Function test2(3, {0, 2, 1});
  test = Function(3, {1, 2, 0});
  Function &result = test2*test;
  cout << test2 << '*' << test << '=' << result << endl;
  delete &result;
  
  return 0;
}
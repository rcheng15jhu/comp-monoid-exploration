#ifndef FUN_H
#define FUN_H

#include <iostream>
#include <vector>
#include <string>

using std::cout;
using std::endl;
using std::vector;
using std::string;
using std::ostream;

class Function {
  int n;
  
  vector<int> values;
  
public:
  Function(int n = 1);
  
  Function(int n, vector<int> values);
  
  Function(Function& f);
  
  Function& incrementFunction();
  
  Function& operator++(int);
  
  Function& operator+=(int num);
  
  Function& compose(Function& first);
  
  Function& operator*(Function& first);
  
  string toString();
  
  friend ostream& operator<<(ostream &os, Function &f);
  
};

#endif
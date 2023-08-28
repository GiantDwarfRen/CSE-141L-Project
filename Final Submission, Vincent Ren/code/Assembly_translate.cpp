#include <bitset>
#include <fstream>
#include <iostream>

using namespace std;

int main() {
  ifstream input(
      "input.txt"); // Replace "input.txt" with the actual input file name
  ofstream output("mach_code.txt");

  if (!input.is_open()) {
    cerr << "Error opening input file." << std::endl;
    return 1;
  }

  if (!output.is_open()) {
    cerr << "Error opening output file." << std::endl;
    return 1;
  }

  string line;
  while (getline(input, line)) {
    string op = line.substr(0, 3);
    string mach = "";

    if (op != "BRC") {
      string op1 = line.substr(5, 1);
      string op2 = line.substr(8, 2);
      int num1 = atoi(op1.c_str());
      bitset<2> BR1(num1);
      string b1 = BR1.to_string();
      if (op == "LDR") {
        mach += "000";
        int num2 = atoi(op2.substr(1).c_str());
        bitset<2> BR2(num2);
        string b2 = BR2.to_string();
        mach += b1;
        mach += b2;
        mach += "00";
      } else if (op == "STR") {
        mach += "001";
        int num2 = atoi(op2.substr(1).c_str());
        bitset<2> BR2(num2);
        string b2 = BR2.to_string();
        mach += b2;
        mach += b1;
        mach += "00";
      } else if (op == "XOR") {
        mach += "011";
        int num2 = atoi(op2.substr(1).c_str());
        bitset<2> BR2(num2);
        string b2 = BR2.to_string();
        mach += b1;
        mach += b2;
        mach += "00";
      } else if (op == "ADR") {
        mach += "010";
        int num2 = atoi(op2.substr(1).c_str());
        bitset<2> BR2(num2);
        string b2 = BR2.to_string();
        mach += b1;
        mach += b2;
        mach += "00";
      } else if (op == "MOV") {
        mach += "100";
        int num2 = atoi(op2.c_str());
        bitset<4> BR2(num2);
        string b2 = BR2.to_string();
        mach += b1;
        mach += b2;
      } else if (op == "LSH") {
        mach += "101";
        int num2 = atoi(op2.c_str());
        bitset<4> BR2(num2);
        string b2 = BR2.to_string();
        mach += b1;
        mach += b2;
      } else if (op == "ADI") {
        mach += "110";
        int num2 = atoi(op2.c_str());
        bitset<4> BR2(num2);
        string b2 = BR2.to_string();
        mach += b1;
        mach += b2;
      }
    } else if (op == "BRC") {
      mach += "111";
      string op1 = line.substr(4, 3);
      int num1 = atoi(op1.c_str());
      bitset<6> BR1(num1);
      string b1 = BR1.to_string();
      mach += b1;
    } else {
      cerr << "Instruction wrong" << endl;
      return 1;
    }
    output << mach << endl;
  }

  input.close();
  output.close();
  return 0;
}

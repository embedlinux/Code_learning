#ifndef _C8_1_H
#define  _C8_1_H

/*
	求两个复数的加减乘除。
*/

#include <cstdio>
#include <cstring>
#include <iostream>
#include <algorithm>

using namespace std;

class Complex{
public:
	Complex(double r = 0.0, double i = 0.0): real(r), imag(i) {};
	Complex operator+ (const Complex &c2) const;
	Complex operator- (const Complex &c2) const;

	/*实现下面三个函数*/
	Complex operator* (const Complex &c2) const;
	Complex operator/ (const Complex &c2) const;
	friend ostream & operator<< (ostream &out, const Complex &c);

private:
	double real;
	double imag;
};



#endif

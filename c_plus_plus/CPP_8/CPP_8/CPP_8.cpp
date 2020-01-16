// CPP_8.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include "C8_1.h"
#include "C8_2.h"
#include "C8_3.h"

extern int getVertexCount(Shape3 * b);

int _tmain(int argc, _TCHAR* argv[])
{
	//double real, imag;
	//cin >> real >> imag;
	//Complex c1(real, imag);
	//cin >> real >> imag;
	//Complex c2(real, imag);
	//cout << c1 + c2;
	//cout << c1 - c2;
	//cout << c1 * c2;
	//cout << c1 / c2;

	//double radius;
	//cin >> radius;
	//Circle c(radius);
	//cout << c.getArea() << " " << c.getPerim() << endl;

	Shape3 s;
	cout << getVertexCount(&s) << endl;
	Triangle t;
	cout << getVertexCount(&t) << endl;
	Rectangle r;
	cout << getVertexCount(&r) << endl;


	return 0;
}


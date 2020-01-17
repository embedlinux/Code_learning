#ifndef _ADDTWONUM_H
#define _ADDTWONUM_H
/*
声明了两个基类Base1和Base2，然后从这两个基类按照公有方式派生出类Derived。
	基类和派生类都各自包含一个公有成员x，并且Base1和Base2各有接受一个整型参数的构造函数，
	Derived的构造函数接受Base1和Base2的对象引用a，b来初始化Derived类对象，并令x为Base1::x和Base2::x之和。请将下面的代码补充完成，使得输出符合要求。

*/
#include <iostream>
using namespace std;

struct Base11
{
	int x;
	Base11(int x);
};

struct Base12
{
	int x;
	Base12(int x);
};

struct Derived :public Base11, public Base12
{
	int x;
	Derived(Base11& a, Base12& b);
};


#endif // !_ADDTWONUM_H

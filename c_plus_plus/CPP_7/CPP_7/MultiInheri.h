#ifndef _MULTIINHERI_H
#define _MULTIINHERI_H

/*
	声明了三个基类Base1、Base2和Base3，然后从这三个基类按照公有方式派生出类Derived。
	在每个类中分别定义带一个整型参数的构造函数和析构函数输出提示信息，构造函数的提示信息中需要包含整型参数的数值。
*/

#include <iostream>
using namespace std;

class Base1
{
	public:
		Base1(int x);
		~Base1();
};

class Base2
{
	public:
		Base2(int x);
		~Base2();
};
class Base3
{
	public:
		Base3(int x);
		~Base3();
};

class Derived:public Base2, public Base1, public Base3//继承上面3个类
{
	public:
		Derived(int x1, int x2, int x3, int x4);
		~Derived();
};



#endif // !_MULTIINHERI_H


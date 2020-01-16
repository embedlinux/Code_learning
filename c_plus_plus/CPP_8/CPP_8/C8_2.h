#ifndef _C8_2_H
#define  _C8_2_H

/*
	求圆的周长和面积，已知圆类从shape抽象类继承。

*/

#include <iostream>
using namespace std;

const double pi = 3.14;

class Shape{
public:
	Shape(){}
	~Shape(){}
	virtual double getArea() = 0;
	virtual double getPerim() = 0;
};

class Circle: public Shape{
public:
	Circle(double rad):radius(rad){}
	~Circle(){}

	/*补充这两个函数*/
	double getArea();
	double getPerim();
private:
	double radius;
};



#endif

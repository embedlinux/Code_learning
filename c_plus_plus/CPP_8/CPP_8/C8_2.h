#ifndef _C8_2_H
#define  _C8_2_H

/*
	��Բ���ܳ����������֪Բ���shape������̳С�

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

	/*��������������*/
	double getArea();
	double getPerim();
private:
	double radius;
};



#endif

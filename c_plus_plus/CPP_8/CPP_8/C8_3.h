#ifndef _C8_3_H
#define  _C8_3_H

/*
	在多态概念中，基类的指针既可以指向基类的对象，又可以指向派生类的对象。
	可以使用dynamic_cast类型转换操作符来判断当前指针（必须是多态类型）是否能够转换成为某个目的类型的指针。
	dynamic_cast的使用说明（如http://en.wikipedia.org/wiki/Run-time_type_information#dynamic_cast）

	函数int getVertexCount(Shape * b)计算b的顶点数目，
		若b指向Shape类型，返回值为0；
		若b指向Triangle类型，返回值为3；
		若b指向Rectangle类型，返回值为4。

*/

#include <cstdio>
#include <cstring>
#include <iostream>
using namespace std;

class Shape3{
public:
	Shape3() {}
	virtual ~Shape3() {}
};

class Triangle: public Shape3{
public:
	Triangle() {}
	~Triangle() {}
};

class Rectangle: public Shape3{
public:
	Rectangle() {}
	~Rectangle() {}
};


#endif

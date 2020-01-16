#ifndef _C8_3_H
#define  _C8_3_H

/*
	�ڶ�̬�����У������ָ��ȿ���ָ�����Ķ����ֿ���ָ��������Ķ���
	����ʹ��dynamic_cast����ת�����������жϵ�ǰָ�루�����Ƕ�̬���ͣ��Ƿ��ܹ�ת����Ϊĳ��Ŀ�����͵�ָ�롣
	dynamic_cast��ʹ��˵������http://en.wikipedia.org/wiki/Run-time_type_information#dynamic_cast��

	����int getVertexCount(Shape * b)����b�Ķ�����Ŀ��
		��bָ��Shape���ͣ�����ֵΪ0��
		��bָ��Triangle���ͣ�����ֵΪ3��
		��bָ��Rectangle���ͣ�����ֵΪ4��

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

#ifndef _ADDTWONUM_H
#define _ADDTWONUM_H
/*
��������������Base1��Base2��Ȼ������������ఴ�չ��з�ʽ��������Derived��
	����������඼���԰���һ�����г�Աx������Base1��Base2���н���һ�����Ͳ����Ĺ��캯����
	Derived�Ĺ��캯������Base1��Base2�Ķ�������a��b����ʼ��Derived����󣬲���xΪBase1::x��Base2::x֮�͡��뽫����Ĵ��벹����ɣ�ʹ���������Ҫ��

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

#ifndef _MULTIINHERI_H
#define _MULTIINHERI_H

/*
	��������������Base1��Base2��Base3��Ȼ������������ఴ�չ��з�ʽ��������Derived��
	��ÿ�����зֱ����һ�����Ͳ����Ĺ��캯�����������������ʾ��Ϣ�����캯������ʾ��Ϣ����Ҫ�������Ͳ�������ֵ��
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

class Derived:public Base2, public Base1, public Base3//�̳�����3����
{
	public:
		Derived(int x1, int x2, int x3, int x4);
		~Derived();
};



#endif // !_MULTIINHERI_H


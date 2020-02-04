#include "stdafx.h"
#include <iostream>
using namespace std;


template <typename T>
void myswap(T &a, T &b)
{
	T t;
	t = a;
	a = b;
	b = t;
	cout<<"myswap ģ�庯�� do"<<endl;
}
void myswap(char &a, int &b)
{
	int t;
	t = a;
	a = b;
	b = t;
	cout<<"myswap ��ͨ���� do"<<endl;
}

//-----------------------------------------------------------------------------

int Max(int a, int b)
{
	cout<<"int Max(int a, int b)"<<endl;
	return a > b ? a : b;
}

template<typename T>
T Max(T a, T b)
{
	cout<<"T Max(T a, T b)"<<endl;
	return a > b ? a : b;
}

template<typename T>
T Max(T a, T b, T c)
{
	cout<<"T Max(T a, T b, T c)"<<endl;
	return Max(Max(a, b), c);
}

void main()
{
	//char cData = 'a';
	//int iData = 2;
	//// myswap<int>(cData, iData); // ����:����ģ�岻�ṩ��ʽ����������ת���������ϸ��ƥ��

	//myswap(cData, iData); 
	//// myswap(iData, cData);

	//cout<<"hello..."<<endl;
	//system("pause");
	//return ;

	int a = 1;
	int b = 2;
	cout<<Max(a, b)<<endl;			// ������ģ�����ͨ���������ϵ���ʱ , ����ѡ����ͨ����
	cout<<Max<>(a, b)<<endl;		// ����ʾʹ�ú���ģ�� , ��ʹ�� <> �����б�
	cout<<Max(3.0, 4.0)<<endl;		// �������ģ��������õ�ƥ��ʹ�ú���ģ��
	cout<<Max(5.0, 6.0, 7.0)<<endl; // ����
	cout<<Max('a', 100)<<endl;		// ������ͨ����������ʽ����ת��
	system("pause");
	return ;
}
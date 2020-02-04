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
	cout<<"myswap 模板函数 do"<<endl;
}
void myswap(char &a, int &b)
{
	int t;
	t = a;
	a = b;
	b = t;
	cout<<"myswap 普通函数 do"<<endl;
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
	//// myswap<int>(cData, iData); // 结论:函数模板不提供隐式的数据类型转换必须是严格的匹配

	//myswap(cData, iData); 
	//// myswap(iData, cData);

	//cout<<"hello..."<<endl;
	//system("pause");
	//return ;

	int a = 1;
	int b = 2;
	cout<<Max(a, b)<<endl;			// 当函数模板和普通函数都符合调用时 , 优先选择普通函数
	cout<<Max<>(a, b)<<endl;		// 若显示使用函数模板 , 则使用 <> 类型列表
	cout<<Max(3.0, 4.0)<<endl;		// 如果函数模板产生更好的匹配使用函数模板
	cout<<Max(5.0, 6.0, 7.0)<<endl; // 重载
	cout<<Max('a', 100)<<endl;		// 调用普通函数可以隐式类型转换
	system("pause");
	return ;
}
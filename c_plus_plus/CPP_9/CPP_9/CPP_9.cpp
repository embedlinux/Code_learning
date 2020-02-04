// CPP_9.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include <iostream>
#include <math.h>
#include <string>
#include <cassert> 

using namespace std;

template <class  T>
void mySwap(T &x, T &y)
{
	T temp = x;
	x = y;
	y = temp;
}

template <class T>
void  bubbleSort(T a[], int n)
{
	int count = 0;
	int i = n-1;
	while(i > 0)
	{
		int lastExchange = 0;
		for(int j = 0; j < i; j++)
		{
			if(a[j] > a[j + 1])
			{
				mySwap(a[j],a[j+1]);
				lastExchange = j;
				count++;
			}
		}
		i = lastExchange;
	}
	cout << count<<endl;
	for(int i =0;i<n;i++)
	{
		cout << a[i]<< " ";
	}
	system("pause");
}

//编写一个模板函数getSum，接收一个数组，返回该数组所有元素的和。部分代码已给出，请将代码填补完整。
template <class T>
T getSum(T array[], int n)
{
	T retsum = 0;
	for(int i = 0;i < n;i++)
	{
		retsum += array[i];
	}
	return retsum;
}

// 编写一个折半查找的模板函数binSearch()，接收一个数组，数组长度和要查找的元素key，按查找顺序输出查找过程中访问的所有元素下标。

template <class T>
void binSearch(T arr[], int n, T key)
{
	int low = 0;
	int high = n-1;
	int mid;
	while(1)
	{
		mid = (low + high) / 2;
		cout << mid << endl;
		if (low > high)
			return;
		if (abs(arr[mid] - key)< 1e-10)
			return;
		else if(arr[mid] > key)
		{
			high = mid -1;
		}
		else
		{
			low = mid + 1;
		}
	}

}


// 栈模板
template<class T, int MAX = 1000>
class Stack
{
	private:
		T list[MAX + 1];
		int top;
	public:
		Stack();
		void push(const T &item);		// 将item压栈
		T pop();						// 将栈顶元素弹出栈
		const T & peek() const;			// 访问栈顶元素
		bool isEmpty() const;			// 判断是否栈空
		bool isFull() const;
		void clear();
};

template <class T, int MAX>
Stack<T, MAX>::Stack() : top(-1) 
{
}   

template <class T, int MAX>
void Stack<T, MAX>::push(const T &item)
{
	assert(!isFull());  
	list[++top] = item;
}

template <class T, int MAX>
T Stack<T, MAX>::pop() {   
	assert(!isEmpty()); 
	return list[top--]; 
}

template <class T, int MAX>
const T &Stack<T, MAX>::peek() const {
	assert(!isEmpty()); 
	return list[top];				//返回栈顶元素
}

template <class T, int MAX>
bool Stack<T, MAX>::isEmpty() const {
	return top == -1;
}

template <class T, int MAX>
bool Stack<T, MAX>::isFull() const {   
	return top == MAX;
}

template <class T, int MAX>
void Stack<T, MAX>::clear() {  
	top = -1;
}


void isMatchString()
{
	string str;
	while (cin >> str)
	{
		int flag = 0;
		int len = str.length();
		Stack<char> t;
		for(int i= 0;i< len;i++)
		{
			if (str[i] == '(')
				t.push(str[i]);
			else if (str[i] == ')')
			{
				if(t.isEmpty())
					flag = 1;
				else
					t.pop();
			}
		}

		if(!t.isEmpty())
			flag = 1;
		if(flag)
			cout << "No"<< endl;
		else
			cout << "Yes"<< endl;
		str = "";
	}

}





int _tmain(int argc, _TCHAR* argv[])
{
	//int array[] = {8, 5, 2, 4, 3 };
	//bubbleSort(array, 5);
	//return 0;

	//int n, m;
	//cin >> n >> m;
	//int* arr_int = new int[n];
	//double* arr_double = new double[m];
	//for (int i = 0; i < n; ++i)
	//	cin >> arr_int[i];
	//for (int i = 0; i < m; ++i)
	//	cin >> arr_double[i];
	//cout << getSum(arr_int, n) << endl;
	//cout << getSum(arr_double, m) << endl;
	//system("pause");

	//int n, m;
	//int key1;
	//double key2;
	//cin >> n >> m >> key1 >> key2;
	//int* arr_int = new int[n];
	//double* arr_double = new double[m];
	//for (int i = 0; i < n; ++i)
	//	cin >> arr_int[i];
	//for (int i = 0; i < m; ++i)
	//	cin >> arr_double[i];
	//binSearch(arr_int, n, key1);
	//binSearch(arr_double, m, key2);

	isMatchString();

	return 0;
}


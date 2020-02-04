// CPP_9.cpp : �������̨Ӧ�ó������ڵ㡣
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

//��дһ��ģ�庯��getSum������һ�����飬���ظ���������Ԫ�صĺ͡����ִ����Ѹ������뽫�����������
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

// ��дһ���۰���ҵ�ģ�庯��binSearch()������һ�����飬���鳤�Ⱥ�Ҫ���ҵ�Ԫ��key��������˳��������ҹ����з��ʵ�����Ԫ���±ꡣ

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


// ջģ��
template<class T, int MAX = 1000>
class Stack
{
	private:
		T list[MAX + 1];
		int top;
	public:
		Stack();
		void push(const T &item);		// ��itemѹջ
		T pop();						// ��ջ��Ԫ�ص���ջ
		const T & peek() const;			// ����ջ��Ԫ��
		bool isEmpty() const;			// �ж��Ƿ�ջ��
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
	return list[top];				//����ջ��Ԫ��
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


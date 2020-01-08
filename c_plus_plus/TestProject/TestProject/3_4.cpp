#include "pch.h"
#include <iostream>
#include <iomanip>

using namespace std;

void max_num(int &a, int &b)	//a是较大者
{
	int temp;
	if(a < b)
	{
		temp = a;
		a = b;
		b = temp;
	}
}

bool isrighttar()
{
	int a,b,c;
	cin>>a;
	cin>>b;
	cin>>c;
	max_num(a,b);
	max_num(a,c);
	if (a*a == b*b + c*c)
		return true;
	else
		return false;
}


/*
只包含因子2,3,5的正整数被称作丑数，比如4,10,12都是丑数，而7,23,111则不是丑数，另外1也不是丑数。
请编写一个函数，输入一个整数n，能够判断该整数是否为丑数，如果是，则输出True，否则输出False。
*/

bool islugynum()
{
	int a;
	cin>>a;
	if(a == 1)
		return false;
	while(a != 1)
	{
		if ((a % 2 == 0)|| (a%3==0)||(a%5==0))
		{
			if (a % 2 == 0)
				a /=2;
			else if (a%3==0)
				a /=3;
			else if(a%5==0)
				a /= 5;
			continue;
		}
		if (a != 1)
			return false;
	}
	return true;
}

int main()
{
	bool ret;
//	ret = isrighttar();
	ret = islugynum();
	if (ret)
	{
		cout<<"True"<<endl;
	}
	else
	{
		cout<<"False"<<endl;
	}


	return 0;
}
#include "pch.h"
#include <iostream>
#include <iomanip>

using namespace std;

void max_num(int &a, int &b)	//a�ǽϴ���
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
ֻ��������2,3,5������������������������4,10,12���ǳ�������7,23,111���ǳ���������1Ҳ���ǳ�����
���дһ������������һ������n���ܹ��жϸ������Ƿ�Ϊ����������ǣ������True���������False��
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
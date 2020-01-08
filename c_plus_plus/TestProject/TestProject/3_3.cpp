#include "pch.h"
#include <iostream>
#include <iomanip>

using namespace std;

// 
double acrtan(double x)
{
	int i = 1;
	double sqr = x * x;
	double e = x;
	double retsum = 0;
	while (e / i > 1e-15)
	{
		if (i % 4 == 1)
		{
			retsum += e / i;
		}
		else
		{
			retsum -= e / i;
		}
		i += 2;
		e *= sqr;
	}
	return retsum;
}

//寻找并输出11~999之间的数m，它满足m、m2和m3均为回文数。
bool issymm(unsigned int m)
{
	unsigned i = m;
	unsigned n = 0;
	while (i > 0)
	{
		n = n * 10 + i % 10;
		i /= 10;
	}
	return n == m;
}

//用递归法计算从n个人中选k个人组成一个委员会的不同组合数。
//由n个人里选k个人的组合数 = 由n - 1个人里选k个人的组合数 + 由n - 1个人里选k - 1个人的组合数；
//当n = k或k = 0时，组合数为1。

int comm(int n, int k)
{
	if (k > n)
		return 0;
	else if (n == k || k == 0)
		return 1;
	else
		return comm(n - 1, k) + comm(n - 1, k - 1);
}



int main()
{
	double a = 16.0 * acrtan(1 / 5.0);
	double b = 4.0*acrtan(1 / 239.0);
	cout << "PI is:" << a - b << endl;

	//for (int i = 11; i < 1000; i++)
	//{
	//	if (issymm(i) && issymm(i * i) && issymm(i * i * i))
	//	{
	//		cout << "m is:" << i<<" ; ";
	//		cout << "m^2 is: " << i * i << " ; ";
	//		cout << "m^3 is:" << i * i * i << " ; ";
	//	}
	//	cout << endl;
	//}
	cout << "Comm(9,5) is:" << comm(5, 9) << endl;
	return 0;
}


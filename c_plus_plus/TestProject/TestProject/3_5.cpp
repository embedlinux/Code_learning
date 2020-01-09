#include "pch.h"
#include <iostream>
#include <iomanip>
#include <string>
#include <cmath>
using namespace std;


void swap(int &a, int &b)
{
	int temp;
	temp = a;
	a = b;
	b = temp;
}

// 辗转相除，求最大公约数
void maxcomdiv()
{
	int a, b,ret;
	cin >> a;
	cin >> b;

	if (a < b)
	{
		swap(a, b);
	}
	while (a % b != 0)
	{
		ret = a % b;
		a = b;
		b = ret;
	}
	cout << b;

}

// 回文字符串
bool ispalinstring(int low, int high, char* string, int len)
{
	if ((len == 0) || (len == 1))
		return true;
	else if (string[low] != string[high])
		return false;
	return ispalinstring(low + 1, high - 1, string, len - 2);
}


//走楼梯，假设有n阶楼梯，小明一次可以选择走1阶，也可以选择走2阶，问多少种走法。

int walkstair(int n)
{
	if (n == 1)
		return 1;
	else if (n == 2)
		return 2;
	return walkstair(n - 1) + walkstair(n - 2);
}

/*
第一次将编号为1,2,3,...,共n盏灯都打开了；													只会被第一个同学操作
第二次将编号为2,4,6,....,共n/2盏灯都关闭了；												只会被第二个同学操作
第三次将编号为3,6,9,...,共n/3盏灯进行操作，若是之前关闭状态则打开，若是打开状态，则关闭；		只会被第三个同学操作
第四次将编号为4,8,12,....,共n/4盏灯进行操作。
这样操作了n次，问最后亮了几盏灯。
*/
int openlight(int n) 
{
	int ret = 0;
	for (int i = 1; i <= n; i++)   
	{
		if (n % i == 0)
			ret++;
	}
	return ret;
}


//计算A+B

string addint()
{
	string s1, s2;
	string ret = "";
	cin >> s1;
	cin >> s2;
	int len1 = s1.size();
	int len2 = s2.size();
	int num1, num2, carry=0, sumnum=0;
	for (int i = 0; i < (len1>len2?len1:len2); i++)
	{
		if (len1 <= i)
			num1 = 0;
		else
			num1 = static_cast<int> (s1[len1 - i - 1] - '0');

		if (len2 <= i)
			num2 = 0;
		else
			num2 = static_cast<int> (s2[len2 - i - 1] - '0');

		sumnum = (num1 + num2 + carry)%10;
		carry = (num1 + num2 + carry) / 10;

		ret.insert(0, to_string(sumnum));

	}

	if (carry == 1)
		ret.insert(0, to_string(carry));

	return ret;
}

int main()
{
	int num = 5;
	// maxcomdiv();

	// cout<<"There are "<<walkstair(num)<<" types of "<<num<<" stairs."<<endl;
	// cout << openlight(1) << ";"<<openlight(5)<<endl;
	cout << "A + B = " << addint() << endl;
	return 0;

}
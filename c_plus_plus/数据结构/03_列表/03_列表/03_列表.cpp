// 03_列表.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include "iostream"

using namespace std;


/*
范围查询
Input
	The first line contains two integers: n (size of S) and m (the number of queries).
	The second line enumerates all the n points in S.
	Each of the following m lines consists of two integers a and b and defines an query interval [a, b].
Output
	The number of points in S lying inside each of the m query intervals.

Input
	5 2
	1 3 7 9 11
	4 6
	7 12
Output
	0
	3

*/

int rangeQuery()
{
	int n,m;
	int a,b, count_ab;
	cin >> n >> m;
	int* array = new int[n];
	for(int i=0;i<n;i++)
		cin >>array[i];

	for(int i=0;i<m;i++)
	{
		cin >> a >> b;
		count_ab = 0;
		for(int j = 0;j<n;j++)
		{
			if(array[j]<a)
				continue;
			else if (a<=array[j] && array[j] <= b)
			{
				count_ab++;
				if(j==(n-1))
					cout << count_ab<<endl;
				continue;
			}
			else
			{
				cout << count_ab<<endl;
				break;
			}
		}
	}

	delete [] array;
	return 0;
}


int  gameZuma()
{

	return 0;
}


int _tmain(int argc, _TCHAR* argv[])
{
	rangeQuery();
	system("pause");
	return 0;
}


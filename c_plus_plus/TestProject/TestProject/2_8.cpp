#include "pch.h"
#include <iostream>
#include <iomanip>

using namespace std;

// ÂİĞıÕı·½ĞÎ
void setarray(int (*array)[31], int x, int y, int start, int n )
{
	if (n <= 0)
		return;
	else if (n == 1)
	{
		array[0][0] = 1;
		return;
	}

	for (int i = y; i < n+y-1; i++)	   //ÉÏ±ß
	{
		array[x][i] = start;
		start++;
	}
	for (int i = x; i < n+y-1; i++)    //ÓÒ±ß
	{
		array[i][n+y-1] = start;
		start++;
	}
	for (int i = n+x-1; i > x; i--)     //ÏÂ±ß
	{
		array[n+x-1][i] = start;
		start++;
	}
	for (int i = n+y-1; i>y; i--)       //×ó±ß
	{
		array[i][y] = start;
		start++;
	}
	setarray(array, x + 1, y + 1, start, n - 2);

}


int main()
{
	const int max_num = 31;
	int array[max_num][max_num] = { 0 };
	int num, i=0, j=0;
	int count = 1;
	cin >> num;

	setarray(array, 0, 0, 1, num);
	for (int i = 0; i < num; i++)
	{
		for (int j = 0; j < num; j++)
		{
			cout << setw(4) << array[i][j];
		}
		cout << endl;
	}
	return  0;
}
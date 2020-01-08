#include "pch.h"
#include <iostream>
#include <iomanip>


using namespace std;

// ×ÖÄ¸ÁâÐÎ
int main()
{
	char alph;
	int num;
	int flag;
	cin >> alph;
	cin >> num;
	for (int i = 1; i <= num; i++)
	{
		for (int j = 0; j<=num+i; j++)
		{
			flag = i - 1;
			if ((j == num - flag) || (j == num + flag))
				cout << alph;
			else
				cout << " ";
		}
		alph = alph + 1;
		if (alph > 'Z')
			alph = 'A';
		cout << endl;
	}
	if (alph == 'A')
	{
		alph = 'Y';
	}
	else
	{
		alph = alph - 2;
		if (alph < 'A')
			alph = 'Z';
	}


	for (int i = num-1; i >= 1; i--)
	{
		for (int j = 0; j <= num + i; j++)
		{
			flag = i - 1;
			if ((j == num - flag) || (j == num + flag))
				cout << alph;
			else
				cout << " ";
		}
		alph = alph - 1;
		if (alph < 'A')
			alph = 'Z';
		cout << endl;
	}

	return 0;
}

#include "pch.h"
#include <iostream> 
#include <string>
using namespace std;


int main()
{
	int num;
	cin >> num;
	int *p_array = new int[num];

	for(int i=0;i<num;i++)
	{
		cin >> p_array[i];
	}

	delete[] p_array;
	return 0;
}
#include "stdafx.h"
#include <iostream>

using namespace std;

#include "vector"
#include "algorithm"

void con1()
{
	// ����
	vector<int> v1;
	v1.push_back(1);
	v1.push_back(3);

	// ������
	for (vector<int>::iterator it = v1.begin();it != v1.end();it++ )
	{
		cout << *it << " ";
	}
	cout << endl;

	// �㷨
	int num = count(v1.begin(),v1.end(),3);

	cout << num << endl;
}

int main1()
{
	con1();

	system("pause");
	return 0;
}

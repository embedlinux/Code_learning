#include "stdafx.h"
#include "map"
#include <iostream>
#include <string>
#include <vector>
#include <set>

using namespace std;


/*
	��дһ�����򣬴Ӽ�������һ�������ʣ�ÿ���յ�һ�����ʺ�����õ����������ֹ��Ĵ��������յ���QUIT�����ʺ����ֱ���˳���
*/
int test_map()
{
	map<string, int> mapString;
	string cinStr;
	cin >> cinStr;
	while (cinStr != "QUIT")
	{
		pair<map<string, int>::iterator, bool > pairResult = mapString.insert(pair<string, int>(cinStr, 0));
		if (pairResult.second == false)
		{
			mapString[cinStr] += 1;
			

		}
		cout << mapString[cinStr] << endl;
		cin >> cinStr;
	}

	//for(map<string, int>::iterator it = mapString.begin();it != mapString.end();it++)
	//{
	//	cout << it->second << endl;
	//}

	return 0;
}

/*
	����n����������n����ȥ��֮�����򣬲������С����������
*/

int unique_sort()
{
	set<int> s;
	int num;
	int temp;
	cin >> num;
	for(int i = 0; i < num; i++)
	{
		cin >> temp;
		s.insert(temp);
	}

	for(set<int>::iterator it = s.begin();it != s.end();it++)
	{
		cout << *it << endl;
	}
	return 0;
}
/*
	����һ����a�ʹ�b����b��a�г��ִ���   ��������ʾ����ʹ��stl::count������
*/
int string_num()
{
	string str_a;
	string str_b;
	vector<string> strVec;
	cin >> str_a;
	cin >> str_b;

	for (unsigned int i = 0; i < str_a.length()-str_b.length()+1; i++) {
		strVec.push_back(str_a.substr(i, str_b.length()));
	}

	int num = count(strVec.begin(),strVec.end(),str_b);

	cout << num << endl;
	return 0;

}


int main()
{
	// test_map();
	// unique_sort();
	string_num();
	system("pause");
	return 0;
}
// CPP_6.cpp : �������̨Ӧ�ó������ڵ㡣
//

#include "stdafx.h"
#include <iostream>
#include <vector>
#include <string>

using namespace std;

//����������
void maxSubArry()
{
	int num, max_sum,res;
	cin >> num;
	int* n_array = new int[num];

	for(int i = 0;i<num;i++)
	{
		cin >> *(n_array+i);
	}

	max_sum = n_array[1];
	res = n_array[1];
	for (int i = 2; i< num;i++)
	{
		if (max_sum > 0)
			max_sum += n_array[i];
		else
		{
			max_sum = n_array[i];
		}
		if (max_sum > res)
			res = max_sum;
	}

	cout << res << " ";


	delete[] n_array;

}

// �ַ����Ļ��������и���
/*
���ͷβ�ַ�����ȣ����ַ����Ļ��������и����͵���
	ȥ��ͷ���ַ����Ļ��������и���+ȥ��β���ַ����Ļ��������и���-ȥ��ͷβ���ַ����Ļ��������и�����
���ͷβ�ַ���ȣ�
	��ô���������������и���֮�⣬��Ҫ������β���ʱ�����������и�����1+ȥ��ͷβ���ַ����Ļ��������и�����1ָ���Ǽ���ͷβ��ɵĻ���������
*/
void maxCyclSubString()
{
	int len;
	string str;
	cin >> str;
	len = str.length();
	vector<vector<int>> dp(len, vector<int>(len));
	for(int j=0;j<len;j++)
	{
		dp[j][j] = 1;
		for(int i=j-1;i>=0;i--)
		{
			dp[i][j] = dp[i+1][j]+dp[i][j-1]-dp[i+1][j-1];
			if(str[i]==str[j])
				dp[i][j] += 1 + dp[i+1][j-1];
		}
	}
	cout << dp[0][len-1]<<endl;
}


// �����KС��
void kthNumArray()
{

}

int _tmain(int argc, _TCHAR* argv[])
{
	maxCyclSubString();
	return 0;
}


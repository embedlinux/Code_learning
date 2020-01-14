// CPP_6.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include <iostream>
#include <vector>
#include <string>

using namespace std;

//最大子数组和
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

// 字符串的回文子序列个数
/*
如果头尾字符不相等，则字符串的回文子序列个数就等于
	去掉头的字符串的回文子序列个数+去掉尾的字符串的回文子序列个数-去掉头尾的字符串的回文子序列个数；
如果头尾字符相等，
	那么除了上述的子序列个数之外，还要加上首尾相等时新增的子序列个数，1+去掉头尾的字符串的回文子序列个数，1指的是加上头尾组成的回文子序列
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


// 数组第K小数
void kthNumArray()
{

}

int _tmain(int argc, _TCHAR* argv[])
{
	maxCyclSubString();
	return 0;
}


// 01_绪论.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include <string>
#include <iostream>

using namespace std;

string lcs_string(string stra, string strb)
{
	int lena = stra.length()-1;
	int lenb = strb.length()-1;

	string stra_sub = stra;
	string strb_sub = strb;

	if (lena == -1 || lenb == -1)
		return "";
	if (stra[lena] == strb[lenb])
	{
		char temp = stra[lena];
		stra_sub.pop_back();
		strb_sub.pop_back();
		return temp + lcs_string(stra_sub, strb_sub);
		//return lcs_string(stra_sub, strb_sub) + temp;
	}
	else
	{
		stra_sub.pop_back();
		strb_sub.pop_back();

		return max(lcs_string(stra_sub, strb), lcs_string(stra, strb_sub));
		// return lcs_string(stra_sub, strb) > lcs_string(stra, strb_sub)?lcs_string(stra_sub, strb):lcs_string(stra, strb_sub);

	}
}

int lcs()
{
	string stra, strb;
	int num = 0;
	// cin >> stra;
	// cin >> strb;
	 stra = "educational";
	 strb = "advantage";
	//stra = "program";
	//strb = "algorithm";
	cout<<"最长公共子串:"<<lcs_string(stra, strb)<<endl;
	return 0;
}


int _tmain(int argc, _TCHAR* argv[])
{
	lcs();

	system("pause");
	return 0;
}


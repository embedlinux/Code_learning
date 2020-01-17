#ifndef _ACCOUNT_CLASS
#define _ACCOUNT_CLASS

/*
定义一个基类Account，
	数据成员包含
		string类变量
		userName用于保存账户主人姓名，
	函数成员包括
		默认构造函数、
		带参构造函数用于初始化数据成员和输出姓名的成员函PrintName()。
从Account类派生出CreditAccount类，
	增加整型数据成员credit用于记录该用户信用额度，
	函数成员包括带参构造函数用于初始化数据成员和输出账户信息的成员函数PrintInfo()。
	要求：在函数PrintInfo()中需要调用基类的成员函数PrintName()。

*/

#include <iostream>
#include <string>
using namespace std;

class Account
{
	string userName;
	public:
		Account() {};
		Account(string name);
		void  PrintUserName();
};



class CreditAccount : public Account
{
	public:
		CreditAccount(string name, int credit);
		void PrintInfo();
	private:
		int credit;
};



#endif // !_ACCOUNT_CLASS


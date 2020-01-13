#include "pch.h"
#include <iostream> 
#include <string>
using namespace std;

/*
请实现一个“鱼额宝”类，下面已给出代码模板，请根据main函数中对该类的操作，补充类实现部分完成代码。

“鱼额宝”类可以记录账户余额、存钱、取钱、计算利息。
该类中有一个私有静态成员变量profitRate存储“鱼额宝”的利率，
可以用共有静态成员函数setProfitRate修改利率的值。程序输入为第1天至第n天连续n天的账户操作，每天只能进行一次账户操作，或存或取，
每一天产生的利息是前一天的账户余额与“鱼额宝”利率的乘积，产生的利息当天也将存入账户余额，由于第1天之前账户不存在，所以第1天一定是新建账户并存钱，且当天不会有利息存入余额。
程序在接受n天操作的输入后，要求计算出第n天操作完成后的账户余额并输出。

*/
class Yuebao
{
	private:
		double allmoney;
		static double profitRate;
	public:
		Yuebao(double money);
		static void setProfitRate(double rate);
		void addProfit();
		void deposit(double amount);
		void withdraw(double amount);
		double getBalance();

/* Your code here! */
};


double Yuebao::profitRate = 0;

void Yuebao::setProfitRate(double rate)
{
	profitRate = rate;
}

Yuebao::Yuebao(double money):allmoney(money)
{
}

void Yuebao::addProfit()
{
	allmoney += allmoney * profitRate;
}

void Yuebao::deposit(double amount)
{
	allmoney += amount;
}

void Yuebao::withdraw(double amount)
{
	allmoney -= amount;
}

double Yuebao::getBalance()
{
	return allmoney;
}
  
int main()
{
    int n;
    while(cin >> n)
    {
        double profitRate;
        cin >> profitRate;
        Yuebao::setProfitRate(profitRate);	//设定鱼额宝的利率
        Yuebao y(0);						//新建鱼额宝账户，余额初始化为0
        int operation;						//接受输入判断是存还是取
        double amount;						//接受输入存取金额
        for (int i = 0; i < n; ++i)
        {
            y.addProfit();					//加入前一天余额产生的利息
            cin >> operation >> amount;
            if (operation == 0)
                y.deposit(amount);			//存入金额
            else
                y.withdraw(amount);			//取出金额
        }
        cout << y.getBalance() << endl;//输出最终账户余额
    }
    return 0;
}

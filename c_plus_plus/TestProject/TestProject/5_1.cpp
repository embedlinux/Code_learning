#include "pch.h"
#include <iostream> 
#include <string>
using namespace std;

/*
��ʵ��һ���������࣬�����Ѹ�������ģ�壬�����main�����жԸ���Ĳ�����������ʵ�ֲ�����ɴ��롣

����������Լ�¼�˻�����Ǯ��ȡǮ��������Ϣ��
��������һ��˽�о�̬��Ա����profitRate�洢�����������ʣ�
�����ù��о�̬��Ա����setProfitRate�޸����ʵ�ֵ����������Ϊ��1������n������n����˻�������ÿ��ֻ�ܽ���һ���˻�����������ȡ��
ÿһ���������Ϣ��ǰһ����˻�����롰�������ʵĳ˻�����������Ϣ����Ҳ�������˻������ڵ�1��֮ǰ�˻������ڣ����Ե�1��һ�����½��˻�����Ǯ���ҵ��첻������Ϣ������
�����ڽ���n������������Ҫ��������n�������ɺ���˻��������

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
        Yuebao::setProfitRate(profitRate);	//�趨��������
        Yuebao y(0);						//�½����˻�������ʼ��Ϊ0
        int operation;						//���������ж��Ǵ滹��ȡ
        double amount;						//���������ȡ���
        for (int i = 0; i < n; ++i)
        {
            y.addProfit();					//����ǰһ������������Ϣ
            cin >> operation >> amount;
            if (operation == 0)
                y.deposit(amount);			//������
            else
                y.withdraw(amount);			//ȡ�����
        }
        cout << y.getBalance() << endl;//��������˻����
    }
    return 0;
}

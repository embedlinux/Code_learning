#ifndef _ACCOUNT_CLASS
#define _ACCOUNT_CLASS

/*
����һ������Account��
	���ݳ�Ա����
		string�����
		userName���ڱ����˻�����������
	������Ա����
		Ĭ�Ϲ��캯����
		���ι��캯�����ڳ�ʼ�����ݳ�Ա����������ĳ�Ա��PrintName()��
��Account��������CreditAccount�࣬
	�����������ݳ�Աcredit���ڼ�¼���û����ö�ȣ�
	������Ա�������ι��캯�����ڳ�ʼ�����ݳ�Ա������˻���Ϣ�ĳ�Ա����PrintInfo()��
	Ҫ���ں���PrintInfo()����Ҫ���û���ĳ�Ա����PrintName()��

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


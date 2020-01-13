// MailList.cpp : �������̨Ӧ�ó������ڵ㡣
//

#include "stdafx.h"
#include <iostream>
#include "contacts.h"
#include <iomanip>


using namespace std;

// �˵�����
void ShowMenu()
{
	cout << "**************************"<<endl;
	cout << "*****  1.�����ϵ��  *****"<<endl;
	cout << "*****  2.��ʾ��ϵ��  *****"<<endl;
	cout << "*****  3.ɾ����ϵ��  *****"<<endl;
	cout << "*****  4.������ϵ��  *****"<<endl;
	cout << "*****  5.�޸���ϵ��  *****"<<endl;
	cout << "*****  6.�����ϵ��  *****"<<endl;
	cout << "*****  0.�˳�ͨѶ¼  *****"<<endl;
	cout << "**************************"<<endl;
}

void ExitList()
{
	cout<<"��ӭ�´�ʹ��"<<endl;
	system("pause");
}

//�����ϵ��
void AddPerson(Addressbooks &abs)
{
	if (abs.m_size == MAX_NUM)
	{
		cout<<"ͨѶ¼����,�޷����"<<endl;
	}
	else
	{
		string name;
		cout<<"����������"<<endl;
		cin>>name;
		abs.personArray[abs.m_size].m_Name = name;

		int sex=0;
		cout<<"�������Ա�"<<endl;
		cout<<"1---��"<<endl;
		cout<<"2---Ů"<<endl;
		while (true)
		{
			cin>>sex;
			if (sex == 1 || sex == 2)
			{
				abs.personArray[abs.m_size].m_Sex = sex;
				break;
			}
			cout<<"��������,����������"<<endl;
		}

		int age;
		cout<<"����������"<<endl;
		cin>>age;
		abs.personArray[abs.m_size].m_Age = age;

		string phone;
		cout<<"������绰"<<endl;
		cin>>phone;
		abs.personArray[abs.m_size].m_Phone = phone;

		string addr;
		cout<<"�������ͥסַ"<<endl;
		cin>>addr;
		abs.personArray[abs.m_size].m_Addr = addr;

		abs.m_size++;
		cout<<"��ӳɹ�"<<endl;

		system("pause");
		system("cls");
	}
}

//��ʾ��ϵ��
void ShowPerson(Addressbooks &abs)
{
	int i,size;
	size = abs.m_size;

	if (size == 0)
	{
		cout<<"��ǰ��¼Ϊ��"<<endl;
	}
	else
	{
		cout<<"��ǰͨѶ¼��������ϵ��:"<<endl;
		for(i=0;i<size;i++)
		{
			cout<<i<<". "
				<<setw(4)<<abs.personArray[i].m_Name
				<<setw(4)<<abs.personArray[i].m_Sex
				<<setw(4)<<abs.personArray[i].m_Age
				<<setw(12)<<abs.personArray[i].m_Phone
				<<" "<<abs.personArray[i].m_Addr
				<<endl;
		}
	}
	system("pause");
	system("cls");
}

// �����ϵ���Ƿ����
int isExits(Addressbooks abs, string name)
{
	int ret =-1;
	for (int i=0; i<abs.m_size;i++)
	{
		if (abs.personArray[i].m_Name == name)
			return i;
	}
	return ret;
}

// ɾ��ָ����ϵ��
void deletePerson(Addressbooks &abs)
{
	string name;
	int delnum;
	cout << "������Ҫɾ����ϵ�˵�����:";
	cin>>name;
	delnum = isExits(abs, name);
	if (delnum == -1)
	{
		cout<<"��Ҫɾ������ϵ�˲�����"<<endl;
	}
	else
	{
		if (delnum == (abs.m_size - 1))
			abs.m_size--;
		else
		{
			abs.personArray[delnum] = abs.personArray[abs.m_size-1];
			abs.m_size--;
		}
		cout<<"ɾ���ɹ�"<<endl;
	
	}
	system("pause");
	system("cls");
}

//������ϵ��
void findPerson(Addressbooks abs)
{
	string name;
	int findnum;
	cout << "������Ҫ������ϵ�˵�����:";
	cin>>name;
	findnum = isExits(abs, name);
	if (findnum == -1)
	{
		cout<<"��Ҫ���ҵ���ϵ�˲�����"<<endl;
	}
	else
	{
		cout<<findnum<<". "
		<<setw(4)<<abs.personArray[findnum].m_Name
		<<setw(4)<<abs.personArray[findnum].m_Sex
		<<setw(4)<<abs.personArray[findnum].m_Age
		<<setw(12)<<abs.personArray[findnum].m_Phone
		<<" "<<abs.personArray[findnum].m_Addr
		<<endl;
	}
	system("pause");
	system("cls");
}

//�޸���ϵ��
void changePerson(Addressbooks &abs)
{
	string name;
	int changenum;
	cout << "������Ҫ�޸���ϵ�˵�����:";
	cin>>name;
	changenum = isExits(abs, name);
	if (changenum == -1)
	{
		cout<<"����ϵ�˲�����"<<endl;
	}
	else
	{
		cout<<"����������"<<endl;
		cin>>name;
		abs.personArray[changenum].m_Name = name;

		int sex=0;
		cout<<"�������Ա�"<<endl;
		cout<<"1---��"<<endl;
		cout<<"2---Ů"<<endl;
		while (true)
		{
			cin>>sex;
			if (sex == 1 || sex == 2)
			{
				abs.personArray[changenum].m_Sex = sex;
				break;
			}
			cout<<"��������,����������"<<endl;
		}

		int age;
		cout<<"����������"<<endl;
		cin>>age;
		abs.personArray[changenum].m_Age = age;

		string phone;
		cout<<"������绰"<<endl;
		cin>>phone;
		abs.personArray[changenum].m_Phone = phone;

		string addr;
		cout<<"�������ͥסַ"<<endl;
		cin>>addr;
		abs.personArray[changenum].m_Addr = addr;

		cout<<"�޸ĳɹ�"<<endl;
	}
	system("pause");
	system("cls");

}

void clearPerson(Addressbooks &abs)
{
	abs.m_size = 0;
	cout<<"���ͨѶ¼�ɹ�"<<endl;
	system("pause");
	system("cls");
}


// ͨѶ¼����ϵͳ
int _tmain(int argc, _TCHAR* argv[])
{
	int select = 0;
	Addressbooks abs;
	abs.m_size = 0;
	while (true)
	{
		ShowMenu();
		cin >> select;
		switch (select)
		{
			case 1:			//1.�����ϵ��
				AddPerson(abs);
				break;
			case 2:			//2.��ʾ��ϵ��
				ShowPerson(abs);
				break;
			case 3:			//3.ɾ����ϵ��
				deletePerson(abs);
				break;
			case 4:			//4.������ϵ��
				findPerson(abs);
				break;
			case 5:			//5.�޸���ϵ��
				changePerson(abs);
				break;
			case 6:			//6.�����ϵ��
				clearPerson(abs);
				break;
			case 0:			//0.�˳�ͨѶ¼
				ExitList();
				return 0;
			default:
				break;
		}
	
	}
	system("pause");
	return 0;
}


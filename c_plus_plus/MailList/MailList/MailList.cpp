// MailList.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include <iostream>
#include "contacts.h"
#include <iomanip>


using namespace std;

// 菜单界面
void ShowMenu()
{
	cout << "**************************"<<endl;
	cout << "*****  1.添加联系人  *****"<<endl;
	cout << "*****  2.显示联系人  *****"<<endl;
	cout << "*****  3.删除联系人  *****"<<endl;
	cout << "*****  4.查找联系人  *****"<<endl;
	cout << "*****  5.修改联系人  *****"<<endl;
	cout << "*****  6.清空联系人  *****"<<endl;
	cout << "*****  0.退出通讯录  *****"<<endl;
	cout << "**************************"<<endl;
}

void ExitList()
{
	cout<<"欢迎下次使用"<<endl;
	system("pause");
}

//添加联系人
void AddPerson(Addressbooks &abs)
{
	if (abs.m_size == MAX_NUM)
	{
		cout<<"通讯录已满,无法添加"<<endl;
	}
	else
	{
		string name;
		cout<<"请输入姓名"<<endl;
		cin>>name;
		abs.personArray[abs.m_size].m_Name = name;

		int sex=0;
		cout<<"请输入性别"<<endl;
		cout<<"1---男"<<endl;
		cout<<"2---女"<<endl;
		while (true)
		{
			cin>>sex;
			if (sex == 1 || sex == 2)
			{
				abs.personArray[abs.m_size].m_Sex = sex;
				break;
			}
			cout<<"输入有误,请重新输入"<<endl;
		}

		int age;
		cout<<"请输入年龄"<<endl;
		cin>>age;
		abs.personArray[abs.m_size].m_Age = age;

		string phone;
		cout<<"请输入电话"<<endl;
		cin>>phone;
		abs.personArray[abs.m_size].m_Phone = phone;

		string addr;
		cout<<"请输入家庭住址"<<endl;
		cin>>addr;
		abs.personArray[abs.m_size].m_Addr = addr;

		abs.m_size++;
		cout<<"添加成功"<<endl;

		system("pause");
		system("cls");
	}
}

//显示联系人
void ShowPerson(Addressbooks &abs)
{
	int i,size;
	size = abs.m_size;

	if (size == 0)
	{
		cout<<"当前记录为空"<<endl;
	}
	else
	{
		cout<<"当前通讯录中所有联系人:"<<endl;
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

// 检测联系人是否存在
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

// 删除指定联系人
void deletePerson(Addressbooks &abs)
{
	string name;
	int delnum;
	cout << "请输入要删除联系人的姓名:";
	cin>>name;
	delnum = isExits(abs, name);
	if (delnum == -1)
	{
		cout<<"需要删除的联系人不存在"<<endl;
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
		cout<<"删除成功"<<endl;
	
	}
	system("pause");
	system("cls");
}

//查找联系人
void findPerson(Addressbooks abs)
{
	string name;
	int findnum;
	cout << "请输入要查找联系人的姓名:";
	cin>>name;
	findnum = isExits(abs, name);
	if (findnum == -1)
	{
		cout<<"需要查找的联系人不存在"<<endl;
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

//修改联系人
void changePerson(Addressbooks &abs)
{
	string name;
	int changenum;
	cout << "请输入要修改联系人的姓名:";
	cin>>name;
	changenum = isExits(abs, name);
	if (changenum == -1)
	{
		cout<<"该联系人不存在"<<endl;
	}
	else
	{
		cout<<"请输入姓名"<<endl;
		cin>>name;
		abs.personArray[changenum].m_Name = name;

		int sex=0;
		cout<<"请输入性别"<<endl;
		cout<<"1---男"<<endl;
		cout<<"2---女"<<endl;
		while (true)
		{
			cin>>sex;
			if (sex == 1 || sex == 2)
			{
				abs.personArray[changenum].m_Sex = sex;
				break;
			}
			cout<<"输入有误,请重新输入"<<endl;
		}

		int age;
		cout<<"请输入年龄"<<endl;
		cin>>age;
		abs.personArray[changenum].m_Age = age;

		string phone;
		cout<<"请输入电话"<<endl;
		cin>>phone;
		abs.personArray[changenum].m_Phone = phone;

		string addr;
		cout<<"请输入家庭住址"<<endl;
		cin>>addr;
		abs.personArray[changenum].m_Addr = addr;

		cout<<"修改成功"<<endl;
	}
	system("pause");
	system("cls");

}

void clearPerson(Addressbooks &abs)
{
	abs.m_size = 0;
	cout<<"清空通讯录成功"<<endl;
	system("pause");
	system("cls");
}


// 通讯录管理系统
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
			case 1:			//1.添加联系人
				AddPerson(abs);
				break;
			case 2:			//2.显示联系人
				ShowPerson(abs);
				break;
			case 3:			//3.删除联系人
				deletePerson(abs);
				break;
			case 4:			//4.查找联系人
				findPerson(abs);
				break;
			case 5:			//5.修改联系人
				changePerson(abs);
				break;
			case 6:			//6.清空联系人
				clearPerson(abs);
				break;
			case 0:			//0.退出通讯录
				ExitList();
				return 0;
			default:
				break;
		}
	
	}
	system("pause");
	return 0;
}


#include "stdafx.h"
#include <iostream>


using namespace std;




// ����һ����ʾʱ��Ľṹ�壬�б�ʾ�ꡢ�¡��ա�Сʱ���֡���ĳ�Ա������ʹ��short���ͣ�����������ʵ�����������


int main()
{
	struct MyTimeStruct
	{
		unsigned int year;
		unsigned int month;
		unsigned int day;

		unsigned int hour;
		unsigned int min;
		unsigned int sec;
	};
	MyTimeStruct mytime ={2019, 1, 7, 20, 44, 0};

	cout<<"please input year:"<<endl;
	cin>>mytime.year;

	cout<<"please input month:"<<endl;
	cin>>mytime.month;

	cout<<"please input day:"<<endl;
	cin>>mytime.day;

	cout<<"please input hour:"<<endl;
	cin>>mytime.hour;

	cout<<"please input min:"<<endl;
	cin>>mytime.min;

	cout<<"please input sec:"<<endl;
	cin>>mytime.sec;

	cout<<"The time is set to: "<<mytime.year<<'/'
								<<mytime.month<<'/'
								<<mytime.day<<' '
								<<mytime.hour<<':'
								<<mytime.min<<":"
								<<mytime.sec<<endl;
	 
	return 0;
}
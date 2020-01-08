#include "stdafx.h"
#include <iostream>


using namespace std;




// 声明一个表示时间的结构体，有表示年、月、日、小时、分、秒的成员，可以使用short类型；在主程序中实现输入输出。


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
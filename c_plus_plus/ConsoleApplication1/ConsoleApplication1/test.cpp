#include "stdafx.h"
#include <iostream>


using namespace std;


// 读入并显示整数
void EnterRadius()
{
	int radius;
	cout<<"Please enter the radius:"<<endl;

	cin>>radius;
	cout<<"The radius is:"<<radius<<endl;

	cout<<"PI is: "<<3.14<<endl;

	cout<<"Please enter a different radius."<<endl;
	cin>>radius;
	cout<<"Now the radius is: "<<radius<<endl;
}

// 为常量命名
void NameForConst()
{
	const double pi(3.1415926);
	int radius;

	cout<<"Please enter the radius!\n";
    cin>>radius;   
    cout<<"The radius is:"<<radius<<'\n';     
    cout<<"PI is:"<<pi<<'\n';            

    cout<<"Please enter a different radius!\n";
    cin>>radius;   
	cout<<"Please enter a different pi!\n";
    //cin>>pi;   
    cout<<"Now the radius is changed to:"<<radius<<'\n';
	cout<<"PI is still:"<<pi<<endl;

}

// 变量的初始化
void InitVar()
{
	const double pi(3.14159);           
    int radius(0);  

    cout<<"The initial radius is:"<<radius<<'\n';         
    cout<<"PI is:"<<pi<<'\n';

    cout<<"Please enter a different radius!\n";
    cin>>radius;   

    cout<<"Now the radius is changed to:"<<radius<<'\n';
    cout<<"PI is still:"<<pi<<'\n';     

}


int main()
{
	EnterRadius();
	return 0;
}
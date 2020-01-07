#include "stdafx.h"
#include <iostream>


using namespace std;

// 任意给定 n 个整数，求这 n 个整数序列的和、最小值、最大值
int max_num()
{
	int num;
	int sum_n=0,max_n ,min_n;
	int input_num;
	cin>>num;
	for(int i=0; i < num;i++)
	{
		cin>>input_num;
		sum_n += input_num;
		if (0==i)
		{
			max_n = input_num;
			min_n = input_num;
			continue;
		}
		if (max_n <=input_num)
			max_n = input_num;
		if (input_num <= min_n)
			min_n = input_num;
		
	}
	cout<<sum_n<<' '<<min_n<<' '<<max_n<<endl;
	return 0;
}

//已知一个只包含 0 和 1 的二进制数，长度不大于 10 ，将其转换为十进制并输出。
int convertodec()
{
	unsigned int num = 0;
	int numdec = 0;
	int times = 1;
	int mod = 0;
	cin>>num;
	do
	{
		mod = num % 10;
		numdec += mod * times;
		times *= 2;
		num /= 10;
	}while(num);

	cout<<numdec;
	return 0;

}

//打印 n 阶实心菱形
//输出菱形的上半边即等腰三角形；再输出菱形的下半边，下半边等于除了中间行的上半边倒叙。
int printdiamond()
{
	int num;
	int i,j;
	cin>>num;
	for (i=1;i<=num;i++)
	{
		for(j=0;j<num-i;j++)
			cout<<" ";
		for(j=0;j<2*i-1;j++)
			cout<<"*";
		cout<<endl;
	}
	for(i=num-1;i>0;i--){
		for(j=0;j<num-i;j++){
			cout<<" ";
		}
		for(j=0;j<2*i-1;j++){
			cout<<"*";
		}
		cout<<endl;
    }
	return 0;
}

int main()
{
	// max_num();
	// convertodec();
	printdiamond();
	return 0;
}
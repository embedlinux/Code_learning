#include "stdafx.h"
#include <iostream>


using namespace std;

// ������� n ������������ n ���������еĺ͡���Сֵ�����ֵ
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

//��֪һ��ֻ���� 0 �� 1 �Ķ������������Ȳ����� 10 ������ת��Ϊʮ���Ʋ������
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

//��ӡ n ��ʵ������
//������ε��ϰ�߼����������Σ���������ε��°�ߣ��°�ߵ��ڳ����м��е��ϰ�ߵ���
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
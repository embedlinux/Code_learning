#include "stdafx.h"
#include <iostream>


using namespace std;
//��ĳ�����������Ľ�������ֿ��ܣ�ʤ��WIN��������LOSE����ƽ�֣�TIE��������ȡ����CANCEL������д����˳����������������

int main()
{
	enum GameResult
	{
		WIN,LOSE,TIE,CANCEL,
	};
	GameResult result;
	enum GameResult omit = CANCEL;
	for(int count=WIN;count<=CANCEL;count++)
	{
		result = GameResult(count);
		if (result == omit)
		{
			cout<<"The Game was cancelled"<<endl;
		}
		else
		{
			cout<<"The Game is played ";
			if (result==WIN)
				cout<<"and we won!";
			if (result==LOSE)
				cout<<"and we lost!";
			if (result==TIE)
				cout<<"and result is tie.";
			cout<<endl;
		}
	}
	return 0;
}
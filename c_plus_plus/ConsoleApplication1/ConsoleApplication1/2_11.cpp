#include "stdafx.h"
#include <iostream>


using namespace std;
//设某次体育比赛的结果有四种可能：胜（WIN）、负（LOSE）、平局（TIE）、比赛取消（CANCEL），编写程序顺序输出这四种情况。

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
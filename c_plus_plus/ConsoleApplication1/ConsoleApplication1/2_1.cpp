#include "stdafx.h"
#include <iostream>

using namespace std;


// switch Óï¾äµÄÊ¹ÓÃ
// int _tmain(int argc, _TCHAR* argv[])
int main()
{
	int num;
	cout << "Please enter a num(0-6):";
	cin >> num;
	
	switch (num)
	{
	case 0:
		cout << "Sunday" << endl;
		break;
	case 1: cout << "Monday" << endl; 
		break;
	case 2: cout << "Tuesday" << endl; 
		break;
	case 3: cout << "Wednesday" << endl; 
		break;
	case 4: cout << "Thursday" << endl; 
		break;
	case 5: cout << "Friday" << endl; 
		break;
	case 6: cout << "Saturday" << endl; 
		break;
	default:
		cout << "Day out of range Sunday .. Saturday" << endl;   
		break;
	}

	return 0;
}
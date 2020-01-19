// CPP_7.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include "pch.h"
#include <iostream>
//#include "AccountClass.h"
//#include "MultiInheri.h"
#include "AddTwoNum.h"

int main()
{
	//CreditAccount a("I Love CPP", 10000);
	//a.PrintInfo();
	//system("pasue");

	//int x[4];
	//for (int i = 0; i < 4; ++i)
	//	cin >> x[i];
	//Derived d(x[0], x[1], x[2], x[3]);

	int x, y;
	cin >> x >> y;
	Base11 a(x);
	Base12 b(y);
	Derived d(a, b);
	cout << d.Base11::x << "+" << d.Base12::x << "=" << d.x << endl;
	
	return 0;
}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file

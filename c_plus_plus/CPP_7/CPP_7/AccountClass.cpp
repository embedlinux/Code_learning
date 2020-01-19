#include "pch.h"
#include "AccountClass.h"

Account::Account(string name):userName(name)
{
}

void Account::PrintUserName()
{
	cout << userName << endl;
}



CreditAccount::CreditAccount(string name, int credit):Account(name), credit(credit)
{
}

void CreditAccount::PrintInfo()
{
	PrintUserName();
	cout << credit <<endl;
}
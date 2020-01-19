#include "pch.h"
#include "MultiInheri.h"


Base1::Base1(int x)
{
	cout << "Base1 constructor called " << x << endl;
}
Base1::~Base1()
{
	cout << "Base1 destructor called" << endl;
}


Base2::Base2(int x)
{
	cout << "Base2 constructor called " << x << endl;
}
Base2::~Base2()
{
	cout << "Base2 destructor called" << endl;
}

Base3::Base3(int x)
{
	cout << "Base3 constructor called " << x << endl;
}
Base3::~Base3()
{
	cout << "Base3 destructor called" << endl;
}

Derived::Derived(int x1, int x2, int x3, int x4):Base1(x2),Base2(x3), Base3(x4)
{
	cout << "Derived constructor called " << x1 << endl;
}
Derived::~Derived()
{
	cout << "Derived destructor called" << endl;
}



#include "pch.h"
#include "AddTwoNum.h"

Base11::Base11(int x) :x(x)
{
}

Base12::Base12(int x) : x(x)
{
}

Derived::Derived(Base11& a, Base12& b) :Base11(a.x), Base12(b.x),x(a.x+b.x)
{
}
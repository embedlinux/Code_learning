#include "pch.h"
#include <iostream> 
#include <string>
using namespace std;

/*
该类有个公有静态变量num记录该类的所有对象数，主函数将会在不同语句之后输出对象数，只有正确地实现该类，
保证num正确记录该类的对象数，才能输出正确的结果。
*/

class Mouse{
/* Your code here! */
	public:
		static int num;
		Mouse();
		Mouse(const Mouse &b);
		~Mouse();
	private:
		;
};

int Mouse::num=0;

Mouse::Mouse()
{
	num++;
}

Mouse::~Mouse()
{
	num--;
}

Mouse::Mouse(const Mouse &b)
{
	num++;
}
  
void fn(Mouse m);
  
int main()
{
    Mouse::num = 0;
    Mouse a;
    cout << Mouse::num << endl;
    Mouse b(a);
    cout << Mouse::num << endl;
    for (int i = 0; i < 10; ++i)
    {
        Mouse x;
        cout << Mouse::num << endl;
    }
    fn(a);
    cout << Mouse::num << endl;
    return 0;
}
  
void fn(Mouse m)
{
    cout << Mouse::num << endl;
    Mouse n(m);
    cout << Mouse::num << endl;
}  
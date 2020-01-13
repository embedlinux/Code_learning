#include "pch.h"
#include <iostream> 
#include <string>
using namespace std;

/*
�����и����о�̬����num��¼��������ж������������������ڲ�ͬ���֮�������������ֻ����ȷ��ʵ�ָ��࣬
��֤num��ȷ��¼����Ķ����������������ȷ�Ľ����
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
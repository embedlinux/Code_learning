#include "pch.h"
#include <iostream>
#include <cmath>
#include <complex>
#include <iomanip>

using namespace std;

// 最大公约数
class Integer {
	private:
		int _num;
	public:
		//构造函数
		Integer(int num) {
			_num = num;
		}
		//计算当前Integer 和 b之间的最大公约数
		int gcd(Integer b) {
			int anum, bnum, temp;
			anum = this->_num;
			bnum = b.getnum();

			if (anum < bnum)
			{
				temp = anum;
				anum = bnum;
				bnum = temp;
			}

			while (anum % bnum != 0)
			{
				temp = anum % bnum;
				anum = bnum;
				bnum = temp;
			}
			return bnum;
		}
		// 获取当前值
		int getnum() {
			return this->_num;
		}
		//反转_num
		int inversed() {
			int temp = this->getnum();
			int ret = 0;
			while (temp != 0)
			{
				ret = ret * 10 + temp % 10;
				temp /= 10;
			}
			return ret;
		}
};

/*
若该方程有两个不相等实根，首先输出1，换行，然后从小到大输出两个实根，换行；
若该方程有两个相等实根，首先输出2，换行，然后输出这个这个实根，换行；
若该方程有一对共轭复根，输出3，换行；
若该方程有无解，输出4，换行；
若该方程有无穷个解，输出5，换行；
若该方程只有一个根，首先输出6，换行，然后输出这个跟
*/

class Equation {
	private:
		int _a, _b, _c;
	public:
		Equation(int a, int b, int c) {
			_a = a;
			_b = b;
			_c = c;
		}
		void solve() {
			int flag = 0;
			float dlt;
			float ret1, ret2;
			complex<float> c1, c2;
			float a, b, c;
			a = static_cast<float> (this->_a);
			b = static_cast<float> (this->_b);
			c = static_cast<float> (this->_c);
			if (abs(a) < 1e-10)				// a 等于0
			{
				if (abs(b) < 1e-10)			// b 等于0
				{
					if (abs(c) < 1e-10)		// c 等于0
					{
						;					// 同时为零， 没有意义
					}
					else
						flag = 4;			// 无解
				}
				else                        // b 不等于0
				{
					flag = 6;
					ret1 = c / b;
				}
			}
			else
			{
				dlt = b * b - 4 * a *c;
				if (dlt > 1e-10)			//大于0, 两个不相等实根
				{
					flag = 1;
					ret1 = -b + sqrt(dlt) / (2 * a);
					ret2 = -b - sqrt(dlt) / (2 * a);
				}
				else if (dlt < (-1e-10))    //小于0,一对共轭复数
				{
					flag = 3;
					c1 = complex<float>(-b, dlt/(2*a));
					c2 = complex<float>(-b, -dlt / (2 * a));
				}
				else                        //等于0, 两个相等实根
				{
					flag = 2;
					float ret;
					ret = -b;
				}
			}
			switch (flag)
			{
				case 0:
					cout << "a,b,c不能同时为0" << endl;
					break;
				case 1:
					cout << flag << endl;
					cout << ret1 << " " << ret2 << endl;
					break;
				case 2:
					cout << flag << endl;
					cout << ret1 << endl;
					break;
				case 3:
					cout << flag << endl;
					cout << c1 <<" "<< c2 <<endl;
					break;
				case 4:
					cout << flag << endl;
					break;
				case 5:
					break;
				case 6:
					cout << flag << endl;
					cout << setprecision(2)<<ret1 << endl;
					break;
			}
		}

};


void maxdiv()
{
	int a, b;
	cin >> a >> b;
	Integer A(a);
	Integer B(b);
	cout << A.gcd(B) << endl;
}

void invernum()
{
	int a;
	cin >> a;
	Integer A(a);
	cout << A.inversed() << endl;
}

void equsolve()
{
	int a, b, c;
	cin >> a >> b >> c;
	Equation tmp(a, b, c);
	tmp.solve();
}

int f(unsigned int n)
{
	unsigned int m = 0;
	for (m = 0; n; ++m)
	{
		n &= (n - 1);
	}
	return m;
}

int main() {
	// maxdiv();
	// invernum();
	// equsolve();
	cout << f(2486) << endl;
	return 0;
}


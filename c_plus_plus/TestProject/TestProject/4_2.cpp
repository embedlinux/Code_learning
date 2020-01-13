#include "pch.h"
#include <iostream>
#include <cmath>
#include <complex>
#include <iomanip>

using namespace std;

// ���Լ��
class Integer {
	private:
		int _num;
	public:
		//���캯��
		Integer(int num) {
			_num = num;
		}
		//���㵱ǰInteger �� b֮������Լ��
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
		// ��ȡ��ǰֵ
		int getnum() {
			return this->_num;
		}
		//��ת_num
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
���÷��������������ʵ�����������1�����У�Ȼ���С�����������ʵ�������У�
���÷������������ʵ�����������2�����У�Ȼ�����������ʵ�������У�
���÷�����һ�Թ���������3�����У�
���÷������޽⣬���4�����У�
���÷�����������⣬���5�����У�
���÷���ֻ��һ�������������6�����У�Ȼ����������
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
			if (abs(a) < 1e-10)				// a ����0
			{
				if (abs(b) < 1e-10)			// b ����0
				{
					if (abs(c) < 1e-10)		// c ����0
					{
						;					// ͬʱΪ�㣬 û������
					}
					else
						flag = 4;			// �޽�
				}
				else                        // b ������0
				{
					flag = 6;
					ret1 = c / b;
				}
			}
			else
			{
				dlt = b * b - 4 * a *c;
				if (dlt > 1e-10)			//����0, ���������ʵ��
				{
					flag = 1;
					ret1 = -b + sqrt(dlt) / (2 * a);
					ret2 = -b - sqrt(dlt) / (2 * a);
				}
				else if (dlt < (-1e-10))    //С��0,һ�Թ����
				{
					flag = 3;
					c1 = complex<float>(-b, dlt/(2*a));
					c2 = complex<float>(-b, -dlt / (2 * a));
				}
				else                        //����0, �������ʵ��
				{
					flag = 2;
					float ret;
					ret = -b;
				}
			}
			switch (flag)
			{
				case 0:
					cout << "a,b,c����ͬʱΪ0" << endl;
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


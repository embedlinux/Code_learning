#include "stdafx.h"
#include <iostream>
#include <iomanip>
#include <string>
#include <sstream>
#include <vector>
#include <algorithm>

using namespace std;

/*
编写一个程序，
	输入一个浮点数和输出格式要求，按照格式要求将该浮点数输出。
	给定非负整数m和n，
		表示输出的浮点数小数点前的宽度为m，若宽度不够则在前面补0，
		小数点后的宽度为n，若宽度不够则在后面补0
	(补充说明：当n=0时，只需输出整数部分，当m,n都为0时，则输出0)。
*/
int set_width()
{
	int m, n;
	double num;
	cin >> m >> n;
	cin >> num;

	if (m==0 && n==0)
	{
		cout << 0 << endl;
	}
	else
	{
		cout<<setw(m)<<setfill('0')<<int(num);
		if(n != 0)
		{
			// cout.width(m);
			// cout << setw(n) << setfill('0') << num - int(num);
			ostringstream os;
			os << setiosflags(ios_base::left);
			os << setw(n+2) << setfill('0') << num - int(num);
			string str = os.str();
			for(int i = 1; i < n+2; i++)
				cout << str[i];
		}
		cout << endl;
	}
	return 0;
}

/*
实现一个学生类，
	包含学号（id），姓名（name），年级（grade）数据成员。
	为了输入输出的方便，需要对这个学生类重载“>>”和“<<”运算符，同时为了对多个学生按照学号从小到大排序，还需要重载“<”运算符，以使用STL里的sort函数。	类的声明与主函数的测试代码已给出，请将类的实现与相关重载补充完整，使得程序正确运行并输出正确结果。
*/

class Student
{
public:
       int id;
       string name, grade;
       Student(){};
	   Student(int id, string name, string grade);
       bool operator < (const Student & s) const;
};

Student::Student(int id, string name, string grade)
{
	id = id;
	name = name;
	grade = grade;
}

bool Student::operator < (const Student & s) const
{
	if(id < s.id)
		return true;
	else
		return false;
}

istream & operator >> (istream & in, Student & s)
{
	in >> s.id >> s.name >> s.grade;
	return in;
}
ostream & operator << (ostream & out, Student & s)
{
	out << s.id << " " << s.name << " " << s.grade<<endl;
	return out;
}

int get_student()
{
	vector<Student> sv;
    Student temp;
    while (cin >> temp)
    {   
		sv.push_back(temp);
    }
    sort(sv.begin(), sv.end());
	for(unsigned int i = 0; i < sv.size(); ++i)
        cout << sv[i];
	return 0;
}

int main()
{
	// set_width();
	get_student();

	system("pause");
	return 0;
}
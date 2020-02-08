#include "stdafx.h"
#include <iostream>
#include <iomanip>
#include <string>
#include <sstream>
#include <vector>
#include <algorithm>

using namespace std;

/*
��дһ������
	����һ���������������ʽҪ�󣬰��ո�ʽҪ�󽫸ø����������
	�����Ǹ�����m��n��
		��ʾ����ĸ�����С����ǰ�Ŀ��Ϊm������Ȳ�������ǰ�油0��
		С�����Ŀ��Ϊn������Ȳ������ں��油0
	(����˵������n=0ʱ��ֻ������������֣���m,n��Ϊ0ʱ�������0)��
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
ʵ��һ��ѧ���࣬
	����ѧ�ţ�id����������name�����꼶��grade�����ݳ�Ա��
	Ϊ����������ķ��㣬��Ҫ�����ѧ�������ء�>>���͡�<<���������ͬʱΪ�˶Զ��ѧ������ѧ�Ŵ�С�������򣬻���Ҫ���ء�<�����������ʹ��STL���sort������	����������������Ĳ��Դ����Ѹ������뽫���ʵ����������ز���������ʹ�ó�����ȷ���в������ȷ�����
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
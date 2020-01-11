#ifndef _CONTACTS_H
#define _CONTACTS_H

#include <string>

struct Person
{
	std::string m_Name;
	int m_Sex;
	int m_Age;
	std::string m_Phone;
	std::string m_Addr;
};

#define MAX_NUM 1000

struct Addressbooks
{
	struct Person personArray[MAX_NUM];
	int m_size;
};

	
#endif
#include "pch.h"
#include <iostream> 
#include <string>
using namespace std;


class Name {
	private:
		char name[20];
	public:
		Name();
		//Name(char *fname);

};

Name::Name() {
	//strcpy(name, ""); 
	cout << '?';
}

//Name::Name(char *fname):name(fname){
//	strcpy(name, fname); 
//	cout << '?';
//}


int main() {
	Name names[3] = { Name(), Name() };
	return 0;
}


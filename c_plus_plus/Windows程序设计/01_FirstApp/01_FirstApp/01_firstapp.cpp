#include <windows.h>
#include <tchar.h>
#include <winnt.h>

//课后作业：https://www.cctry.com/forum.php?mod=viewthread&tid=298041&extra=page%3D1%26filter%3Dtypeid%26typeid%3D398
//Message的使用：  https://www.cctry.com/thread-298028-1-1.html

int WINAPI _tWinMain(HINSTANCE hInstance, HINSTANCE hPreInstance, LPUTSTR lpCmdLine, int nCmdShow)
{
	// LPUTSTR context = "这是我在VC驿站学习的第一个程序!\nVC驿站的网址是 www.cctry.com\n欢迎光临!";
	// LPUTSTR title = "cctry.com";
	// MessageBox(NULL, _T("这是我在VC驿站的第一个Windows程序！"), _T("提示"), MB_OK);

/*
	MessageBoxEx(NULL, _T("这是我在VC驿站学习的第一个程序!\nVC驿站的网址是 www.cctry.com\n欢迎光临!"), _T("cctry.com"), \
		MB_ABORTRETRYIGNORE + MB_ICONWARNING + MB_DEFBUTTON2, \
		MAKELANGID(LANG_CHINESE_SIMPLIFIED, SUBLANG_CHINESE_SIMPLIFIED));
*/
	
	MessageBoxEx(NULL, _T(lpCmdLine), _T("提示"), MB_OK, MAKELANGID(LANG_CHINESE_SIMPLIFIED, SUBLANG_CHINESE_SIMPLIFIED));
	return 0;
}
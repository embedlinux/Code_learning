#include <windows.h>
#include <tchar.h>
#include <winnt.h>

//�κ���ҵ��https://www.cctry.com/forum.php?mod=viewthread&tid=298041&extra=page%3D1%26filter%3Dtypeid%26typeid%3D398
//Message��ʹ�ã�  https://www.cctry.com/thread-298028-1-1.html

int WINAPI _tWinMain(HINSTANCE hInstance, HINSTANCE hPreInstance, LPUTSTR lpCmdLine, int nCmdShow)
{
	// LPUTSTR context = "��������VC��վѧϰ�ĵ�һ������!\nVC��վ����ַ�� www.cctry.com\n��ӭ����!";
	// LPUTSTR title = "cctry.com";
	// MessageBox(NULL, _T("��������VC��վ�ĵ�һ��Windows����"), _T("��ʾ"), MB_OK);

/*
	MessageBoxEx(NULL, _T("��������VC��վѧϰ�ĵ�һ������!\nVC��վ����ַ�� www.cctry.com\n��ӭ����!"), _T("cctry.com"), \
		MB_ABORTRETRYIGNORE + MB_ICONWARNING + MB_DEFBUTTON2, \
		MAKELANGID(LANG_CHINESE_SIMPLIFIED, SUBLANG_CHINESE_SIMPLIFIED));
*/
	
	MessageBoxEx(NULL, _T(lpCmdLine), _T("��ʾ"), MB_OK, MAKELANGID(LANG_CHINESE_SIMPLIFIED, SUBLANG_CHINESE_SIMPLIFIED));
	return 0;
}
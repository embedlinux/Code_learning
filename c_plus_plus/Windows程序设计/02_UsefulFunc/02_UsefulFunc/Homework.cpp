#include <windows.h>
#include <tchar.h>

#pragma comment(lib, "urlmon.lib")

/*
1��ʹ�� ShellExecuteEx ������ Windows ϵͳ�Դ��� IE ���������VC��վ����ַ��https://www.cctry.com/��
2��ʹ�� ShellExecuteEx ������ C:\Windows\System32 Ŀ¼����ѡ�� cmd.exe ����ļ���
3��ʹ�� ShellExecuteEx ������ �ҵĵ���/�˵��ԣ�
4��ʹ�� ShellExecuteEx ������ C:\Windows Ŀ¼���ļ����ԶԻ���
*/

int WINAPI _tWinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPTSTR lpCmdLine, int nCmdShow)
{
	SHELLEXECUTEINFO shellInfo = {0};

	LPTSTR file_exe = _T("C:\\Program Files\\internet explorer\\iexplore.exe");
	LPTSTR desc = _T("https://www.cctry.com/");

	shellInfo.cbSize = sizeof(SHELLEXECUTEINFO);
	shellInfo.lpVerb = _T("open");
	shellInfo.lpFile = file_exe;
	shellInfo.lpParameters = desc;
	shellInfo.nShow = SW_SHOW;
	BOOL bret = ShellExecuteEx(&shellInfo);

	return 0;
}
#include <windows.h>
#include <tchar.h>

#pragma comment(lib, "urlmon.lib")

/*
1、使用 ShellExecuteEx 函数以 Windows 系统自带的 IE 浏览器，打开VC驿站的网址：https://www.cctry.com/；
2、使用 ShellExecuteEx 函数打开 C:\Windows\System32 目录，并选中 cmd.exe 这个文件；
3、使用 ShellExecuteEx 函数打开 我的电脑/此电脑；
4、使用 ShellExecuteEx 函数打开 C:\Windows 目录的文件属性对话框。
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
#include <windows.h>
#include <tchar.h>

#pragma comment(lib, "urlmon.lib")

//URLDownToFile: https://www.cctry.com/forum.php?mod=viewthread&tid=298119&extra=page%3D1%26filter%3Dtypeid%26typeid%3D400
//ShellExecuteEx: https://www.cctry.com/forum.php?mod=viewthread&tid=298120&extra=page%3D1%26filter%3Dtypeid%26typeid%3D400

int WINAPI _tWinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPTSTR lpCmdLine, int nCmdShow)
{
	// const char* desc = "./����ͼƬ/1.png";
	// const char* source = "https://s.cctry.com/images/eagle3.png";
	LPTSTR desc =  _T("..\\����ͼƬ\\1.png");
	HRESULT hret = URLDownloadToFile(NULL, _T("https://s.cctry.com/images/eagle3.png"), desc,0, NULL);
	if (hret == 0)
	{
		MessageBox(NULL, _T("���سɹ�"),_T("Tips"),MB_OK);

		// ��ͼƬ
		SHELLEXECUTEINFO shellInfo = {0};
		shellInfo.cbSize = sizeof(SHELLEXECUTEINFO);
		shellInfo.lpVerb = _T("open");
		shellInfo.lpFile = desc;
		shellInfo.nShow = SW_SHOW;
		BOOL bret = ShellExecuteEx(&shellInfo);
	}
	else
	{
		MessageBox(NULL, _T("����ʧ��"),_T("Tips"),MB_OK);
	}

	return 0;
}
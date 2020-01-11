// SearchEngine.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include <WinSock2.h>
#include <iostream>
#include <string>

#pragma comment(lib, "ws2_32.lib")

// 谷歌搜索引擎

bool PraseUrl(const std::string strurl, std::string &strhost, std::string &strresource)
{
	bool bRet = false;
	do
	{
		const std::string strhttp = "http://";
		const char *szpos = strstr(strurl.c_str(),strhttp.c_str());
		if (nullptr == szpos)
		{
			szpos = strurl.c_str();
		}
		else
		{
			szpos = szpos + strhttp.length();
		}
		char szhost[MAXBYTE] = {0};
		char szrecource[MAXBYTE] = {0};
		sscanf_s(szpos,"%[^/]%s",szhost, MAXBYTE, szrecource, MAXBYTE);

		strhost = szhost;
		strresource = szrecource;
		bRet = true;

	}while (false);
	return bRet;
}

int _tmain(int argc, _TCHAR* argv[])
{
	bool bRet = false;
	do
	{
		WSADATA wsaDate;
		if(0 != WSAStartup(MAKEWORD(2, 2), &wsaDate))
			break;
		if (2 != LOBYTE(wsaDate.wVersion) || 2 != HIBYTE(wsaDate.wVersion))
			break;
		
		//服务端
		std::string url = "www.wmpic.me/tv";
		std::string strhost,strresource;
		
		PraseUrl(url, strhost, strresource);

		// std::cout<<"strhost:"<<strhost<<std::endl;
		// std::cout<<"strresource:"<<strresource<<std::endl;
		hostent *hserverhost = gethostbyname(strhost.c_str());

		if (nullptr == hserverhost)
			break;
		sockaddr_in addrserver = {0};
		addrserver.sin_family = AF_INET;
		addrserver.sin_port = htons(80);
		memcpy(&(addrserver.sin_addr), hserverhost->h_addrtype, 4);
		
		SOCKET socketserver = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);


	}while (false);
	
	return 0;
}


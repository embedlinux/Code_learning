#include "list.h"

//定义根节点
struct xLIST List_Test;

//定义节点
struct xLIST_ITEM item1;
struct xLIST_ITEM item2;
struct xLIST_ITEM item3;

int main(void)
{
	//根节点初始化
	vListInitialise(&List_Test);
	
	//节点初始化
	vListInitialiseItem(&item1);
	vListInitialiseItem(&item2);
	vListInitialiseItem(&item3);
	
	//插入节点
	vListInsert(&List_Test, &item1);
	vListInsert(&List_Test, &item2);
	vListInsert(&List_Test, &item3);
	
	
}

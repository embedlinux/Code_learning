#include "list.h"

//������ڵ�
struct xLIST List_Test;

//����ڵ�
struct xLIST_ITEM item1;
struct xLIST_ITEM item2;
struct xLIST_ITEM item3;

int main(void)
{
	//���ڵ��ʼ��
	vListInitialise(&List_Test);
	
	//�ڵ��ʼ��
	vListInitialiseItem(&item1);
	vListInitialiseItem(&item2);
	vListInitialiseItem(&item3);
	
	//����ڵ�
	vListInsert(&List_Test, &item1);
	vListInsert(&List_Test, &item2);
	vListInsert(&List_Test, &item3);
	
	
}

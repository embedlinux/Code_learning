#include <stdio.h>
#include <malloc.h>
#include "DLinkList.h"

//ͷ���ָ���� 
typedef struct _tag_DLinkList{
	DLinkListNode header;
	int length;	
	DLinkListNode* slider;                                           //�α� 
}TDLinkList;

DLinkList* DLinkList_Create()
{
	TDLinkList* ret = (TDLinkList*)malloc(sizeof(TDLinkList));       //������ 
	if(ret != NULL)
	{
		ret->header.next = NULL;
		ret->header.pre = NULL;
		ret->length = 0;
		ret->slider = NULL; 
	}
	return ret;
} 

void DLinkList_Destroy(DLinkList* list)
{
	free(list);
} 

void DLinkList_Clear(DLinkList* list)
{
	TDLinkList* sList  = (TDLinkList*)list;
	if(sList  != NULL)
	{
		sList->header.next = NULL;
		sList->header.pre = NULL;
		sList->length = 0;
		sList->slider = NULL;
	}
} 

int DLinkList_Length(DLinkList* list)
{
	TDLinkList* sList = (TDLinkList*)list;
	int ret = -1;
	if(sList != NULL)
	{
		ret = sList->length;
	}
	return ret;
} 

int DLinkList_Insert(DLinkList* list, DLinkListNode* node, int pos)    
{
	TDLinkList* sList = (TDLinkList*)list;
	int i = 0;
	int ret = (sList != NULL)&&(0 <= pos)&&(node != NULL);   //�Ϸ��Լ��
	if(ret)
	{
		DLinkListNode* current = (DLinkListNode*)sList;
		DLinkListNode* next = NULL;
		for(i=0; (i < pos)&&(current->next != NULL); i++)
		{
			current = current->next;
		}
		next = current->next;
		
		current->next = node;
		node->next = next;
		if(next != NULL)
		{
			next->pre = node;
		} 
		node->pre = current;

		if(sList->length == 0)                  //�ж��Ƿ���һ����� 
		{
			node->pre = node;
			node->next = node;
			sList->slider = node;               //�α�ָ���һ��Ԫ��               
		}
		
		sList->length++;
		
		if(current == (DLinkListNode*)sList)                             //����������ͷ���ʱ������ 
		{
			DLinkListNode* last = (DLinkListNode*)DLinkList_Get(sList,sList->length-1);
			last->next = node;
			node->pre = last;
		} 
		
	} 
	return ret;
} 

DLinkListNode* DLinkList_Get(DLinkList* list, int pos)             //��ȡԪ�� 
{
	TDLinkList* sList = (TDLinkList*)list;
	int i = 0;
	DLinkListNode* ret = NULL;   
	if((sList != NULL)&&(0 <= pos))      //�Ϸ��Լ�� 
	{
		DLinkListNode* current = (DLinkListNode*)sList;
		for(i = 0; i < pos; i++)
			current = current->next;
		ret = current->next;
	} 
	return ret;
} 

DLinkListNode* DLinkList_Delete(DLinkList* list, int pos)
{
	TDLinkList* sList = (TDLinkList*)list;
	int i = 0;
	DLinkListNode* ret = NULL; 
	DLinkListNode* next = NULL;
	  
	if((sList != NULL)&&(0 <= pos))
	{
		DLinkListNode* current = (DLinkListNode*)sList;
		for(i = 0; i < pos; i++)
			current = current->next;
		ret = current->next;
		next = ret->next;
		
		current->next = next;
		if(next != (sList->header.next))       //�ж������Ƿ�ֻ��һ������ 
		{
			next->pre = current;
		}
		if(sList->slider = ret)             //�α�ָ���Ԫ�ر�ɾʱ���α���� 
		{
			sList->slider = next;
		} 
		
		sList->length--; 
	} 
	return ret;	
} 

DLinkListNode* DLinkList_DeleteNode(DLinkList* list, DLinkListNode* node)               //ֱ��ָ��ɾ�������е�ĳ������Ԫ��
{
	TDLinkList* sList = (TDLinkList*)list;
	DLinkListNode* ret = NULL;
	int i = 0;
	if(sList != NULL)
	{
		DLinkListNode* current = (DLinkListNode*)sList;
		for(i=0; i<(sList->length); i++)
		{
			if(current->next == node)
			{
				ret=current->next;
				break;
			}
			current = current->next;
		}	
		if(ret != NULL)
		{
			DLinkList_Delete(list, i);	
		}
	}
	return ret;
}

DLinkListNode* DLinkList_Reset(DLinkList* list)
{
	TDLinkList* sList = (TDLinkList*)list;
	DLinkListNode* ret = NULL;
	
	if(sList != NULL)
	{
		sList->slider = sList->header.next;
		ret = sList->slider;
	} 
	return ret;
}

DLinkListNode* DLinkList_Current(DLinkList* list)
{
	TDLinkList* sList = (TDLinkList*)list;
	DLinkListNode* ret = NULL;
	
	if(sList != NULL)
	{
		ret = sList->slider;
	} 
	return ret;
}

DLinkListNode* DLinkList_Next(DLinkList* list)                      //���α��ƶ�ָ�������е���һ������Ԫ�أ����ص�ǰ�α� 
{
	TDLinkList* sList = (TDLinkList*)list;
	DLinkListNode* ret = NULL;
	if((sList != NULL)&&(sList->slider != NULL))
	{
		ret = sList->slider;
		sList->slider = ret->next;
	} 
	return ret;
}

DLinkListNode* DLinkList_Pre(DLinkList* list)                        //���α��ƶ�ָ�������е���һ������Ԫ�أ����ص�ǰ�α� 
{
	TDLinkList* sList = (TDLinkList*)list;
	DLinkListNode* ret = NULL;
	if((sList != NULL)&&(sList->slider != NULL))
	{
		ret = sList->slider;
		sList->slider = ret->pre;
	} 
	return ret;
}



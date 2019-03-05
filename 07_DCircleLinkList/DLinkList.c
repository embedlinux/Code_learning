#include <stdio.h>
#include <malloc.h>
#include "DLinkList.h"

//头结点指针域 
typedef struct _tag_DLinkList{
	DLinkListNode header;
	int length;	
	DLinkListNode* slider;                                           //游标 
}TDLinkList;

DLinkList* DLinkList_Create()
{
	TDLinkList* ret = (TDLinkList*)malloc(sizeof(TDLinkList));       //堆申请 
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
	int ret = (sList != NULL)&&(0 <= pos)&&(node != NULL);   //合法性检查
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

		if(sList->length == 0)                  //判断是否插第一个结点 
		{
			node->pre = node;
			node->next = node;
			sList->slider = node;               //游标指向第一个元素               
		}
		
		sList->length++;
		
		if(current == (DLinkListNode*)sList)                             //修正插入在头结点时的问题 
		{
			DLinkListNode* last = (DLinkListNode*)DLinkList_Get(sList,sList->length-1);
			last->next = node;
			node->pre = last;
		} 
		
	} 
	return ret;
} 

DLinkListNode* DLinkList_Get(DLinkList* list, int pos)             //获取元素 
{
	TDLinkList* sList = (TDLinkList*)list;
	int i = 0;
	DLinkListNode* ret = NULL;   
	if((sList != NULL)&&(0 <= pos))      //合法性检查 
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
		if(next != (sList->header.next))       //判断链表是否只有一个结点点 
		{
			next->pre = current;
		}
		if(sList->slider = ret)             //游标指向的元素被删时，游标后移 
		{
			sList->slider = next;
		} 
		
		sList->length--; 
	} 
	return ret;	
} 

DLinkListNode* DLinkList_DeleteNode(DLinkList* list, DLinkListNode* node)               //直接指定删除链表中的某个数据元素
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

DLinkListNode* DLinkList_Next(DLinkList* list)                      //将游标移动指向到链表中的下一个数据元素，返回当前游标 
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

DLinkListNode* DLinkList_Pre(DLinkList* list)                        //将游标移动指向到链表中的上一个数据元素，返回当前游标 
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



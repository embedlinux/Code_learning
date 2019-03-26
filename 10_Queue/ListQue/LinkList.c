#include <stdio.h>
#include <malloc.h>
#include "LinkList.h"

//头结点指针域 
typedef struct _tag_LinkList{
	LinkListNode header;
	int length;	
}TLinkList;

LinkList* LinkList_Create()
{
	TLinkList* ret = (TLinkList*)malloc(sizeof(TLinkList));   //堆申请 
	if(ret != NULL)
	{
		ret->header.next = NULL;
		ret->length = 0;
	}
	return ret;
} 

void LinkList_Destroy(LinkList* list)
{
	free(list);
} 

void LinkList_Clear(LinkList* list)
{
	TLinkList* sList  = (TLinkList*)list;
	if(sList  != NULL)
	{
		sList->header.next = NULL;
		sList->length = 0;
	}
} 

int LinkList_Length(LinkList* list)
{
	TLinkList* sList = (TLinkList*)list;
	int ret = -1;
	if(sList != NULL)
	{
		ret = sList->length;
	}
	return ret;
} 

int LinkList_Insert(LinkList* list, LinkListNode* node, int pos)    
{
	TLinkList* sList = (TLinkList*)list;
	int i = 0;
	int ret = (sList !=NULL)&&(0 <= pos)&&(node != NULL);   //合法性检查
	if(ret)
	{
		LinkListNode* current = (LinkListNode*)sList;
		for(i=0; (i < pos)&&(current->next != NULL); i++)
		{
			current = current->next;
		}
		node->next = current->next;
		current->next = node;
		
		sList->length++;
	} 
	return ret;
} 

LinkListNode* LinkList_Get(LinkList* list, int pos)             //获取元素 
{
	TLinkList* sList = (TLinkList*)list;
	int i = 0;
	LinkListNode* ret = NULL;   
	if((sList != NULL)&&(0 <= pos)&&(pos < (sList->length)))   //合法性检查 
	{
		LinkListNode* current = (LinkListNode*)sList;
		for(i = 0; i < pos; i++)
			current = current->next;
		ret = current->next;
	} 
	return ret;
} 

LinkListNode* LinkList_Delete(LinkList* list, int pos)
{
	TLinkList* sList = (TLinkList*)list;
	int i = 0;
	LinkListNode* ret = NULL;   
	if((sList != NULL)&&(0 <= pos)&&(pos < (sList->length)))
	{
		LinkListNode* current = (LinkListNode*)sList;
		for(i = 0; i < pos; i++)
			current = current->next;
		ret = current->next;
		current->next = ret->next;
		sList->length--; 
	} 
	return ret;
	
} 

LinkList* LinkList_Reverse(LinkList* list)    //反转操作 
{
	TLinkList* sList = (TLinkList*)list;
	LinkListNode* pre = (LinkListNode*)sList;       //得到头结点                                        
	pre = pre->next;                 				//头结点指向的元素节点                           
    LinkListNode* current = pre->next;             //第二个节点元素
	if(sList == NULL || (pre == NULL) || ((current == NULL)))   //链表为空，没有元素节点或只有一个元素节点时没有反转的必要 
		return sList;

	pre->next = NULL; 
	LinkListNode* post = NULL;
	while(current->next != NULL)
	{
		post = current->next;
		current->next = pre;
		pre = current;
		current = post;
	}
	current->next = pre;
	sList->header.next = current;
	return sList;	
} 


#include <stdio.h>
#include <malloc.h>
#include "LinkList.h"

//ͷ���ָ���� 
typedef struct _tag_LinkList{
	LinkListNode header;
	int length;	
}TLinkList;

LinkList* LinkList_Create()
{
	TLinkList* ret = (TLinkList*)malloc(sizeof(TLinkList));   //������ 
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
	int ret = (sList !=NULL)&&(0 <= pos)&&(node != NULL);   //�Ϸ��Լ��
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

LinkListNode* LinkList_Get(LinkList* list, int pos)             //��ȡԪ�� 
{
	TLinkList* sList = (TLinkList*)list;
	int i = 0;
	LinkListNode* ret = NULL;   
	if((sList != NULL)&&(0 <= pos)&&(pos < (sList->length)))   //�Ϸ��Լ�� 
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

LinkList* LinkList_Reverse(LinkList* list)    //��ת���� 
{
	TLinkList* sList = (TLinkList*)list;
	LinkListNode* pre = (LinkListNode*)sList;       //�õ�ͷ���                                        
	pre = pre->next;                 				//ͷ���ָ���Ԫ�ؽڵ�                           
    LinkListNode* current = pre->next;             //�ڶ����ڵ�Ԫ��
	if(sList == NULL || (pre == NULL) || ((current == NULL)))   //����Ϊ�գ�û��Ԫ�ؽڵ��ֻ��һ��Ԫ�ؽڵ�ʱû�з�ת�ı�Ҫ 
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


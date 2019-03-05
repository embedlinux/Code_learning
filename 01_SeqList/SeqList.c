#include <stdio.h>
#include <malloc.h>
#include "SeqList.h"

typedef unsigned int TseqListNode;
typedef struct _tag_SeqList
{
	int capacity;
	TseqListNode* node;
	int length; 
} TseqList; 


SeqList* SeqList_Create(int capacity)
{
	TseqList* ret = NULL;
	if(capacity > 0)
		ret = malloc(sizeof(TseqList) + sizeof(TseqListNode)*capacity);
		
	if (ret != NULL)
	{
		ret->capacity = capacity;
		ret->length = 0;
		ret->node = (TseqListNode*)(ret+1);
	}
}

void SeqList_Destroy(SeqList* list)
{
	free(list);
}

void SeqList_Clear(SeqList* list)
{
	TseqList* sList = (TseqList*)list;
	if(sList != NULL)
		sList->length = 0;
}

int SeqList_Length(SeqList* list)
{
	int ret = -1;
	TseqList* sList = (TseqList*)list;
	if(sList != NULL)
		ret = sList->length;
	return ret;
}

int SeqList_Capacity(SeqList* list)
{
	int ret = -1;
	TseqList* sList = (TseqList*)list;
	if(sList != NULL)
		ret = sList->capacity;
	return ret;
}

int SeqList_Insert(SeqList* list, SeqListNode* node, int pos)
{
	TseqList* sList = (TseqList*)list;
	int ret = (sList != NULL);
	int i = 0;
	
	ret = ret && (sList->length + 1 <= sList->capacity);
	ret = ret && (pos >= 0);
	
	if(ret)
	{
		if(pos >= sList->length)
			pos = sList->length;
		
		for(i = sList->length;i > pos; i--)
		{
			sList->node[i] = sList->node[i-1];
		}
		sList->node[pos] = (TseqListNode)node;          //为什么不需要加*，强制类型转换为整型数值 
		sList->length++;
	}
	return ret;
	  
}

SeqListNode* SeqList_Get(SeqList* list, int pos)
{
	TseqList* sList = (TseqList*)list;
	SeqListNode* ret = NULL;
	
	if((sList != NULL)&&(pos >= 0)&&(pos < sList->length))
		ret = (TseqListNode*)(sList->node[pos]);      //这里为什么又需要加* ，强制类型转换为指针 
		
	return ret;
}

SeqListNode* SeqList_Delete(SeqList* list, int pos)
{
	TseqList* sList = (TseqList*)list;
	SeqListNode* ret = NULL;
	int i =0;
	
	ret = SeqList_Get(list, pos);
	if(ret)
	{ 
		for(i = pos;i <= sList->length; i++)
		{
			sList->node[i] = sList->node[i+1];
		}
		sList->length--;
	} 
	return ret; 
	
}

SeqList* SeqList_Reverse(SeqList* list)
{
	TseqList* sList =  (TseqList*)list;
	int i = 0;
	TseqListNode temp; 
	if(sList)
	{
		int len = sList->length;
		for(i=0; i<(sList->length)/2;i++)
		{
			temp = sList->node[len-1-i];
			sList->node[len-1-i] = sList->node[i];
			sList->node[i] = temp;
		} 
	}
	return sList;
} 


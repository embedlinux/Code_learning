#include <stdio.h>
#include <malloc.h>
#include "StaticList.h"

#define AVAILABLE -1 

typedef struct _tag_StaticListNode{
	unsigned int data;
	int next;
}TStaticListNode;

/* 头结点定义 */
typedef struct _tag_StaticList{
	int capatity;
	TStaticListNode header;
	TStaticListNode node[];
}TStaticList; 

StaticList* StaticList_Create(int capacity)
{
	TStaticList* ret = NULL;
	int i;
	if(capacity > 0)
	{
		ret = (TStaticList*)malloc(sizeof(TStaticList)+sizeof(TStaticListNode)*(capacity+1));
	}
	if(ret != NULL)                             //表头初始化 
	{
		ret->capatity = capacity;
		ret->header.data = 0;                  //data为链表中元素个数，next为指向的元素下表 
		ret->header.next = 0;
	}
	for(i=1; i<=capacity; i++)                 //node中，node[0]为链表信息 
	{
		ret->node[i].next = AVAILABLE; 
	} 
	return ret; 
}

void StaticList_Destroy(StaticList* list)
{
	free(list);
}


void StaticList_Clear(StaticList* list)
{
	TStaticList* slist = (TStaticList*)list;
	int i;
	if(slist != NULL)
	{
		slist->header.data = 0;                   //链表长度 
		slist->header.next = 0;                   //链表首元素下标 
		for(i=1; i<=(slist->capatity); i++)
		{
			slist->node[i].next = AVAILABLE;
		}
	}
}


int StaticList_Length(StaticList* list)
{
	TStaticList* slist = (TStaticList*)list;
	int ret = -1;
	if(slist != NULL)
	{
		ret = slist->header.data;
	}
	return ret;
}


int StaticList_Capacity(StaticList* list)
{
	TStaticList* slist = (TStaticList*)list;
	int ret = -1;
	if(slist != NULL)
	{
		ret = slist->capatity;
	}
	return ret;	
}

int StaticList_Insert(StaticList* list, StaticListNode* node, int pos)
{
	TStaticList* slist = (TStaticList*)list;
	int ret = (slist != NULL);
	int current = 0;
	int index = 0;
	int i = 0;
	ret = ret && ( 0 <= pos) && (node != NULL);               //合法性检查
	ret = ret && (slist->capatity >= slist->header.data +1); //添加节点后不能超过容量
	
	if(ret)
	{
		for(i=1; i<slist->capatity; i++)                    //获取可以插入的位置 
		{
			if(slist->node[i].next == AVAILABLE)
			{ 
				index = i;
				break; 
			} 
		}
		slist->node[index].data = (unsigned int)node;      //将元素放入该节点中;
		slist->node[0] = slist->header;                    //将表头信息放入node[0];
		
		for(i=0; (i<pos)&&(slist->node[current].next != 0); i++)   
		{
			current = slist->node[current].next;
		}
		slist->node[index].next = slist->node[current].next;    //插入节点 
		slist->node[current].next = index;
		slist->node[0].data++;
		slist->header = slist->node[0];
	}
	return ret; 
	
}

StaticListNode* StaticList_Get(StaticList* list, int pos)
{
	TStaticList* slist = (TStaticList*)list;
	StaticListNode* ret = NULL;
	int i = 0;
	int current = 0;
	int obj = 0;
	
	if((slist != NULL)&&(0 <= pos) && (pos < slist->header.data))
	{
		slist->node[0] = slist->header;                    //将表头信息放入node[0];
		
		for(i=0; i<pos; i++)   
		{
			current = slist->node[current].next;
		}
		obj = slist->node[current].next;                 //需要查找的索引 
		
		ret = (TStaticList*)(slist->node[obj].data);
	}
	return ret; 	
}

StaticListNode* StaticList_Delete(StaticList* list, int pos)
{
	TStaticList* slist = (TStaticList*)list;
	StaticListNode* ret = NULL;
	int i = 0;
	int current = 0;
	int obj = 0;
	
	if((slist != NULL)&&(0 <= pos) && (pos < slist->header.data))
	{
		slist->node[0] = slist->header;                    //将表头信息放入node[0];
		
		for(i=0; i<pos; i++)   
		{
			current = slist->node[current].next;
		}
		obj = slist->node[current].next;                  //找到需要查找的索引 
		
		slist->node[current].next = slist->node[obj].next;
		slist->node[0].data--;
		
		slist->header = slist->node[0];
		slist->node[obj].next = AVAILABLE;
		
		ret = (TStaticList*)(slist->node[obj].data);
	}
	return ret; 	
}

StaticList* StaticList_Reverse(StaticList* list)
{
}


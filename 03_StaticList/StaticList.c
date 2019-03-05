#include <stdio.h>
#include <malloc.h>
#include "StaticList.h"

#define AVAILABLE -1 

typedef struct _tag_StaticListNode{
	unsigned int data;
	int next;
}TStaticListNode;

/* ͷ��㶨�� */
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
	if(ret != NULL)                             //��ͷ��ʼ�� 
	{
		ret->capatity = capacity;
		ret->header.data = 0;                  //dataΪ������Ԫ�ظ�����nextΪָ���Ԫ���±� 
		ret->header.next = 0;
	}
	for(i=1; i<=capacity; i++)                 //node�У�node[0]Ϊ������Ϣ 
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
		slist->header.data = 0;                   //������ 
		slist->header.next = 0;                   //������Ԫ���±� 
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
	ret = ret && ( 0 <= pos) && (node != NULL);               //�Ϸ��Լ��
	ret = ret && (slist->capatity >= slist->header.data +1); //��ӽڵ���ܳ�������
	
	if(ret)
	{
		for(i=1; i<slist->capatity; i++)                    //��ȡ���Բ����λ�� 
		{
			if(slist->node[i].next == AVAILABLE)
			{ 
				index = i;
				break; 
			} 
		}
		slist->node[index].data = (unsigned int)node;      //��Ԫ�ط���ýڵ���;
		slist->node[0] = slist->header;                    //����ͷ��Ϣ����node[0];
		
		for(i=0; (i<pos)&&(slist->node[current].next != 0); i++)   
		{
			current = slist->node[current].next;
		}
		slist->node[index].next = slist->node[current].next;    //����ڵ� 
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
		slist->node[0] = slist->header;                    //����ͷ��Ϣ����node[0];
		
		for(i=0; i<pos; i++)   
		{
			current = slist->node[current].next;
		}
		obj = slist->node[current].next;                 //��Ҫ���ҵ����� 
		
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
		slist->node[0] = slist->header;                    //����ͷ��Ϣ����node[0];
		
		for(i=0; i<pos; i++)   
		{
			current = slist->node[current].next;
		}
		obj = slist->node[current].next;                  //�ҵ���Ҫ���ҵ����� 
		
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


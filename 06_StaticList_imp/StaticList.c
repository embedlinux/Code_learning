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
	int capatity;                         //��ĳ��� 
	int available;                        //���б����ʼ���� 
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
		ret->available = 1;                    //��������Ԫ�شӵ�һ����ʼ 
		ret->header.data = 0;                  //dataΪ������Ԫ�ظ�����nextΪָ���Ԫ���±� 
		ret->header.next = 0;
	}
	for(i=1; i<=capacity; i++)                 //node�У�node[0]Ϊ������Ϣ 
	{
		ret->node[i].next = AVAILABLE;         //������������ 
		ret->node[i].data = i + 1;             //�����н���������� 
	} 

	ret->node[ret->capatity].data = 0;        //���һ�����
	
//	for(i=1;i<=ret->capatity;i++)
//	{
//		printf("slist->node[%d].data is %d,slist->node[%d].next is %d\n",i,ret->node[i].data,i,ret->node[i].next);
//	} 
//	printf("slist->node[0].data is %d,slist->node[0].next is %d\n",i,ret->node[0].data,i,ret->node[0].next);

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
		slist->available = 1;                     //���ý���±� 
		for(i=1; i<=(slist->capatity); i++)
		{
			slist->node[i].next = AVAILABLE;
			slist->node[i].data = i + 1;         //�����н���������� 
		}
		slist->node[slist->capatity].data = 0;     //���һ����� 	 
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
	ret = ret && ( 0 <= pos) && (node != NULL);                   //�Ϸ��Լ��
	ret = ret && ((slist->capatity) >= (slist->header.data +1)); //��ӽڵ���ܳ�������
	
	if(ret)
	{
		index = slist->available;                         //���Բ����������  
		slist->available = slist->node[index].data;       //��һ����������
		
		slist->node[index].data = (unsigned int)node;     //��Ԫ�ص�ַ 
		slist->node[0] = slist->header;                   //����ͷ��Ϣ����node[0]
 
		for(i=0; (i<pos)&&(slist->node[current].next != 0); i++)   
		{
			current = slist->node[current].next;
		}
		
		slist->node[index].next = slist->node[current].next;    //����ڵ� 
		slist->node[current].next = index;
		slist->node[0].data++;
		slist->header = slist->node[0];
	}
	
//	for(i=0;i<=slist->capatity;i++)
//	{
//		printf("slist->node[%d].data is %x,slist->node[%d].next is %d\n",i,slist->node[i].data,i,slist->node[i].next);
//	}
//	printf("slist->header.data is %d,slist->header.next is %d\n",slist->header.data,slist->header.next);
//	printf("-----------------------------------------\n");
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
		obj = slist->node[current].next;                   //��Ҫ���ҵ����� 
		
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
		slist->node[0] = slist->header;                        //����ͷ��Ϣ����node[0];
		
		for(i=0; i<pos; i++)   
		{
			current = slist->node[current].next;
		}
		obj = slist->node[current].next;                     //�ҵ���Ҫ���ҵ����� 
		
		slist->node[current].next = slist->node[obj].next;
		slist->node[0].data--;
		
		slist->header = slist->node[0];
		slist->node[obj].next = AVAILABLE;
		
		ret = (TStaticList*)(slist->node[obj].data);         //����ɾ����Ԫ�� 
		
		slist->node[obj].data = slist->available;            //ɾ����Ԫ�ؽӵ�����������ǰ�� 
		slist->available = obj;                               
//		printf("slist->node[obj].data is %d,slist->node[obj].next is %d\n",slist->node[obj].data,slist->node[obj].next);
		
//		ret = (TStaticList*)(slist->node[obj].data);
	}
	return ret; 	
}

int StaticList_GetAvaliable(StaticList* list)
{
	TStaticList* slist = (TStaticList*)list;
	int ret = 0;
	if(slist != NULL)
	{
		ret = slist->available;
	}
	return ret;
}

StaticList* StaticList_Reverse(StaticList* list)
{
}



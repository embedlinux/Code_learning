#include <malloc.h>
#include <stdio.h>
#include "ListQue.h"

typedef struct _tag_LinkQueueNode TLinkQueueNode;

struct _tag_LinkQueueNode
{
	TLinkQueueNode* next;
	void* item; 
};


typedef struct _tag_LinkQueue
{
	TLinkQueueNode* front;
	TLinkQueueNode* rear;
	int length;
}TLinkQueue;


LinkQueue* LinkQueue_Create()
{
	TLinkQueue* ret = (TLinkQueue*)malloc(sizeof(TLinkQueue));
	if(ret != NULL)
	{
		ret->rear = NULL;
		ret->front = NULL;
		ret->length = 0;
	}
	return ret;
}

void LinkQueue_Destroy(LinkQueue* queue)
{
	LinkQueue_Clear(queue);
	free(queue);
}

void LinkQueue_Clear(LinkQueue* queue)
{
	while(LinkQueue_Length(queue) > 0)
	{
		LinkQueue_Retrieve(queue);
	}
}

int LinkQueue_Append(LinkQueue* queue, void* item)
{
	TLinkQueue* sQueue = (TLinkQueue*)queue;
	TLinkQueueNode* node = (TLinkQueueNode*)malloc(sizeof(TLinkQueueNode));
	int ret = (queue != NULL)&&(node != NULL)&&(item != NULL);
	
	if(ret)
	{
		node->item = item;
		
		if(sQueue->length > 0)
		{
			sQueue->rear->next = node;
			sQueue->rear = node;
			node->next = NULL;
		}
		else
		{
			sQueue->front = node;
			sQueue->rear = node;
			node->next = NULL;
		}
		sQueue->length++;
	}
	if(!ret)
	{
		free(node);
	}
	return ret;
}

void* LinkQueue_Retrieve(LinkQueue* queue)
{
	TLinkQueue* sQueue = (TLinkQueue*)queue;
	TLinkQueueNode* node = NULL;
	void* ret = NULL;
	if((sQueue != NULL)&&(sQueue->length > 0))
	{
		node = sQueue->front;
		ret = node->item;
		
		sQueue->front = node->next;
		free(node);
		
		sQueue->length--;
		
		if(sQueue->length == 0)
		{
			sQueue->front = NULL;
			sQueue->rear = NULL;	
		} 
	}
	return ret;
}


void* LinkQueue_Header(LinkQueue* queue)
{
	TLinkQueue* sQueue = (TLinkQueue*)queue;
	void* ret = NULL;
	if((sQueue != NULL)&&(sQueue->length > 0))
	{
		ret = sQueue->front->item;
	}
}

int LinkQueue_Length(LinkQueue* queue)
{
	TLinkQueue* sQueue = (TLinkQueue*)queue;
	int ret = -1;
	if(sQueue != NULL)
	{
		ret = sQueue->length;
	}
}




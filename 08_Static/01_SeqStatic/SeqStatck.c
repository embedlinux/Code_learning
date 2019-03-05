#include <malloc.h>
#include "SeqStack.h"
#include "SeqList.h"

SeqStack* SeqStack_Create(int capacity)
{
	return SeqList_Create(capacity); 
}

void SeqStack_Destroy(SeqStack* stack)
{
	free(stack);
}

void SeqStack_Clear(SeqStack* stack)
{
	SeqList_Clear(stack);
}

SeqStackNode* SeqStack_Pop(SeqStack* stack)
{
	return  SeqList_Delete(stack, SeqList_Length(stack)-1); 
}

SeqStackNode* SeqStack_Top(SeqStack* stack)
{
	return  SeqList_Get(stack, SeqList_Length(stack)-1); 
}

int SeqStack_Push(SeqStack* stack, SeqStackNode* node) 
{
	return SeqList_Insert(stack, node, SeqList_Length(stack));             
}

int SeqStack_Size(SeqStack* stack)
{
	return SeqList_Length(stack);
}

int SeqStack_Capacity(SeqStack* stack)
{
	return SeqList_Capacity(stack);
}

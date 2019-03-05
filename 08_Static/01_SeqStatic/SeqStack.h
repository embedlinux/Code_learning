#ifndef _SEQSTACK_H_
#define _SEQSTACK_H_

typedef void SeqStack;
typedef void SeqStackNode;

SeqStack* SeqStack_Create(int capacity);

void SeqStack_Destroy(SeqStack* list);

void SeqStack_Clear(SeqStack* list);

SeqStackNode* SeqStack_Pop(SeqStack* list);

SeqStackNode* SeqStack_Top(SeqStack* list);

int SeqStack_Push(SeqStack* list, SeqStackNode* node);

int SeqStack_Size(SeqStack* list);

int SeqStack_Capacity(SeqStack* list);

#endif

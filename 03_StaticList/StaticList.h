#ifndef _STATICLIST_H_
#define _STATICLIST_H_

/* 节点指针域定义 */
typedef void StaticListNode;

/* 头结点定义 */
typedef void StaticList; 

StaticList* StaticList_Creat(int capacity);

void StaticList_Destroy(StaticList* list);

void StaticList_Clear(StaticList* list);

int StaticList_Length(StaticList* list);

int StaticList_Capacity(StaticList* list);

int StaticList_Insert(StaticList* list, StaticListNode* node, int pos);

StaticListNode* StaticList_Get(StaticList* list, int pos);

StaticListNode* StaticList_Delete(StaticList* list, int pos);

StaticList* StaticList_Reverse(StaticList* list); 

#endif


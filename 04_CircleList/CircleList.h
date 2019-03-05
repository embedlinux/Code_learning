#ifndef _CIRCLELIST_H_
#define _CIRCLELIST_H_


/* 头结点定义 */
typedef void CircleList; 

/* 节点指针域定义 */
typedef struct _tag_CircleListNode CircleListNode;     
struct _tag_CircleListNode{
	CircleListNode* next;
};


CircleList* CircleList_Create();

void CircleList_Destroy(CircleList* list);

void CircleList_Clear(CircleList* list);

int CircleList_Length(CircleList* list);

int CircleList_Capacity(CircleList* list);

int CircleList_Insert(CircleList* list, CircleListNode* node, int pos);

CircleListNode* CircleList_Get(CircleList* list, int pos);

CircleListNode* CircleList_Delete(CircleList* list, int pos);

CircleList* CircleList_Reverse(CircleList* list); 

CircleListNode* CircleList_DeleteNode(CircleList* list, CircleListNode* node);

CircleListNode* CircleList_Reset(CircleList* list);

CircleListNode* CircleList_Current(CircleList* list);

CircleListNode* CircleList_Next(CircleList* list);

void test(CircleList* list);

#endif

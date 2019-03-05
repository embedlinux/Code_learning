#include <stdio.h>
#include <malloc.h>
#include "CircleList.h"

//头结点指针域 
typedef struct _tag_CircleList{
	CircleListNode header;
	CircleListNode*  slider;                                              //游标 
	int length;	
}TCircleList;

CircleList* CircleList_Create()
{
	TCircleList* ret = (TCircleList*)malloc(sizeof(TCircleList));        //堆申请 
	if(ret != NULL)
	{
		ret->header.next = NULL;
		ret->length = 0;
		ret->slider = NULL;
	}
	return ret;
} 

void CircleList_Destroy(CircleList* list)
{
	free(list);
} 

void CircleList_Clear(CircleList* list)
{
	TCircleList* sList  = (TCircleList*)list;
	if(sList  != NULL)
	{
		sList->header.next = NULL;
		sList->length = 0;
		sList->slider = NULL;
	}
} 

int CircleList_Length(CircleList* list)                                    
{
	TCircleList* sList = (TCircleList*)list;
	int ret = -1;
	if(sList != NULL)
	{
		ret = sList->length;
	}
	return ret;
} 

int CircleList_Insert(CircleList* list, CircleListNode* node, int pos)               //插入结点  
{
	TCircleList* sList = (TCircleList*)list;
	int i = 0;
	int ret = (sList !=NULL)&&(0 <= pos)&&(node != NULL);                           //合法性检查
	if(ret)
	{
		CircleListNode* current = (CircleListNode*)sList;
		for(i=0; (i < pos)&&(current->next != NULL); i++)
		{
			current = current->next;
		}
		node->next = current->next;
		current->next = node;
				
		sList->length++;
		
		if(sList->length == 1)                                                 //只有一个元素时，指向其本身 
		{
			sList->slider = node;
		}
		if(current == (CircleListNode*)sList)                                 //修正 
		{
			CircleListNode* last = CircleList_Get(sList, sList->length -1);
			last->next = current->next;
		}
	} 
	return ret;
} 

CircleListNode* CircleList_Get(CircleList* list, int pos)             //获取元素 
{
	TCircleList* sList = (TCircleList*)list;
	int i = 0;                   
	CircleListNode* ret = NULL;                                   
	if((sList != NULL)&&(0 <= pos))                                  //合法性检查 
	{
		CircleListNode* current = (CircleListNode*)sList;
		for(i = 0; i < pos; i++)
			current = current->next;
		ret = current->next;
	} 
	return ret;
} 

CircleListNode* CircleList_Delete(CircleList* list, int pos)
{
	TCircleList* sList = (TCircleList*)list;
	int i = 0;
	CircleListNode* ret = NULL;   
	if((sList != NULL)&&(0 <= pos)&&(sList->length > 0))
	{
		CircleListNode* current = (CircleListNode*)sList;
		CircleListNode* frist = sList->header.next;                                        //第一个结点
		CircleListNode* last = NULL;    //最后一个结点 
		for(i = 0; i < pos; i++)
			current = current->next;
			 
		if(current == (CircleListNode*)sList) 
		{
			last = (CircleListNode*)CircleList_Get(sList, sList->length-1);
		}
		ret = current->next;
		current->next = ret->next;
		sList->length--;
		
		if(last != NULL)                                                                   //当删除的是第一个元素时
		{
			sList->header.next = ret->next;
			last->next = ret->next; 
		}	
		if(sList->slider == ret)                                                         //游标正好在需要删除的元素时，游标后移 
		{
			sList->slider = ret->next;
		} 
		if(sList->length == 0)                                                            //链表为空时 
		{
			sList->header.next = NULL;
			sList->slider = NULL; 
		} 
	} 
	return ret;
	
} 

CircleListNode* CircleList_DeleteNode(CircleList* list, CircleListNode* node)       //直接指定删除链表中的某个数据元素
{
	TCircleList* sList = (TCircleList*)list;
	CircleListNode* ret = NULL;
	int i = 0;
	if(sList != NULL) 
	{
//		CircleListNode* current = (CircleListNode*)sList;                           //在链表头中，第一个元素为header,即将header地址赋值给了current 
		CircleListNode* current = (CircleListNode*)(&(sList->header));              //取出header的地址，即指向第一个元素的地址                  
		for(i=0; i<sList->length; i++)
		{
			if(current->next == node)                                               //找到需要删除的元素 
			{
				ret = current->next;                                                
				break;
			}
			current = current->next; 
		} 
		if(ret != NULL)
		{
			CircleList_Delete(sList, i);                                           //删除该节点	
		}
	}
	return ret; 
}

CircleListNode* CircleList_Reset(CircleList* list)                                //将游标重置指向链表中的第一个数据元素         
{
	TCircleList* sList = (TCircleList*)list;
	CircleListNode* ret = NULL;
	
	if(sList != NULL)
	{
		sList->slider= sList->header.next;
		ret = sList->slider;
	} 
	return ret;
}
CircleListNode* CircleList_Current(CircleList* list)                                     //获取当前游标指向的数据元素
{
	CircleListNode* ret = NULL;
	TCircleList* sList = (TCircleList*)list;
	
	if(sList != NULL)
	{
		ret = sList->slider;
	}
	return ret;
}
CircleListNode* CircleList_Next(CircleList* list)                                       //将游标移动指向到链表中的下一个数据元素
{
	CircleListNode* ret = NULL;
	TCircleList* sList = (TCircleList*)list;
	
	if((sList != NULL) && (sList->slider != NULL))
	{
		ret = sList->slider;
		sList->slider = ret->next;                                                     //返回值还是当前元素,游标向下移动 
	}
	return ret; 
}

CircleList* CircleList_Reverse(CircleList* list)    //反转操作 
{
//	TCircleList* sList = (TCircleList*)list;
//	CircleListNode* pre = (CircleListNode*)sList;       //得到头结点                                        
//	pre = pre->next;                 				//头结点指向的元素节点                           
//    CircleListNode* current = pre->next;             //第二个节点元素
//	if(sList == NULL || (pre == NULL) || ((current == NULL)))   //链表为空，没有元素节点或只有一个元素节点时没有反转的必要 
//		return sList;
//
//	pre->next = NULL; 
//	CircleListNode* post = NULL;
//	while(current->next != NULL)
//	{
//		post = current->next;
//		current->next = pre;
//		pre = current;
//		current = post;
//	}
//	current->next = pre;
//	sList->header.next = current;
//	return sList;	
} 

void test(CircleList* list)                                          //测试 
{
	TCircleList* List111 = (TCircleList*)list;
	printf("TCircleList size is %d\n",sizeof(List111->header));
	printf("TCircleList address %x\n",List111);
	printf("TCircleList header address is %x\n",&(List111->header));
}


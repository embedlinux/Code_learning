#include <stdio.h>
#include <malloc.h>
#include "CircleList.h"

//ͷ���ָ���� 
typedef struct _tag_CircleList{
	CircleListNode header;
	CircleListNode*  slider;                                              //�α� 
	int length;	
}TCircleList;

CircleList* CircleList_Create()
{
	TCircleList* ret = (TCircleList*)malloc(sizeof(TCircleList));        //������ 
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

int CircleList_Insert(CircleList* list, CircleListNode* node, int pos)               //������  
{
	TCircleList* sList = (TCircleList*)list;
	int i = 0;
	int ret = (sList !=NULL)&&(0 <= pos)&&(node != NULL);                           //�Ϸ��Լ��
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
		
		if(sList->length == 1)                                                 //ֻ��һ��Ԫ��ʱ��ָ���䱾�� 
		{
			sList->slider = node;
		}
		if(current == (CircleListNode*)sList)                                 //���� 
		{
			CircleListNode* last = CircleList_Get(sList, sList->length -1);
			last->next = current->next;
		}
	} 
	return ret;
} 

CircleListNode* CircleList_Get(CircleList* list, int pos)             //��ȡԪ�� 
{
	TCircleList* sList = (TCircleList*)list;
	int i = 0;                   
	CircleListNode* ret = NULL;                                   
	if((sList != NULL)&&(0 <= pos))                                  //�Ϸ��Լ�� 
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
		CircleListNode* frist = sList->header.next;                                        //��һ�����
		CircleListNode* last = NULL;    //���һ����� 
		for(i = 0; i < pos; i++)
			current = current->next;
			 
		if(current == (CircleListNode*)sList) 
		{
			last = (CircleListNode*)CircleList_Get(sList, sList->length-1);
		}
		ret = current->next;
		current->next = ret->next;
		sList->length--;
		
		if(last != NULL)                                                                   //��ɾ�����ǵ�һ��Ԫ��ʱ
		{
			sList->header.next = ret->next;
			last->next = ret->next; 
		}	
		if(sList->slider == ret)                                                         //�α���������Ҫɾ����Ԫ��ʱ���α���� 
		{
			sList->slider = ret->next;
		} 
		if(sList->length == 0)                                                            //����Ϊ��ʱ 
		{
			sList->header.next = NULL;
			sList->slider = NULL; 
		} 
	} 
	return ret;
	
} 

CircleListNode* CircleList_DeleteNode(CircleList* list, CircleListNode* node)       //ֱ��ָ��ɾ�������е�ĳ������Ԫ��
{
	TCircleList* sList = (TCircleList*)list;
	CircleListNode* ret = NULL;
	int i = 0;
	if(sList != NULL) 
	{
//		CircleListNode* current = (CircleListNode*)sList;                           //������ͷ�У���һ��Ԫ��Ϊheader,����header��ַ��ֵ����current 
		CircleListNode* current = (CircleListNode*)(&(sList->header));              //ȡ��header�ĵ�ַ����ָ���һ��Ԫ�صĵ�ַ                  
		for(i=0; i<sList->length; i++)
		{
			if(current->next == node)                                               //�ҵ���Ҫɾ����Ԫ�� 
			{
				ret = current->next;                                                
				break;
			}
			current = current->next; 
		} 
		if(ret != NULL)
		{
			CircleList_Delete(sList, i);                                           //ɾ���ýڵ�	
		}
	}
	return ret; 
}

CircleListNode* CircleList_Reset(CircleList* list)                                //���α�����ָ�������еĵ�һ������Ԫ��         
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
CircleListNode* CircleList_Current(CircleList* list)                                     //��ȡ��ǰ�α�ָ�������Ԫ��
{
	CircleListNode* ret = NULL;
	TCircleList* sList = (TCircleList*)list;
	
	if(sList != NULL)
	{
		ret = sList->slider;
	}
	return ret;
}
CircleListNode* CircleList_Next(CircleList* list)                                       //���α��ƶ�ָ�������е���һ������Ԫ��
{
	CircleListNode* ret = NULL;
	TCircleList* sList = (TCircleList*)list;
	
	if((sList != NULL) && (sList->slider != NULL))
	{
		ret = sList->slider;
		sList->slider = ret->next;                                                     //����ֵ���ǵ�ǰԪ��,�α������ƶ� 
	}
	return ret; 
}

CircleList* CircleList_Reverse(CircleList* list)    //��ת���� 
{
//	TCircleList* sList = (TCircleList*)list;
//	CircleListNode* pre = (CircleListNode*)sList;       //�õ�ͷ���                                        
//	pre = pre->next;                 				//ͷ���ָ���Ԫ�ؽڵ�                           
//    CircleListNode* current = pre->next;             //�ڶ����ڵ�Ԫ��
//	if(sList == NULL || (pre == NULL) || ((current == NULL)))   //����Ϊ�գ�û��Ԫ�ؽڵ��ֻ��һ��Ԫ�ؽڵ�ʱû�з�ת�ı�Ҫ 
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

void test(CircleList* list)                                          //���� 
{
	TCircleList* List111 = (TCircleList*)list;
	printf("TCircleList size is %d\n",sizeof(List111->header));
	printf("TCircleList address %x\n",List111);
	printf("TCircleList header address is %x\n",&(List111->header));
}


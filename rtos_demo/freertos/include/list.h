#ifndef _LIST_H
#define _LIST_H

#include "FreeRTOS.h"

/*
************************************************************************
*                                �ṹ�嶨��
************************************************************************
*/

/* �ڵ�ṹ�嶨�� */
struct xLIST_ITEM
{
	TickType_t xItemValue;             /* ����ֵ�����ڰ����ڵ���˳������ */			
	struct xLIST_ITEM *  pxNext;       /* ָ��������һ���ڵ� */		
	struct xLIST_ITEM *  pxPrevious;   /* ָ������ǰһ���ڵ� */	
	void * pvOwner;					   /* ָ��ӵ�иýڵ���ں˶���ͨ����TCB */
	void *  pvContainer;		       /* ָ��ýڵ����ڵ����� */
};
typedef struct xLIST_ITEM ListItem_t;  /* �ڵ����������ض��� */

/* mini�ڵ�ṹ�嶨�壬��Ϊ˫������Ľ�β
   ��Ϊ˫����������β�����ģ�ͷ����β��β����ͷ */
struct xMINI_LIST_ITEM
{
	TickType_t xItemValue;                      /* ����ֵ�����ڰ����ڵ����������� */
	struct xLIST_ITEM *  pxNext;                /* ָ��������һ���ڵ� */
	struct xLIST_ITEM *  pxPrevious;            /* ָ������ǰһ���ڵ� */
};
typedef struct xMINI_LIST_ITEM MiniListItem_t;  /* ��С�ڵ����������ض��� */

/* ����ṹ�嶨�� */
typedef struct xLIST
{
	UBaseType_t uxNumberOfItems;    /* ����ڵ������ */
	ListItem_t *  pxIndex;			/* ����ڵ�����ָ�� */
	MiniListItem_t xListEnd;		/* �������һ���ڵ� */
} List_t;



#endif

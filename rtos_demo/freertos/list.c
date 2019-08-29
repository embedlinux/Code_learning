#include "FreeRTOS.h"
#include <stdlib.h>
#include "list.h"

/* �ڵ��ʼ�� */
void vListInitialiseItem( ListItem_t * const pxItem )
{
	/* ��ʼ���ýڵ����ڵ�����Ϊ�գ���ʾ�ڵ㻹û�в����κ����� */
	pxItem->pvContainer = NULL;
}

/* ������ڵ��ʼ�� */
void vListInitialise( List_t * const pxList )
{
	/* ����������ָ��ָ�����һ���ڵ� */
	pxList->pxIndex = ( ListItem_t * ) &( pxList->xListEnd );

	/* ���������һ���ڵ�ĸ��������ֵ����Ϊ���ȷ���ýڵ������������ڵ� */
	pxList->xListEnd.xItemValue = portMAX_DELAY;

    /* �����һ���ڵ��pxNext��pxPreviousָ���ָ��ڵ�������ʾ����Ϊ�� */
	pxList->xListEnd.pxNext = ( ListItem_t * ) &( pxList->xListEnd );
	pxList->xListEnd.pxPrevious = ( ListItem_t * ) &( pxList->xListEnd );

	/* ��ʼ������ڵ��������ֵΪ0����ʾ����Ϊ�� */
	pxList->uxNumberOfItems = ( UBaseType_t ) 0U;
}

#include <stdio.h>
#include <stdlib.h>
#include "DLinkList.h"

struct Value{
	DLinkListNode header;
	int v;
};

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

int main(int argc, char *argv[]) {
	
	int i = 0;
    DLinkList* list = DLinkList_Create();
    struct Value* pv = NULL;
    struct Value v1;
    struct Value v2;
    struct Value v3;
    struct Value v4;
    struct Value v5;
    struct Value v6;
    struct Value v7;
    struct Value v8;
    
    v1.v = 1;
    v2.v = 2;
    v3.v = 3;
    v4.v = 4;
    v5.v = 5;
    v6.v = 6;
    v7.v = 7;
    v8.v = 8;
    
    DLinkList_Insert(list, (DLinkListNode*)&v1, 0);
    DLinkList_Insert(list, (DLinkListNode*)&v2, 0);
    DLinkList_Insert(list, (DLinkListNode*)&v3, 0);
    DLinkList_Insert(list, (DLinkListNode*)&v4, 0);
    DLinkList_Insert(list, (DLinkListNode*)&v5, 0);
    DLinkList_Insert(list, (DLinkListNode*)&v6, 0);
    DLinkList_Insert(list, (DLinkListNode*)&v7, 0);
    DLinkList_Insert(list, (DLinkListNode*)&v8, 0);
    
    for(i=0; i<2*DLinkList_Length(list); i++)
    {
        pv = (struct Value*)DLinkList_Get(list, i);
        
        printf("%d\n", pv->v);
    }
    
    printf("\n");
//    
//    DLinkList_Delete(list, DLinkList_Length(list)-1);
//    DLinkList_Delete(list, 0);
//    
//    for(i=0; i<DLinkList_Length(list); i++)
//    {
//        pv = (struct Value*)DLinkList_Next(list);
////		pv = (struct Value*)DLinkList_Get(list, i);
//        printf("%d\n", pv->v);
//    }
    
    printf("\n-----------------------------------------------\n");
	
//	DLinkList_Reset(list);
//    DLinkList_Next(list);                
//    
//    pv = (struct Value*)DLinkList_Current(list);                    //当前游标指向的元素 
//    
//    printf("%d\n", pv->v);
//    
//    DLinkList_DeleteNode(list, (DLinkListNode*)pv);                //删除结点pv 
//    
//    pv = (struct Value*)DLinkList_Current(list);                  //当前游标指向的元素 
//    
//    printf("%d\n", pv->v);
//    
//    DLinkList_Pre(list);                                           //游标前移 
//    
//    pv = (struct Value*)DLinkList_Current(list);
//    
//    printf("%d\n", pv->v);
//    
//    printf("Length: %d\n", DLinkList_Length(list));
//	
//	for(i=0; i<DLinkList_Length(list); i++)
//    {
//        pv = (struct Value*)DLinkList_Next(list);
////		pv = (struct Value*)DLinkList_Get(list, i);
//        printf("%d\n", pv->v);
//    }
	DLinkList_Destroy(list); 
	
	return 0;
}

#include <stdio.h>
#include <stdlib.h>
#include "binarytree.h"
#include "SeqList.h"

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

struct Node
{
	BTreeNode header;
	char v;
};			//构造节点 

void printf_data(BTreeNode* node)
{
	if(node != NULL)
	{
		printf("%c",((struct Node*)node)->v);
		printf("\n");
	}
}

int main(int argc, char *argv[]) 
{
	
	BTree* btree = BTree_Create(); 
	
	struct Node n1 = {{NULL,NULL},'A'};
	struct Node n2 = {{NULL,NULL},'B'};
	struct Node n3 = {{NULL,NULL},'C'};
	struct Node n4 = {{NULL,NULL},'D'};
	struct Node n5 = {{NULL,NULL},'E'};
	struct Node n6 = {{NULL,NULL},'F'};
	
	BTree_Insert(btree, (BTreeNode*)&n1, 0,0,0);
	BTree_Insert(btree, (BTreeNode*)&n2, 0x00,1,0);
	BTree_Insert(btree, (BTreeNode*)&n3, 0x01,1,0);
	BTree_Insert(btree, (BTreeNode*)&n4, 0x00,2,0);
	BTree_Insert(btree, (BTreeNode*)&n5, 0x02,2,0);
	BTree_Insert(btree, (BTreeNode*)&n6, 0x02,3,0);
	BTree_Display(btree,printf_data,4,'*');
	
	printf("BTree count is: %d\n",BTree_Count(btree));
	printf("BTree heigh is: %d\n",BTree_Height(btree));
	printf("BTree Degree is: %d\n",BTree_Degree(btree));
	
	

	/*
	printf("Pre order the binary tree:\n");
	Pre_Order(BTree_Root(btree));
	printf("\n");
	
	printf("Mid order the binary tree:\n");
	Mid_Order(BTree_Root(btree));
	printf("\n");
	
	printf("Post order the binary tree:\n");
	Post_Order(BTree_Root(btree));
	printf("\n");
	
	printf("Level order the binary tree:\n");
	Level_Order(BTree_Root(btree));
	printf("\n");
	*/
	
	Display_Order("Pre_Order",Pre_Order,BTree_Root(btree));
	Display_Order("Mid_Order",Mid_Order,BTree_Root(btree));
	Display_Order("Post_Order",Post_Order,BTree_Root(btree));
	Display_Order("Level_Order",Level_Order,BTree_Root(btree));
	
//	BTreeNode* cur = BTree_Root(btree);
//	BTreeNode* p = NULL;
//	printf("Thread via left:",BTree_Root(btree));
//	thread_via_left(cur,&p);
//	
//	while(cur != NULL)
//	{
//		printf("%c ",((struct Node*)cur)->v);
//		cur = cur->left;
//	}
//	printf("\n");

	SeqList* list = SeqList_Create(BTree_Count(btree));
	BTreeNode* cur = BTree_Root(btree);
	int i =0;
	printf("Thread via List:",BTree_Root(btree));
	thread_via_list(cur,list);
	for(i = 0;i<SeqList_Length(list);i++)
	{
	 	  printf("%c ",((struct Node*)SeqList_Get(list, i))->v);
	}
	printf("\n");


	
	printf("Position At (0x02): %c\n",((struct Node*)BTree_Get(btree,0x02,3))->v); 
	
	
	BTree_Delete(btree, 0x00, 1);	
	BTree_Display(btree,printf_data,4,'*');
	printf("After delete B, BTree count is: %d\n",BTree_Count(btree));
	BTree_Clear(btree);
	printf("BTree count is: %d\n",BTree_Count(btree));
	printf("BTree heigh is: %d\n",BTree_Height(btree));
	printf("BTree Degree is: %d\n",BTree_Degree(btree));
	
	BTree_Destroy(btree);
	return 0;
}

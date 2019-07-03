#include <stdio.h>
#include <stdlib.h>
#include "binarytree.h"

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

struct Node
{
	BTreeNode header;
	char v;
};

void printf_data(BTreeNode* node)
{
	if(node != NULL)
	{
		printf("%c",((struct Node*)node)->v);
		printf("\n");
	}
}

int main(int argc, char *argv[]) {
	
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
	
	BTree_Destroy(btree);
	return 0;
}

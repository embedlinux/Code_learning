#include <stdio.h>
#include <stdlib.h>
#include <malloc.h> 
#include "binarytree.h"

//头结点定义
typedef struct _tag_BTree TBTree;
struct  _tag_BTree
{
	int count;
	BTreeNode* root;
};

//




BTree* BTree_Create()													//创建树 
{
	TBTree* ret = (TBTree*)malloc(sizeof(TBTree));
	if(ret != NULL)
	{
		ret->count = 0;
		ret->root = NULL;
	}
	return ret;
}

void BTree_Destroy(BTree* tree)											//销毁树 
{
	free(tree);
}

void BTree_Clear(BTree* tree)											//清空树 
{
	TBTree* btree = (TBTree*)tree;
	if(btree != NULL)
	{
        btree->count = 0;
	    btree->root = NULL;
	}	
}

int BTree_Insert(BTree* tree, BTreeNode* node, BTPos pos,int count,int flag)		//插入节点
{
 	TBTree* btree = (TBTree*)tree;
 	int ret = (btree != NULL) && (node != NULL) && ((flag == BT_LEFT)||(flag == BT_RIGHT));
 	int bit = 0;
 	
 	if(ret)
 	{
 		BTreeNode* parent = NULL;
 		BTreeNode* current = btree->root;
 		
 		node->left = NULL;
 		node->right = NULL;
 		
 		while((count > 0) && (current != NULL))
 		{
 		 	bit = pos & 1;			//最低位与 
			pos = pos >> 1;			//位置向前移动  
			
			parent = current;
			
			if(bit == BT_LEFT)
			{
				current = current->left;
			}
			else if(bit == BT_RIGHT)
			{
				current = current->right;
			}
			count--;
 		}
 		
 		if(flag == BT_LEFT)			//current不为空时
 		{
 			node->left = current;
	    }
	    else if(flag == BT_RIGHT)
	    {
	    	node->right = current;	
		}
		
		if(parent != NULL)			//parent不为空	
		{
			if( bit == BT_LEFT)
			{
				parent->left = node;
			}
			else if(bit == BT_RIGHT)
			{
				parent->right = node;
			}
		}
		else						//插入根节点 
		{
		 	btree->root = node;
		 	
		}
		btree->count++;
	}
	return ret;
} 

BTreeNode* BTree_Delete(BTree* tree, BTPos pos);							//删除节点 
BTreeNode* BTree_Get(BTree* tree, BTPos pos);								//获取节点 
BTreeNode* BTree_Root(BTree* tree);											//获取根 
int BTree_Height(BTree* tree);												//树的高度 
int BTree_Count(BTree* tree);												//树的节点数 
int BTree_Degree(BTree* tree);												//树的度 

static void recursive_display(BTreeNode* node,BTree_printf* pFunc,int format,int gap,char div)
{
	int i = 0;
	if((node != NULL)&&(pFunc != NULL))
	{
		 for(i=0;i<format;i++)
		 {
		 	printf("%c",div);
		 }
		 pFunc(node);
		 if((node->left != NULL)||(node->right != NULL))
		 {
		     recursive_display(node->left,pFunc,format+gap,gap,div);
		     recursive_display(node->right,pFunc,format+gap,gap,div);
		 }
	}
	else
	{
 	 	 for(i=0;i<format;i++)
		 {
		 	printf("%c",div);
		 }
		 printf("\n");	
	}
}

void BTree_Display(BTree* tree,BTree_printf* pFunc,int gap,char div)
{
	TBTree* btree = (TBTree*)tree;
	
	if(btree != NULL)
	{
		recursive_display(btree->root,pFunc,0,gap,div);
	}
}

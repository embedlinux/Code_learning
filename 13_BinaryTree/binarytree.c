#include <stdio.h>
#include <stdlib.h>
#include <malloc.h> 
#include "binarytree.h"
#include "ListQue.h" 
#include "SeqList.h"

//头结点定义
typedef struct _tag_BTree TBTree;

struct  _tag_BTree
{
	int count;
	BTreeNode* root;
};

//
struct Node
{
	BTreeNode header;
	char v;
};			//构造节点 


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
//------------------------------------------------------------------------------ 
static int recursive_count( BTreeNode* root)
{
	int ret = 0;
	if(root != NULL)
	{
		ret = recursive_count(root->left) + recursive_count(root->right) + 1;
	}
	return ret;
}

BTreeNode* BTree_Delete(BTree* tree, BTPos pos, int count)							//删除节点 
{
    TBTree* btree = (TBTree*)tree;
    BTreeNode* ret = NULL;
    int bit = 0;
    if(btree != NULL)
    {
    	BTreeNode* parent = NULL;
    	BTreeNode* current = btree->root;
    	
		while((count > 0) && (current != NULL))
 		{
 		 	bit = pos & 1;				//最低位与 
			pos = pos >> 1;				//位置向前移动  
			
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
 		
		if(parent != NULL)				//parent不为空	
		{
			if( bit == BT_LEFT)
			{
				parent->left = NULL;
			}
			else if(bit == BT_RIGHT)
			{
				parent->right = NULL;
			}
		}
		else
		{
			btree->root = NULL;
		}
 		
 		ret = current;
 		btree->count = btree->count - recursive_count(ret);
	}
    return ret;
} 

BTreeNode* BTree_Get(BTree* tree, BTPos pos,int count)								//获取节点
{
    TBTree* btree = (TBTree*)tree;
    BTreeNode* ret = NULL;
    int bit = 0;
    if(btree != NULL)
    {
    	BTreeNode* current = btree->root;
    	
		while((count > 0) && (current != NULL))
 		{
 		 	bit = pos & 1;				//最低位与 
			pos = pos >> 1;				//位置向前移动  
						
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
 		ret = current;
	}
    return ret;
} 

BTreeNode* BTree_Root(BTree* tree)										//获取根 
{
   TBTree* btree = (TBTree*)tree;
   BTreeNode* ret = NULL;
   if(btree != NULL)
   {
         ret = btree->root;
   }
   return ret;
}
//--------------------------------------------------------------------
static int recursive_heigh(BTreeNode* root)
{
	int ret = 0;
	if(root != NULL)
	{
		int lh = recursive_heigh(root->left);
		int rh = recursive_heigh(root->right);
		
		ret = ((lh > rh)?lh:rh) + 1;
	}
	return ret;
}

int BTree_Height(BTree* tree)											//树的高度
{
 	TBTree* btree = (TBTree*)tree;
	int ret = 0;
 	if(btree != NULL)
 	{
  	    ret = recursive_heigh(btree->root);
    }
    return ret;
} 

int BTree_Count(BTree* tree)										   //树的节点数
{
 	 TBTree* btree = (TBTree*)tree;
 	 int ret =0;
 	 if(btree != NULL)
 	 {
         ret = btree->count;
     }
     return ret;
} 

//--------------------------------------------------------------------
static int recursive_degree(BTreeNode* root)
{
	int ret = 0;
	if(root != NULL)
	{
	    if(root->left != NULL)
	    {
	    	ret++;
		}
		if(root->right != NULL)
		{
			ret++;
		}
		if(ret == 1)
		{
			int ld = recursive_degree(root->left);
			int rd = recursive_degree(root->right);
			
			if(ret < ld)
			{
				ret = ld;
			}
			if(ret < rd)
			{
				ret = rd;
			}
		}
	}
	return ret;
}

int BTree_Degree(BTree* tree)												//树的度 
{
 	TBTree* btree = (TBTree*)tree;
	int ret = 0;
 	if(btree != NULL)
 	{
  	    ret = recursive_degree(btree->root);
    }
    return ret;
}

//-----------------------------------------------------------------
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

//--------------------------------------------------------------遍历

void Pre_Order(BTreeNode* root)
{
 	 if(root != NULL)
	 {
	  	printf("%c ",((struct Node*)root)->v);
	  	
	  	Pre_Order(root->left);
	  	Pre_Order(root->right);
	 }
	 //printf("\n");	
} 

void Mid_Order(BTreeNode* root)
{
 	 if(root != NULL)
	 {
	  	Mid_Order(root->left);
	  	printf("%c ",((struct Node*)root)->v);
	  	Mid_Order(root->right);
	 }
	 //printf("\n");	
} 

void Post_Order(BTreeNode* root)
{
 	 if(root != NULL)
	 {
	  	Post_Order(root->left);
	  	Post_Order(root->right);
	  	printf("%c ",((struct Node*)root)->v);
	 }
	 //printf("\n");	
} 

void Level_Order(BTreeNode* root)
{
	if(root != NULL)
	{
		LinkQueue* queue = LinkQueue_Create();
		if(queue != NULL)
		{
		 	LinkQueue_Append(queue,root);
			
			while(LinkQueue_Length(queue) > 0)
			{
			   struct Node* node = (struct Node*)LinkQueue_Retrieve(queue);	
			   printf("%c ",node->v);
			   LinkQueue_Append(queue,node->header.left);
			   LinkQueue_Append(queue,node->header.right);
			}	
		}		
		LinkQueue_Destroy(queue);
	}
}

void Display_Order(char* ordername, void (*order)(BTreeNode*),BTreeNode* root)
{
	printf("%s the binary tree:\n",ordername);
	order(root);
	printf("\n");
} 

void thread_via_left(BTreeNode* root,BTreeNode** pp)
{
	 BTreeNode* p = NULL;
	 if( (root != NULL) && ( pp != NULL))
	 {
	  	 if( *pp != NULL)
	 	 {
 	  	  	 (*pp)->left = root;
 	  	  	 *pp = NULL;
 	  	  	 
 		 }
 		 if(root->left == NULL)
 		 {
 		 	*pp = root;
		 }
		 thread_via_left(root->left,pp);
		 thread_via_left(root->right,pp);	
	 }
} 

void thread_via_list(BTreeNode* root,SeqList* list)
{
	if((root != NULL) &&(list != NULL))
	{
		SeqList_Insert(list,(SeqListNode*)root,SeqList_Length(list));
		
		thread_via_list(root->left,list);
		thread_via_list(root->right,list);
	}
}

void Thread_Tree()
{
	
} 

 





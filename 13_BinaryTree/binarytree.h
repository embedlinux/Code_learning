#ifndef __BINARYTREE_H
#define __BINARYTREE_H


#define BT_LEFT 0
#define BT_RIGHT 1

typedef void BTree;

typedef unsigned long long BTPos;

typedef struct _tag_BTreeNode BTreeNode;
struct _tag_BTreeNode
{
	BTreeNode* left;
	BTreeNode* right;	
};	                            //结点指针域定义

typedef void (BTree_printf)(BTreeNode*); 

BTree* BTree_Create();														//创建树 
void BTree_Destroy(BTree* tree);											//销毁树 
void BTree_Clear(BTree* tree);												//清空树 
int BTree_Insert(BTree* tree, BTreeNode* node, BTPos pos,int count,int flag);		//插入节点 
BTreeNode* BTree_Delete(BTree* tree, BTPos pos,int count);							//删除节点 
BTreeNode* BTree_Get(BTree* tree, BTPos pos,int count);								//获取节点 
BTreeNode* BTree_Root(BTree* tree);											//获取根 
int BTree_Height(BTree* tree);												//树的高度 
int BTree_Count(BTree* tree);												//树的节点数 
int BTree_Degree(BTree* tree);												//树的度 

void BTree_Display(BTree* tree,BTree_printf* pFunc,int gap,char div);

void Pre_Order(BTreeNode* root);			//前序遍历 
void Mid_Order(BTreeNode* root);
void Post_Order(BTreeNode* root);
void Level_Order(BTreeNode* root);

void Display_Order(char* ordername, void (*order)(BTreeNode*),BTreeNode* root);


#endif

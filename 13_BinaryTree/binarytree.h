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
};	                            //���ָ������

typedef void (BTree_printf)(BTreeNode*); 

BTree* BTree_Create();														//������ 
void BTree_Destroy(BTree* tree);											//������ 
void BTree_Clear(BTree* tree);												//����� 
int BTree_Insert(BTree* tree, BTreeNode* node, BTPos pos,int count,int flag);		//����ڵ� 
BTreeNode* BTree_Delete(BTree* tree, BTPos pos);							//ɾ���ڵ� 
BTreeNode* BTree_Get(BTree* tree, BTPos pos);								//��ȡ�ڵ� 
BTreeNode* BTree_Root(BTree* tree);											//��ȡ�� 
int BTree_Height(BTree* tree);												//���ĸ߶� 
int BTree_Count(BTree* tree);												//���Ľڵ��� 
int BTree_Degree(BTree* tree);												//���Ķ� 

void BTree_Display(BTree* tree,BTree_printf* pFunc,int gap,char div);


#endif

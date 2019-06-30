#ifndef __TREE_H
#define __TREE_H

typedef void Tree;
typedef void TreeNode;

Tree* Tree_Create();									//������ 
void Tree_Destroy(Tree* tree);							//������ 
void Tree_Clear(Tree* tree);							//����� 
int Tree_Insert(Tree* tree, TreeNode* node, int pos);	//����ڵ� 
TreeNode* Tree_Delete(Tree* tree, int pos);				//ɾ���ڵ� 
TreeNode* Tree_Get(Tree* tree, int pos);				//��ȡ�ڵ� 
TreeNode* Tree_Root(Tree* tree);						//��ȡ�� 
int Tree_Height(Tree* tree);							//���ĸ߶� 
int Tree_Count(Tree* tree);								//���Ľڵ��� 
int Tree_Degree(Tree* tree);							//���Ķ� 


#endif

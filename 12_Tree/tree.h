#ifndef __TREE_H
#define __TREE_H

typedef void Tree;
typedef void TreeData;

typedef void (Tree_printf)(TreeData*); 

Tree* Tree_Create();									//������ 
void Tree_Destroy(Tree* tree);							//������ 
void Tree_Clear(Tree* tree);							//����� 
int Tree_Insert(Tree* tree, TreeData* data, int pPos);	//����ڵ� 
TreeData* Tree_Delete(Tree* tree, int pos);				//ɾ���ڵ� 
TreeData* Tree_Get(Tree* tree, int pos);				//��ȡ�ڵ� 
TreeData* Tree_Root(Tree* tree);						//��ȡ�� 
int Tree_Height(Tree* tree);							//���ĸ߶� 
int Tree_Count(Tree* tree);								//���Ľڵ��� 
int Tree_Degree(Tree* tree);							//���Ķ� 

void Tree_Display(Tree* tree,Tree_printf* pFunc,int gap,char div);


#endif

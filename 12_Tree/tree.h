#ifndef __TREE_H
#define __TREE_H

typedef void Tree;
typedef void TreeNode;

Tree* Tree_Create();									//创建树 
void Tree_Destroy(Tree* tree);							//销毁树 
void Tree_Clear(Tree* tree);							//清空树 
int Tree_Insert(Tree* tree, TreeNode* node, int pos);	//插入节点 
TreeNode* Tree_Delete(Tree* tree, int pos);				//删除节点 
TreeNode* Tree_Get(Tree* tree, int pos);				//获取节点 
TreeNode* Tree_Root(Tree* tree);						//获取根 
int Tree_Height(Tree* tree);							//树的高度 
int Tree_Count(Tree* tree);								//树的节点数 
int Tree_Degree(Tree* tree);							//树的度 


#endif

#include <stdio.h>
#include <stdlib.h>
#include <malloc.h> 
#include "tree.h"
#include "LinkList.h"

typedef struct _tag_TreeNode TreeNode;
struct _tag_TreeNode
{
	TreeData* data;
	TreeNode* parent;
	LinkList* child;	
};							  //树中节点的组织 

typedef struct _tag_TLinkNode TLinkNode;
struct _tag_TLinkNode
{
	LinkListNode header;
	TreeNode* node; 
};							//组织链表，链接所有节点 

Tree* Tree_Create()
{
	//返回组织链表
	return LinkList_Create();
}

void Tree_Destroy(Tree* tree)
{
	Tree_Clear(tree);			//清空树 
	LinkList_Destroy(tree);		//销毁组织链表 
}

void Tree_Clear(Tree* tree)
{
	Tree_Delete(tree,0);
}

int Tree_Insert(Tree* tree, TreeData* data, int pPos)
{
	LinkList* list = (LinkList*)tree;			//组织链表 
	
	int ret = (list != NULL)&&(data != NULL)&&(pPos < LinkList_Length(list));
	if(ret)
	{
		TreeNode* cNode = (TreeNode*)malloc(sizeof(TreeNode));				//申请节点空间,插入节点的空间 
		TLinkNode* trNode = (TLinkNode*)malloc(sizeof(TLinkNode));  		//组织节点 
		TLinkNode* cldNode = (TLinkNode*)malloc(sizeof(TLinkNode));  		//父节点中指向插入节点的节点 
		
		TLinkNode* pNode = (TLinkNode*)LinkList_Get(list,pPos);				//获取插入点的父节点 
		
		ret = (cNode != NULL)&&(trNode!= NULL)&&(cldNode!= NULL);
		
		if(ret)
		{
			cNode->data = data; 
			cNode->parent = NULL;
			cNode->child = LinkList_Create();
			
			trNode->node = cNode;								//组织链表指向插入节点 
			cldNode->node = cNode;								//父节点指向，插入节点 
			
			LinkList_Insert(list,(LinkListNode*)trNode,LinkList_Length(list)); 				//插入组织链表
			if(pNode != NULL)
			{
				cNode->parent = pNode->node;
				LinkList_Insert(pNode->node->child,(LinkListNode*)cldNode,LinkList_Length(pNode->node->child)); 	//节点链表 
		    } 
		    else
		    {
		    	free(cldNode);																//如果是根节点 
			}
		}
		else
		{
			free(cNode);
			free(trNode);
			free(cldNode);
	    } 
		
	}
	
	return 0;
}

static void recursive_delete(LinkList* list,TreeNode* node)
{
	if((list != NULL) && (node != NULL))
	{
	 	TreeNode* parent = node->parent;
		int index = -1;
	    int i =0;
		 
	    for(i=0;i<LinkList_Length(list);i++)		//从组织链表中删除 
	    {
		 	TLinkNode* trNode = (TLinkNode*)LinkList_Get(list,i);
			
			if(trNode->node == node)
			{
				LinkList_Delete(list,i);
				free(trNode);
			 	
			    index = i;
		    	break;
		    } 	
        }	 	
        
        if(index >= 0)							//从父亲链表中删除 
		{
			if(parent != NULL)
			{
				for(i=0;i<LinkList_Length(parent->child);i++)
				{
		 		    TLinkNode* trNode = (TLinkNode*)LinkList_Get(parent->child,i);
			
					if(trNode->node == node)
					{
						LinkList_Delete(parent->child,i);
						free(trNode);
						break;
				    } 	 			    
				}
			}
			while(LinkList_Length(node->child) > 0)		//删除所有的子节点 
			{
				TLinkNode* trNode = (TLinkNode*)LinkList_Get(node->child,0);
				
				recursive_delete(list,trNode->node);
			}
			
			LinkList_Destroy(node->child);				//销毁子链表 
			free(node);
	    }
    } 
}

TreeData* Tree_Delete(Tree* tree, int pos)
{
	TLinkNode* trNode = (TLinkNode*)LinkList_Get(tree,pos);	
	TreeData* ret = NULL;
	
	if(trNode != NULL)
	{
		ret = trNode->node->data;
		recursive_delete(tree,trNode->node);
	}
	
	return NULL;
}

TreeData* Tree_Get(Tree* tree, int pos)
{
	TLinkNode* trNode = (TLinkNode*)LinkList_Get(tree,pos);	
	TreeNode* ret = NULL;
	if(trNode != NULL)
	{
		ret = trNode->node->data;
    } 
	return ret;
}

TreeData* Tree_Root(Tree* tree)
{
	return Tree_Get(tree, 0);
}


static int recursive_high(TreeNode* node)
{
	int ret = 0;
	if(node != NULL)
	{
		int subHeight = 0;
		int i =0;
		for(i=0;i<LinkList_Length(node->child);i++)
		{
			TLinkNode* trNode = (TLinkNode*)LinkList_Get(node->child,i);
			subHeight = recursive_high(trNode->node);
			
			if(ret < subHeight)
			{
				ret = subHeight;
			}
		}
		ret = ret + 1;
	}
	return ret;
}

int Tree_Height(Tree* tree)
{
	TLinkNode* trNode = (TLinkNode*)LinkList_Get(tree,0);
	int ret = 0;
	
	if( trNode != NULL)
	{
		ret = recursive_high(trNode->node);
	}
	return ret;
}

int Tree_Count(Tree* tree)
{
	return LinkList_Length(tree);
}


static int recursive_degree(TreeNode* node)
{
	int ret = 0;
	if(node != NULL)
	{
		int subDegree =0;
		int i = 0;
		
		ret = LinkList_Length(node->child);
		
		for(i=0;i<LinkList_Length(node->child);i++)
		{
            TLinkNode* trNode = (TLinkNode*)LinkList_Get(node->child,i);
			subDegree = recursive_degree(trNode->node);
			
			if(ret < subDegree)
			{
				ret = subDegree;
			}
		}
	}
	return ret;
}
int Tree_Degree(Tree* tree)
{
    TLinkNode* trNode = (TLinkNode*)LinkList_Get(tree,0);
	int ret = 0;
	
	if( trNode != NULL)
	{
		ret = recursive_degree(trNode->node);
	}
	return ret;
}
static void recursive_display(TreeNode* node,Tree_printf* pFunc,int format,int gap,char div)
{
	int i = 0;
	if((node != NULL)&&(pFunc != NULL))
	{
		for(i = 0;i<format;i++)
		{
			printf("%c",div);
		}
		pFunc(node->data);
		//printf("%c",node->data);
		//printf("\n");
		
		for(i = 0;i<LinkList_Length(node->child);i++)
		{
             TLinkNode* trNode = (TLinkNode*)LinkList_Get(node->child,i);
  			 recursive_display(trNode->node,pFunc,format+gap,gap,div);
        } 
	}
}

void Tree_Display(Tree* tree,Tree_printf* pFunc,int gap,char div)
{
	TLinkNode* trNode = (TLinkNode*)LinkList_Get(tree,0);
	
	if(trNode != NULL)
	{
		recursive_display(trNode->node,pFunc,0,gap,div);
	}
}

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
};							  //���нڵ����֯ 

typedef struct _tag_TLinkNode TLinkNode;
struct _tag_TLinkNode
{
	LinkListNode header;
	TreeNode* node; 
};							//��֯�����������нڵ� 

Tree* Tree_Create()
{
	//������֯����
	return LinkList_Create();
}

void Tree_Destroy(Tree* tree)
{
	Tree_Clear(tree);			//����� 
	LinkList_Destroy(tree);		//������֯���� 
}

void Tree_Clear(Tree* tree)
{
	Tree_Delete(tree,0);
}

int Tree_Insert(Tree* tree, TreeData* data, int pPos)
{
	LinkList* list = (LinkList*)tree;			//��֯���� 
	
	int ret = (list != NULL)&&(data != NULL)&&(pPos < LinkList_Length(list));
	if(ret)
	{
		TreeNode* cNode = (TreeNode*)malloc(sizeof(TreeNode));				//����ڵ�ռ�,����ڵ�Ŀռ� 
		TLinkNode* trNode = (TLinkNode*)malloc(sizeof(TLinkNode));  		//��֯�ڵ� 
		TLinkNode* cldNode = (TLinkNode*)malloc(sizeof(TLinkNode));  		//���ڵ���ָ�����ڵ�Ľڵ� 
		
		TLinkNode* pNode = (TLinkNode*)LinkList_Get(list,pPos);				//��ȡ�����ĸ��ڵ� 
		
		ret = (cNode != NULL)&&(trNode!= NULL)&&(cldNode!= NULL);
		
		if(ret)
		{
			cNode->data = data; 
			cNode->parent = NULL;
			cNode->child = LinkList_Create();
			
			trNode->node = cNode;								//��֯����ָ�����ڵ� 
			cldNode->node = cNode;								//���ڵ�ָ�򣬲���ڵ� 
			
			LinkList_Insert(list,(LinkListNode*)trNode,LinkList_Length(list)); 				//������֯����
			if(pNode != NULL)
			{
				cNode->parent = pNode->node;
				LinkList_Insert(pNode->node->child,(LinkListNode*)cldNode,LinkList_Length(pNode->node->child)); 	//�ڵ����� 
		    } 
		    else
		    {
		    	free(cldNode);																//����Ǹ��ڵ� 
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
		 
	    for(i=0;i<LinkList_Length(list);i++)		//����֯������ɾ�� 
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
        
        if(index >= 0)							//�Ӹ���������ɾ�� 
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
			while(LinkList_Length(node->child) > 0)		//ɾ�����е��ӽڵ� 
			{
				TLinkNode* trNode = (TLinkNode*)LinkList_Get(node->child,0);
				
				recursive_delete(list,trNode->node);
			}
			
			LinkList_Destroy(node->child);				//���������� 
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

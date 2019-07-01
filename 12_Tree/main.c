#include <stdio.h>
#include <stdlib.h>
#include "tree.h" 

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

void printf_data(TreeData* data)
{
	printf("%c",data);
	printf("\n");
}

int main(int argc, char *argv[]) {
	Tree* tree = Tree_Create();
	int i = 0;
	
	Tree_Insert(tree, (TreeData* )'A',-1);
	Tree_Insert(tree, (TreeData* )'B', 0);
	Tree_Insert(tree, (TreeData* )'C', 0);
	Tree_Insert(tree, (TreeData* )'D', 0);
	Tree_Insert(tree, (TreeData* )'G', 0);
	Tree_Insert(tree, (TreeData* )'E', 1);
	Tree_Insert(tree, (TreeData* )'F', 1);
	Tree_Insert(tree, (TreeData* )'H', 3);
	Tree_Insert(tree, (TreeData* )'I', 3);
	Tree_Insert(tree, (TreeData* )'J', 3);
	
	printf("Full Tree\n");
	Tree_Display(tree,printf_data,2,'-');
	printf("Tree high is %d\n",Tree_Height(tree));
	printf("Tree degree is %d\n",Tree_Degree(tree));
	
	Tree_Delete(tree,2);
	printf("After delete  C:\n");
	Tree_Display(tree,printf_data,2,'-');
	
	for(i=0;i<Tree_Count(tree);i++)
	{
		printf_data(Tree_Get(tree,i));
	}
	
	Tree_Delete(tree,2);
	printf("After delete  D:\n");
	Tree_Display(tree,printf_data,2,'*');
	
	Tree_Clear(tree);
	printf("After Clear tree:\n");
	Tree_Display(tree,printf_data,2,'*');
	
	
	Tree_Destroy(tree);
	return 0;
}

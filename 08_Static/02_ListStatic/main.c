#include <stdio.h>
#include <stdlib.h>
#include "LinkStack.h"
#include "GrammarMatch.h"
#include "Calculate.h"

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

int main(int argc, char *argv[]) {
	
//	LinkStack* stack = LinkStack_Create();
//    int a[10];
//    int i = 0;
//    
//    for(i=0; i<10; i++)
//    {
//        a[i] = i;
//        
//        LinkStack_Push(stack, a + i);
//    }
//    
//    printf("Top: %d\n", *(int*)LinkStack_Top(stack));
//    printf("Length: %d\n", LinkStack_Size(stack));
//    
//    while( LinkStack_Size(stack) > 0 )
//    {
//        printf("Pop: %d\n", *(int*)LinkStack_Pop(stack));
//    }
//    
//    LinkStack_Destroy(stack);
//    
//    const char* code = "#include stdio.h> int main() { int a[5][5]; int (*p)[4]; p = a[0]; printf(\"%d\\n\", &p[3][3] - &a[3][3]); return 0; }";
//    
//    scanner(code);
    
/*-------------------º∆À„-------------------------*/
	int ret = 0;
	int i = 0;
	char result[100]={'\0'};
	
    ret = InfixtoSuffix("9+(3-1)*5",result);

    if(ret)
    {
    	printf("\n");
    	printf("Result is %d\n",CalRes(result));
	}
    
	return 0;
}

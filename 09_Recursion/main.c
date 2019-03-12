#include <stdio.h>
#include <stdlib.h>
#include "example.h"
/* run this program using the console pauser or add your own getch, system("pause") or input loop */

int main(int argc, char *argv[]) {
	
/*斐波拉切数列的计算*/
//	int i = 0;
//	for(i=1; i<10; i++)
//	{
//		printf("f(%d) = %d\n",i,fibolac(i));
//	} 
//	
/*求字符串长度 */
// 	char* s = "abckde"; 
//	printf("string length is %d\n",string_len(s));
//	
/*汉诺塔问题 */
//	hannoi(3, 'a', 'b', 'c');
// 	
/*八皇后问题*/


init_queen(); 
find(1); 


/*全排列问题*/
 	
// 	char s[] = "abb";
// 	permutation(s,0,2);    //4是 '\0' 

/*整数分解问题*/
//	int n = 5; 
//	int inter[100] = {0};
//	inter[0] = n;
//	integer_fac(inter,n,1);

	
	return 0;
}

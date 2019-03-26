#include <stdio.h>
#include <stdlib.h>
#include "sort.h" 

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

int main(int argc, char *argv[]) {
	
	/*√∞≈›≈≈–Úµƒ≤‚ ‘*/
	int array[] = {21, 25, 49, 25, 16, 8};
    int len = sizeof(array) / sizeof(*array); 
    
    output(array, len);
 //   bubblesort(array, len);
 //	insertsort(array,len);
 	selectsort(array,len);
    output(array, len);
	
	return 0;
}

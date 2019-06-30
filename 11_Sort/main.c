#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "sort.h" 

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

int* GenerateArray(int n, int rangeL,int rangeR)
{
	int* ret = malloc(sizeof(int)*n);
	
	if(ret == NULL)
		return NULL;
	srand(time(NULL));
	for(int i=0;i<n;i++)
	{
		ret[i] = rand()%(rangeR-rangeL+1) + rangeL;
	}
	return ret;
}

void DestoryArray(int* arr)
{
	free(arr);
}
 

int main(int argc, char *argv[]) {
	
	int* arr = NULL;
	int n = 20;
	arr = GenerateArray(n,0,n*10);               //生成随机数 
    
    printArray(arr, n);
 // SelectSort(array,len);
 // BubbleSort(array, len);
 //	InsertSort(array,len);
 //	sort("SelectSort",SelectSort,arr,n);
 //	sort("InsertSort",InsertSort,arr,n);
 //	sort("BubbleSort",BubbleSort,arr,n);
 //	sort("ShellSort",ShellSort,arr,n);
 // sort("QuickSort",QuickSort,arr,n);
 	sort("MergeSort",MergeSort,arr,n);
    printArray(arr, n);
    
	DestoryArray(arr);
	return 0;
}

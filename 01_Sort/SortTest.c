#include "SortTest.h"
#include <malloc.h>
#include <time.h>
#include <stdlib.h>
#include <assert.h>
#include <stdio.h>

//生成n个元素的随机数组，每个元素的随机范围为[rangL,rangR] 
int* GenerateRandomArray(int n,int rangeL,int rangeR)
{
	int* ret = NULL;
	assert(rangeL<=rangeR);
	ret = malloc(sizeof(int)*n);
	if(	ret == NULL)
	{
		return NULL;
	}
	srand((unsigned int)time(NULL));
	for(int i = 0;i<n;i++)
		ret[i] = rand() % (rangeR - rangeL +1) + rangeL;
	return ret;
}

void DestroyArray(int* arr)
{
	free(arr);
}
void testSort(char* sortName,void(*sort)(int*,int),int* arr,int n)
{
	clock_t startTime = clock();
	printf("startTime:%f\n",(double)startTime/CLOCKS_PER_SEC);
	sort(arr,n);
	clock_t endTime = clock();
	printf("endTime:%f\n",(double)startTime/CLOCKS_PER_SEC);
	printf("sortName:%s; RunTime:%fS\n",sortName,(double)(endTime-startTime)/CLOCKS_PER_SEC);
}

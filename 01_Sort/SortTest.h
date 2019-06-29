#ifndef __SORTTEST_
#define __SORTTEST_

int* GenerateRandomArray(int n,int rangeL,int rangeR);
void DestroyArray(int* arr);

void testSort(char* sortName,void(*sort)(int*,int),int* arr,int n);


#endif

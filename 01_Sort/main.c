#include <stdio.h>
#include <stdlib.h>
#include "SortTest.h"
/* run this program using the console pauser or add your own getch, system("pause") or input loop */

void swap(int *p1, int *p2)
{
	int temp;
	temp = *p1;
	*p1 = *p2;
	*p2 = temp;
}

//选择排序 
void SelectionSort(int arr[],int n)
{
	int Index = 0;
	int tmp;
	for(int i = 0; i<n;i++)
	{
		Index = i;
		for(int j = i+1;j<n;j++)
		{
			if(arr[Index]>arr[j])
			{
				swap(&arr[Index],&arr[j]);
			}
		}
	}
}

//插入排序 
void InsertSort(int arr[],int n)
{
	for(int i = 1;i<n;i++)
	{
		for(int j = i; j > 0 && (arr[j]<arr[j-1]);j--)
		{
			swap(&arr[j],&arr[j-1]);

		} 
	}
} 

//改进插入排序 ，找到arr[i]需要插入的位置后，直接插入 
void ImpInsertSort(int arr[],int n)
{
	for(int i = 1;i<n;i++)
	{
		int tmp = arr[i];
		int j;
		for(j = i; j > 0 && (arr[j-1] > tmp);j--)
		{
			arr[j] = arr[j-1];
		} 
		arr[j] = tmp;
	}
} 


int main(int argc, char *argv[]) {
	
	int* arr;
	int n = 1000;
	arr = GenerateRandomArray(n,0,n);
	//int arr[] = {10,9,8,7,6,5,4,3,2,1};
	//SelectionSort(arr,n);
	
//	testSort("SelectionSort",SelectionSort,arr,n);
	testSort("InsertSort",InsertSort,arr,n);
	testSort("ImpInsertSort",ImpInsertSort,arr,n);
		
//	for(int i = 0;i<n;i++)
//		printf("%d ",arr[i]);
	
	DestroyArray(arr);
	
	return 0;
}

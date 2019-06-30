#include <stdio.h>
#include "sort.h"
#include <time.h>
#include <stdlib.h>

void printArray(int array[],int len)
{
	int i = 0;
	for(i=0;i<len;i++)
	{
		printf("%d ",array[i]);
	}
	printf("\n");
}

void swap(int array[], int i,int j)
{
	int temp;
	temp = array[i];
	array[i] = array[j];
	array[j] = temp;
}


/*------------冒泡排序-------------------*/
void BubbleSort(int array[],int len)
{
	int i = 0;
	int j = 0;
	int flag = 1;
	
	for(i=0;(i<len)&&flag;i++)
	{
		flag = 0;
		for(j=len-1;j>i;j--)
		{
			if(array[j] < array[j-1])
			{
				flag = 1;
				swap(array,j,j-1);
			}
		}
	}
}

/*-----------------------插入排序--------------------------*/ 
void InsertSort(int array[],int len)
{
	int i = 0;
	int j = 0;
	int k = 0;
	int temp = -1;
	
	for(i=1;i<len;i++)
	{
		k = i;
		temp = array[k];
		for(j=i-1;(j>=0)&&(array[j] > temp);j--)
		{
			array[j+1] = array[j];
			k = j;
		}
		array[k] = temp;
	}
}

/*-----------------------选择排序--------------------------*/ 
void SelectSort(int array[],int len)
{
	int i = 0;
	int j = 0;
	int k = -1;
	
	for(i=0;i<len;i++)
	{
		k=i;
		for(j=i+1;j<len;j++)
		{
			if(array[j]<array[k])
			{
				k = j;
			}
		}
		swap(array,i,k);
	}
}

/*-----------------------希尔排序--------------------------*/ 
void ShellSort(int array[],int len)
{
	int i = 0;
	int j = 0;
	int k = 0;
	int temp = 0;
	int gap = len;
	
	do{
		gap = gap/3 + 1;
		for(i = gap;i<len;i+=gap)
		{
			k = i;
			temp = array[k];
			for(j=i-gap;(j>=0)&&(array[j]>temp);j-=gap)
			{
				array[j+gap] = array[j];
				k = j;
			}
			array[k] = temp;	
		} 
	}while(gap>1);	
} 

/*-----------------------快速排序--------------------------*/
int patition(int array[],int left,int right)
{
	while(left < right)
	{
		int pv = array[left];
		
		while((left < right) && (pv < array[right]))
		{
			right--;
		}
		swap(array,left,right);
		while((left < right) && (pv > array[left]))
		{
			left++;
		}
		swap(array,left,right);
	}
	return left;             					  //返回划分的位置 
}

void QSort(int array[],int left,int right)
{
	if(left < right)
	{
		int piv = patition(array,left,right);     //划分 
		
		QSort(array,left,piv-1);
		QSort(array,piv+1,right);
	}
}

void QuickSort(int array[],int len)
{
	QSort(array,0,len-1);
} 

/*-----------------------归并排序--------------------------*/
void Merge(int src[],int dec[],int left,int mid,int right)
{
	int i = left;
	int j = mid + 1;
	int k = left;
		
	while((i<=mid)&&(j<=right))
	{
		if(src[i]<src[j])
			dec[k++] = src[i++];
		else
			dec[k++] = src[j++];
	}
	
	while(i<=mid)
	{
		dec[k++] = src[i++];
	}
	while(j<=right)
	{
		dec[k++] = src[j++];
	}
}

void MSort(int src[],int dec[],int left,int right,int max)
{
	if(left==right)
		dec[left] = src[left];
	else
	{
		int mid = (left + right)/2;
		int* temp = malloc(sizeof(int)*max);
		if(temp != NULL)
		{
			MSort(src,temp,left,mid, max); 
			MSort(src,temp,mid+1,right, max); 
			Merge(temp,dec,left,mid,right);
		}	
		free(temp);
	}
}

void MergeSort(int array[],int len)
{
	MSort(array,array,0,len-1,len);
}


/*-------------------------------------------------------------------*/
 void sort(char* sortname,void (*sort)(int*,int),int* arr,int n)
{
	clock_t starttime = clock();
	sort(arr,n);
	clock_t endtime = clock();
	printf("SortName:%s,RunTime:%lf S\n",sortname,(double)(endtime-starttime)/CLOCKS_PER_SEC);
}



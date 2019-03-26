#include <stdio.h>
#include "sort.h"

/*------------√∞≈›≈≈–Ú-------------------*/

output(int array[],int len)
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
void bubblesort(int array[],int len)
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
/*-----------------------≤Â»Î≈≈–Ú--------------------------*/ 

void insertsort(int array[],int len)
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

/*-----------------------—°‘Ò≈≈–Ú--------------------------*/ 

void selectsort(int array[],int len)
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



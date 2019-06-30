#ifndef _SORT_H
#define _SORT_H

void printArray(int array[],int len);
void swap(int array[], int i,int j);
void BubbleSort(int array[],int len);
void InsertSort(int array[],int len);
void SelectSort(int array[],int len);
void ShellSort(int array[],int len);
void sort(char* sortname,void(*sort)(int*,int),int* arr,int n);

int patition(int array[],int left,int right);
void QSort(int array[],int left,int right);
void QuickSort(int array[],int len);


void Merge(int src[],int dec[],int left,int mid,int right);
void MSort(int src[],int dec[],int left,int right,int max);
void MergeSort(int array[],int len);



#endif

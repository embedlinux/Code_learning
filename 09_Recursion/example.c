#include <stdio.h>




void fibolac(int n)
{
	if((1 == n)||(2 == n))
	{
		return 1;	
	}
	else
	{
		return fibolac(n-1)+fibolac(n-2);
	}
	
}


int string_len(const char* p)
{
	if(p == NULL)
	{
		return -1;
	}
	else if(*p == '\0')
	{
		return 0; 
	}
	else
	{
		return string_len(p+1) + 1; 
	}
}


/*
   n:需要移动的盘子数量
   a:起始位置
   b:需要借助的柱子 
   c:需要移动到的柱子 
*/
int hannoi(int n, char a, char b, char c)
{
	if(1 == n)
	{
		printf("%c-->%c\n",a,c);
	}
	else
	{
		hannoi(n-1, a, c, b);
		printf("%c-->%c\n",a,c);
		hannoi(n-1, b, a, c);
	}
	
	return 0;
} 

/*
	a:用于存放分解的数
	n:需要分解的数的和
	k:分解的深度 
*/

//int integer_fac(int a[],int n,int k)
//{
//	int j,p;
//	for(j=n; (j>=1)&&(j <= a[k-1]); j--)
//	{
//		a[k] = j;
//		if(j == n)
//		{
//			printf("%d = %d",a[0],a[1]);
//			for(p=2;p<=k;p++)
//			{
//				printf("+%d",a[p]);
//			}
//			printf("\n");
//		} 
//		else
//		{
//			integer_fac(a,n-j, k+1);
//		}
//	}  
//	return 0;
//} 

int integer_fac(int a[],int n,int k)
{
	int j,p;
	for(j=n; j>=1; j--)
	{
		if(j <= a[k-1])
		{
			a[k] = j;
			if(j == n)
			{
				printf("%d = %d",a[0],a[1]);
				for(p=2;p<=k;p++)
				{
					printf("+%d",a[p]);
				}
				printf("\n");
			} 
			else
			{
				integer_fac(a,n-j, k+1);
			}	
		}
	}  
	return 0;
} 

/*
	s:需要排列的字符串
	b:起始位置
	e:结束位置 
*/

int isswap(char s[],int b, int e)
{
	int i = 0;
	for(i = b; i < e; i++)
	{
		if(s[i] == s[e])
		{
			return 0;
		}
	}
	return 1;
}

int permutation(char s[],int b,int e)
{
	if((b>=0) && (b<=e))
	{
		if(b == e)
		{
			printf("%s\n",s);
		}
		else
		{
			int i = 0;
			for(i = b; i<=e; i++)
			{
				if(isswap(s,b,i))           //去重的全排列就是从第一个数字起每个数分别与它后面非重复出现的数字交换
				{
					char c = s[b];			//交换位置
					s[b] = s[i];
					s[i] = c;
					permutation(s,b+1,e);
					
					c = s[b];			   //交换位置
					s[b] = s[i];
					s[i] = c;
				}
			}
		}
	}
} 

/*-----------------------------------------------------------*/

#define N 8

typedef struct _tag_Pos
{
    int ios;
    int jos;
} Pos;                     //位置检查 

static char board[N+2][N+2];
static Pos pos[] = { {-1, -1}, {-1, 0}, {-1, 1} };     //偏移位置 
static int count = 0;                                  //符合要求的个数 


void display()
{
    int i = 0;
    int j = 1;
    
    for(i=0; i<N+2; i++)
    {
        for(j=0; j<N+2; j++)
        {
            printf("%c", board[i][j]);
        }
        
        printf("\n");
    }
}

void init_queen()
{
	int i,j;
	for(i=0;i<N+2;i++)
	{
		board[0][i] = '#';
		board[i][0] = '#';
		board[N+1][i] = '#';
		board[i][N+1] = '#';	
	}
	
	display();
}

int check(int i,int j)
{
	int ret = 1;
	int p = 0;
	
	for(p=0; p<3; p++)
    {
        int ni = i;
        int nj = j;
        
        while( ret && (board[ni][nj] != '#') )
        {
            ni = ni + pos[p].ios;
            nj = nj + pos[p].jos;
            
            ret = ret && (board[ni][nj] != '*');
        }
    }
    return ret; 
}


int find(int i)                       //查找的第i行 
{
	int j;
	if(i > N)
	{
		count++;
		printf("Solution: %d\n", count);
		display();                   //显示 
		getchar(); 
	}
	else
	{
		for(j=1;j<=N;j++)
		{
			if(check(i,j))
			{
				board[i][j] = '*';          
                find(i+1);
                board[i][j] = ' ';            //????
			}	
		}	
	} 
}



#include <stdio.h>
#include "Calculate.h"
#include "LinkStack.h"


int IsNumber(char c)
{
	return (c >= '0')&&(c<='9');
}

int IsOperator(char c)
{
	return (c == '+')||(c == '-')||(c == '*')||(c == '/');
}

int IsLeftBarce(char c)
{
    return (c == '(');
}

int IsRightBarce(char c)
{
    return (c == ')');
}

void output(char c)
{
	if(c != '\0')
	{
		printf("%c", c);
	}
}

void loadchar(char* temp,char c)
{
	static int i = 0;
	if(c != '\0')
	{
		temp[i++] = c;
	}
}

int Priority(char c)
{
	int ret = 0;
	if((c == '+')||(c == '-'))
	{
		ret = 1;
	}
	else if((c == '*')||(c == '/'))
	{
		ret = 2;
	}
	return ret;
} 

int express(int left,int right,char c)
{
	int ret = 0;
	switch(c)
	{
		case '+':
			ret = left + right;
			break;
		case '-':
			ret = left - right;
			break;
		case '*':
			ret = left * right;
			break;
		case '/':
			ret = left / right;
			break;
		default:
			break;
	}
//	printf("%d ",ret);
	return ret;
}

int InfixtoSuffix(const char* exp, char* const p)
{
	LinkStack* stack = LinkStack_Create();
	int i = 0;
	int ret = 0;
	while(exp[i] != '\0')
	{
		if(IsNumber(exp[i]))
		{
			output(exp[i]);
			loadchar(p,exp[i]);
		}
		else if(IsOperator(exp[i]))
		{
			while(Priority(exp[i]) <= Priority((char)(int)LinkStack_Top(stack)))
			{
				output((char)(int)LinkStack_Top(stack));
				loadchar(p,(char)(int)LinkStack_Top(stack));
				LinkStack_Pop(stack);
			}
			
			LinkStack_Push(stack, (void*)(int)exp[i]);
		}
		else if(IsLeftBarce(exp[i]))
		{
			LinkStack_Push(stack, (void*)(int)exp[i]);
		}
		else if(IsRightBarce(exp[i]))
		{
			char c ='\0';                               //???
			while(!IsLeftBarce((char)(int)LinkStack_Top(stack)))
			{
				output((char)(int)LinkStack_Top(stack));
				loadchar(p,(char)(int)LinkStack_Top(stack));
				LinkStack_Pop(stack);
			}
			LinkStack_Pop(stack);
		}
		else
		{
			printf("Invalid!\n");
			break;
		}
		i++; 
	}
	
	while((LinkStack_Size(stack)>0)&&(exp[i] == '\0'))
	{
		output((char)(int)LinkStack_Top(stack));
		loadchar(p,(char)(int)LinkStack_Top(stack));
		LinkStack_Pop(stack);
		ret = 1;
	}
	LinkStack_Destroy(stack);
	return ret;
}

int value(char c)
{
    return (c - '0');
}

int CalRes(char* const exp)
{
	LinkStack* stack = LinkStack_Create();
	int i = 0;
	int ret = 0;
	while(exp[i] != '\0')
	{
		if(IsNumber(exp[i]))
		{
//			printf("");
			LinkStack_Push(stack, (void*)value(exp[i]));
		}
		else if(IsOperator(exp[i]))
		{
			int right = (int)LinkStack_Pop(stack);
			int left = (int)LinkStack_Pop(stack);
			int result = express(left, right,exp[i]);
			LinkStack_Push(stack, (void*)result);
		}
		else
		{
			printf("Invalid!\n");
			break;
		}
		i++;
	}
	if((LinkStack_Size(stack) == 1)&&(exp[i] == '\0'))
	{
		ret = (int)LinkStack_Pop(stack);
	}
	LinkStack_Destroy(stack);
	return ret;
}

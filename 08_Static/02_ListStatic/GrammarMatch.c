#include "LinkStack.h"
#include <stdio.h>


int IsLeft(char c)
{
	int ret = 0;
	switch(c)
	{
		case '<':
		case '(':
		case '[':
		case '{':
		case '\'':
		case '\"':
			ret = 1;
			break;
		default:
			ret = 0;
			break;
	}
	return ret;
}

int IsRight(char c)
{
	int ret = 0;
	switch(c)
	{
		case '>':
		case ')':
		case ']':
		case '}':
		case '\'':
		case '\"':
			ret = 1;
			break;
		default:
			ret = 0;
			break;
	}
	return ret;
}

int IsMatch(char left,char right)
{
	int ret = 0;
	
	switch(left)
	{
		case '<':
            ret = (right == '>');
            break;
        case '(':
            ret = (right == ')');
            break;
        case '[':
            ret = (right == ']');
            break;
        case '{':
            ret = (right == '}');
            break;
        case '\'':
            ret = (right == '\'');
            break;
        case '\"':
            ret = (right == '\"');
            break;
        default:
            ret = 0;
            break;
	}
	return ret;
	
}

int scanner(const char* code)
{
	LinkStack* stack = LinkStack_Create();
	int i = 0;
	int ret = 0;
	while(code[i] != '\0')
	{
		if(IsLeft(code[i]))
		{
			LinkStack_Push(stack,(void*)(code +i));
		}
		if(IsRight(code[i]))
		{
			char* c = (char*)LinkStack_Pop(stack);
			if((c == NULL) || !IsMatch(*c,code[i]))
			{
				printf("%c does not match!\n", code[i]);
                ret = 0;
                break;
			}
		}
		i++;
	}
	if((LinkStack_Size(stack) == 0)&&(code[i] == '\0'))
	{
		printf("match successful!\n");
	}
	else
	{
		printf("match fail,Invalid code!\n");
	}
	LinkStack_Destroy(stack);
	return ret;
}










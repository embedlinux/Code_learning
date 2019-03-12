#ifndef _CALCULATE_H 
#define _CALCULATE_H

#define MAXSIZE  200 

#include <stdio.h>
#include "Calculate.h"
#include "LinkStack.h"


int IsNumber(char c);

int IsOperator(char c);

int IsLeftBarce(char c);

int IsRightBarce(char c);

void output(char c);

void loadchar(char* temp,char c);

int Priority(char c);

int express(int left,int right,char c);

int InfixtoSuffix(const char* exp, char* const p);

int value(char c);

int CalRes(char* const exp);

#endif 

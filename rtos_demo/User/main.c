#include "FreeRTOS.h"
#include "task.h"

//定义根节点
struct xLIST List_Test;

//定义节点
struct xLIST_ITEM item1;
struct xLIST_ITEM item2;
struct xLIST_ITEM item3;
/*
*************************************************************************
*                              全局变量
*************************************************************************
*/
portCHAR flag1;
portCHAR flag2;

extern List_t pxReadyTasksLists[ configMAX_PRIORITIES ];

/*
*************************************************************************
*                        任务控制块 & STACK 
*************************************************************************
*/
TaskHandle_t Task1_Handle;
#define TASK1_STACK_SIZE                    20
StackType_t Task1Stack[TASK1_STACK_SIZE];
TCB_t Task1TCB;

TaskHandle_t Task2_Handle;
#define TASK2_STACK_SIZE                    20
StackType_t Task2Stack[TASK2_STACK_SIZE];
TCB_t Task2TCB;

/*
*************************************************************************
*                               函数声明 
*************************************************************************
*/
void delay (uint32_t count);
void Task1_Entry( void *p_arg );
void Task2_Entry( void *p_arg );



int main(void)
{
/*
	//根节点初始化
	vListInitialise(&List_Test);
	
	//节点初始化
	vListInitialiseItem(&item1);
	vListInitialiseItem(&item2);
	vListInitialiseItem(&item3);
	
	//插入节点
	vListInsert(&List_Test, &item1);
	vListInsert(&List_Test, &item2);
	vListInsert(&List_Test, &item3);
*/
    /* 硬件初始化 */
	/* 将硬件相关的初始化放在这里，如果是软件仿真则没有相关初始化代码 */
    
    /* 初始化与任务相关的列表，如就绪列表 */
    prvInitialiseTaskLists();
    
    /* 创建任务 */
    Task1_Handle = xTaskCreateStatic( (TaskFunction_t)Task1_Entry,   /* 任务入口 */
					                  (char *)"Task1",               /* 任务名称，字符串形式 */
					                  (uint32_t)TASK1_STACK_SIZE ,   /* 任务栈大小，单位为字 */
					                  (void *) NULL,                 /* 任务形参 */
					                  (StackType_t *)Task1Stack,     /* 任务栈起始地址 */
					                  (TCB_t *)&Task1TCB );          /* 任务控制块 */
    /* 将任务添加到就绪列表 */                                 
    vListInsertEnd( &( pxReadyTasksLists[1] ), &( ((TCB_t *)(&Task1TCB))->xStateListItem ) );
                                
    Task2_Handle = xTaskCreateStatic( (TaskFunction_t)Task2_Entry,   /* 任务入口 */
					                  (char *)"Task2",               /* 任务名称，字符串形式 */
					                  (uint32_t)TASK2_STACK_SIZE ,   /* 任务栈大小，单位为字 */
					                  (void *) NULL,                 /* 任务形参 */
					                  (StackType_t *)Task2Stack,     /* 任务栈起始地址 */
					                  (TCB_t *)&Task2TCB );          /* 任务控制块 */
    /* 将任务添加到就绪列表 */                                 
    vListInsertEnd( &( pxReadyTasksLists[2] ), &( ((TCB_t *)(&Task2TCB))->xStateListItem ) );
                                      
    /* 启动调度器，开始多任务调度，启动成功则不返回 */
    vTaskStartScheduler();                                      
    
    for(;;)
	{
		/* 系统启动成功不会到达这里 */
	}

}


/*
*************************************************************************
*                               函数实现
*************************************************************************
*/
/* 软件延时 */
void delay (uint32_t count)
{
	for(; count!=0; count--);
}
/* 任务1 */
void Task1_Entry( void *p_arg )
{
	for( ;; )
	{
		flag1 = 1;
		delay( 100 );		
		flag1 = 0;
		delay( 100 );
		
		/* 任务切换，这里是手动切换 */
        taskYIELD();
	}
}

/* 任务2 */
void Task2_Entry( void *p_arg )
{
	for( ;; )
	{
		flag2 = 1;
		delay( 100 );		
		flag2 = 0;
		delay( 100 );
		
		/* 任务切换，这里是手动切换 */
        taskYIELD();
	}
}

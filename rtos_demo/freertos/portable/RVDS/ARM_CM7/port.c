#include "FreeRTOS.h"
#include "list.h"
#include "port.h"


/*
*************************************************************************
*                              宏定义
*************************************************************************
*/
#define portINITIAL_XPSR			        ( 0x01000000 )
#define portSTART_ADDRESS_MASK				( ( StackType_t ) 0xfffffffeUL )


/* 
 * 参考资料《STM32F10xxx Cortex-M3 programming manual》4.4.3，百度搜索“PM0056”即可找到这个文档
 * 在Cortex-M中，内核外设SCB中SHPR3寄存器用于设置SysTick和PendSV的异常优先级
 * System handler priority register 3 (SCB_SHPR3) SCB_SHPR3：0xE000 ED20
 * Bits 31:24 PRI_15[7:0]: Priority of system handler 15, SysTick exception 
 * Bits 23:16 PRI_14[7:0]: Priority of system handler 14, PendSV 
 */
#define portNVIC_SYSPRI2_REG				( * ( ( volatile uint32_t * ) 0xe000ed20 ) )

#define portNVIC_PENDSV_PRI					( ( ( uint32_t ) configKERNEL_INTERRUPT_PRIORITY ) << 16UL )
#define portNVIC_SYSTICK_PRI				( ( ( uint32_t ) configKERNEL_INTERRUPT_PRIORITY ) << 24UL )



/*
*************************************************************************
*                              任务栈初始化函数
*************************************************************************
*/
__asm void vPortSVCHandler( void )
{
	PRESERVE8
	extern pxCurrentTCB

	/* Get the location of the current TCB. */
	ldr	r3, =pxCurrentTCB
	ldr r1, [r3]
	ldr r0, [r1]
	/* Pop the core registers. */
	ldmia r0!, {r4-r11}
	msr psp, r0
	isb
	mov r0, #0
	msr	basepri, r0
	orr r14, #0xd   
	bx r14
}

__asm void xPortPendSVHandler( void )
{
	extern pxCurrentTCB
	extern vTaskSwitchContext

	PRESERVE8

	mrs r0, psp
	isb
	/* Get the location of the current TCB. */
	ldr	r3, =pxCurrentTCB
	ldr	r2, [r3]

	/* Save the core registers. */
	stmdb r0!, {r4-r11}

	/* Save the new top of stack into the first member of the TCB. */
	str r0, [r2]

	stmdb sp!, {r3, r14}
	
	mov r0, #configMAX_SYSCALL_INTERRUPT_PRIORITY
	msr basepri, r0
	dsb
	isb
	bl vTaskSwitchContext
	mov r0, #0
	msr basepri, r0
	ldmia sp!, {r3, r14}

	/* The first item in pxCurrentTCB is the task top of stack. */
	ldr r1, [r3]
	ldr r0, [r1]

	/* Pop the core registers. */
	ldmia r0!, {r4-r11}
	msr psp, r0
	isb
	bx r14
	
	nop
}

__asm void prvStartFirstTask( void )
{
	PRESERVE8

	/* Use the NVIC offset register to locate the stack. */
	ldr r0, =0xE000ED08
	ldr r0, [r0]
	ldr r0, [r0]
	/* Set the msp back to the start of the stack. */
	msr msp, r0
	/* Globally enable interrupts. */
	cpsie i
	cpsie f
	dsb
	isb
	/* Call SVC to start the first task. */
	svc 0
	nop
	nop
}


static void prvTaskExitError( void )
{
    /* 函数停止在这里 */
    for(;;);
}

StackType_t *pxPortInitialiseStack( StackType_t *pxTopOfStack, TaskFunction_t pxCode, void *pvParameters )
{
	/* Simulate the stack frame as it would be created by a context switch
	interrupt. */

	/* Offset added to account for the way the MCU uses the stack on entry/exit
	of interrupts, and to ensure alignment. */
	//异常发生时自动加载到CPU寄存器的内容
	pxTopOfStack--;

	*pxTopOfStack = portINITIAL_XPSR;	/* xPSR */
	pxTopOfStack--;
	*pxTopOfStack = ( ( StackType_t ) pxCode ) & portSTART_ADDRESS_MASK;	/* PC, 任务入口函数 */
	pxTopOfStack--;
	*pxTopOfStack = ( StackType_t ) prvTaskExitError;	/* LR, 函数返回地址 */

	/* Save code space by skipping register initialisation. */
	pxTopOfStack -= 5;	/* R12, R3, R2 and R1. */
	*pxTopOfStack = ( StackType_t ) pvParameters;	/* R0,任务形参 */

	/* A save method is being used that requires each task to maintain its
	own exec return value. */
//	pxTopOfStack--;
//	*pxTopOfStack = portINITIAL_EXEC_RETURN;

	pxTopOfStack -= 8;	/* R11, R10, R9, R8, R7, R6, R5 and R4. */

// 返回栈顶指针
	return pxTopOfStack;
}

//启动调度器
BaseType_t xPortStartScheduler( void )
{

	/* Make PendSV and SysTick the lowest priority interrupts. */
	portNVIC_SYSPRI2_REG |= portNVIC_PENDSV_PRI;
	portNVIC_SYSPRI2_REG |= portNVIC_SYSTICK_PRI;

	/* Start the timer that generates the tick ISR.  Interrupts are disabled
	here already. */
	// vPortSetupTimerInterrupt();

	/* Initialise the critical nesting count ready for the first task. */
	// uxCriticalNesting = 0;

	/* Ensure the VFP is enabled - it should be anyway. */
	// prvEnableVFP();

	/* Lazy save always. */
	// *( portFPCCR ) |= portASPEN_AND_LSPEN_BITS;

	/* Start the first task. */
	prvStartFirstTask();

	/* Should not get here! */
	return 0;
}



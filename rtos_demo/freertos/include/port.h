#ifndef _PORT_H
#define _PORT_H	


__asm void vPortSVCHandler( void );
__asm void prvStartFirstTask( void );
static void prvTaskExitError( void );
StackType_t *pxPortInitialiseStack( StackType_t *pxTopOfStack, TaskFunction_t pxCode, void *pvParameters );
BaseType_t xPortStartScheduler( void );



#endif

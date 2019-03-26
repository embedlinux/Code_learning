

.text
.global _start



_start:

//1、关看门狗
	ldr r0,	=0x53000000
	ldr r1,	=0x0000
	str r1,	[r0]

//2、设置时钟
	/*
		配置芯片时钟：
			1.配置锁定时间，			LOCKTIME 0x4C000000
			2.配置CPU工作在异步模式
			3.设置分频系数           CLKDIVN	 0x4C000014
			4.配置MPLL控制寄存器		MPLLCON  0x4C000004   一旦设置PLL，就会锁定lock time 直到PLL输出稳定，然后CPU工作在新的时钟频率
	*/
	ldr r0, =0x4C000000
	ldr r1, =0xFFFFFFFF
	str r1, [r0]

	mrc p15,0,r0,c1,c0,0
	orr r0,r0,#0xc0000000           //R1_nF:OR:R1_iA
	mcr p15,0,r0,c1,c0,0

	//FCLK:HCLK:PCLK = 400:100:50      HDIVN=2   PDIVN=1 
	ldr r0, =0x4C000014
	ldr r1, =(2<<1)|(1<<0)
	str r1, [r0]

	/*
		Mpll = (2 * m * 12) / (p * (2^S), m = (MDIV + 8), p = (PDIV + 2), s = SDIV
		MDIV = 92, SDIV =1, PDIV =1
	  	MPLL = 2 *100 *12/(3 * 2) =400MHz		 	
	 */
	ldr r0, =0x4C000004
	ldr r1, =(92<<12)|(1<<4)|(1<<0)
	str r1,[r0]


//3、设置SDRAM

	ldr r0, =0x48000000
	adr r1, sdram_config     /* sdram_config的当前地址 */
	add r3, r0, #(13*4)
1:
	ldr r2, [r1], #4
	str r2, [r0], #4
	cmp r0, r3
	bne 1b


//4、初始化NAND FLASH，重定位代码
	ldr sp, =0x34000000

	bl nand_init

	//重定位代码
	mov r0, #0
	ldr r1, =_start
	ldr r2, =bss_start
	sub r2, r2, r1
	
	//清除bss段
	bl copy_code_to_sdram
	bl clear_bss


//5、执行main函数,绝对跳转到SDRAM
	ldr lr, =halt
	ldr pc, =main

halt:
	bl halt



sdram_config:
	.long 0x22011110	 //BWSCON
	.long 0x00000700	 //BANKCON0
	.long 0x00000700	 //BANKCON1
	.long 0x00000700	 //BANKCON2
	.long 0x00000700	 //BANKCON3  
	.long 0x00000700	 //BANKCON4
	.long 0x00000700	 //BANKCON5
	.long 0x00018005	 //BANKCON6
	.long 0x00018005	 //BANKCON7
	.long 0x008C04F4	 //REFRESH
	.long 0x000000B1	 //BANKSIZE
	.long 0x00000030	 //MRSRB6
	.long 0x00000030	 //MRSRB7
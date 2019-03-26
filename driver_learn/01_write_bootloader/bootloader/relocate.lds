SECTIONS { 
	. = 0x33F800000;

	start_ = . ;
	.text : { *(.text) }

	. = ALIGN(4);
 	.rodata : { *(.rodata) }	
 
	. = ALIGN(4);
 	.data	: { *(.data)  }
  	
	. = ALIGN(4);
  	bss_start = . ;
  	.bss :  { *(.bss)  *(COMMON) } 
  	bss_end = . ;
} 





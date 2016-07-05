/* Linker script to configure memory regions. */

SEARCH_DIR(.)
GROUP(-lgcc)

MEMORY
{
  FLASH (rx) : ORIGIN = 0x00000000, LENGTH = 256k
  RAM (rwx) :  ORIGIN = 0x20000000, LENGTH = 16k
}

OUTPUT_FORMAT ("elf32-littlearm", "elf32-bigarm", "elf32-littlearm")

ENTRY(Reset_Handler)

SECTIONS
{
	NRF_GPIO_OUT = 0x50000504;
	NRF_GPIO_OUTSET = 0x50000508;
	NRF_GPIO_OUTCLR = 0x5000050C;
	NRF_GPIO_IN = 0x50000510;
	NRF_GPIO_DIR = 0x50000514;
	NRF_GPIO_DIRSET = 0x50000518;
	NRF_GPIO_DIRCLR = 0x5000051C;
	NRF_GPIO_PINCNF0 = 0x50000700;
	NRF_GPIO_PINCNF1 = 0x50000704;
	NRF_GPIO_PINCNF2 = 0x50000708;
	NRF_GPIO_PINCNF3 = 0x5000070C;
	NRF_GPIO_PINCNF4 = 0x50000710;
	NRF_GPIO_PINCNF5 = 0x50000714;
	NRF_GPIO_PINCNF6 = 0x50000718;
	NRF_GPIO_PINCNF7 = 0x5000071C;
	NRF_GPIO_PINCNF8 = 0x50000720;
	NRF_GPIO_PINCNF9 = 0x50000724;
	NRF_GPIO_PINCNF10 = 0x50000728;
	NRF_GPIO_PINCNF11 = 0x5000072C;
	NRF_GPIO_PINCNF12 = 0x50000730;
	NRF_GPIO_PINCNF13 = 0x50000734;
	NRF_GPIO_PINCNF14 = 0x50000738;
	NRF_GPIO_PINCNF15 = 0x5000073C;
	NRF_GPIO_PINCNF16 = 0x50000740;
	NRF_GPIO_PINCNF17 = 0x50000744;
	NRF_GPIO_PINCNF18 = 0x50000748;
	NRF_GPIO_PINCNF19 = 0x5000074C;
	NRF_GPIO_PINCNF20 = 0x50000750;
	NRF_GPIO_PINCNF21 = 0x50000754;
	NRF_GPIO_PINCNF22 = 0x50000758;
	NRF_GPIO_PINCNF23 = 0x5000075C;
	NRF_GPIO_PINCNF24 = 0x50000760;
	NRF_GPIO_PINCNF25 = 0x50000764;
	NRF_GPIO_PINCNF26 = 0x50000768;
	NRF_GPIO_PINCNF27 = 0x5000076C;
	NRF_GPIO_PINCNF28 = 0x50000770;
	NRF_GPIO_PINCNF29 = 0x50000774;
	NRF_GPIO_PINCNF30 = 0x50000778;
	NRF_GPIO_PINCNF31 = 0x5000077C;
	
	.text :
	{
		KEEP(*(.Vectors))
		*(.text*)

		KEEP(*(.init))
		KEEP(*(.fini))

		/* .ctors */
		*crtbegin.o(.ctors)
		*crtbegin?.o(.ctors)
		*(EXCLUDE_FILE(*crtend?.o *crtend.o) .ctors)
		*(SORT(.ctors.*))
		*(.ctors)

		/* .dtors */
 		*crtbegin.o(.dtors)
 		*crtbegin?.o(.dtors)
 		*(EXCLUDE_FILE(*crtend?.o *crtend.o) .dtors)
 		*(SORT(.dtors.*))
 		*(.dtors)

		*(.rodata*)

		*(.eh_frame*)
		. = ALIGN(4);
	} > FLASH
    

	.ARM.extab : 
	{
		*(.ARM.extab* .gnu.linkonce.armextab.*)
		. = ALIGN(4);
	} > FLASH

	__exidx_start = .;
	.ARM.exidx :
	{
		*(.ARM.exidx* .gnu.linkonce.armexidx.*)
		. = ALIGN(4);
	} > FLASH
	__exidx_end = .;

	__etext = .;
		
	.data : AT (__etext)
	{
		__data_start__ = .;
		*(vtable)
		*(.data*)

		. = ALIGN(4);
		/* preinit data */
		PROVIDE_HIDDEN (__preinit_array_start = .);
		*(.preinit_array)
		PROVIDE_HIDDEN (__preinit_array_end = .);

		. = ALIGN(4);
		/* init data */
		PROVIDE_HIDDEN (__init_array_start = .);
		*(SORT(.init_array.*))
		*(.init_array)
		PROVIDE_HIDDEN (__init_array_end = .);


		. = ALIGN(4);
		/* finit data */
		PROVIDE_HIDDEN (__fini_array_start = .);
		*(SORT(.fini_array.*))
		*(.fini_array)
		PROVIDE_HIDDEN (__fini_array_end = .);

		*(.jcr)
		. = ALIGN(4);
		/* All data end */
		__data_end__ = .;

	} > RAM

	.bss :
	{
		. = ALIGN(4);
		__bss_start__ = .;
		*(.bss*)
		*(COMMON)
		. = ALIGN(4);
		__bss_end__ = .;
	} > RAM
	
	.heap (COPY):
	{
		__end__ = .;
		end = __end__;
		*(.heap*)
		__HeapLimit = .;
	} > RAM

	/* .stack_dummy section doesn't contains any symbols. It is only
	 * used for linker to calculate size of stack sections, and assign
	 * values to stack symbols later */
	.stack_dummy (COPY):
	{
		*(.stack*)
	} > RAM

	/* Set stack top to end of RAM, and stack limit move down by
	 * size of stack_dummy section */
	__StackTop = ORIGIN(RAM) + LENGTH(RAM);
	__StackLimit = __StackTop - SIZEOF(.stack_dummy);
	PROVIDE(__stack = __StackTop);
	
	/* Check if data + heap + stack exceeds RAM limit */
	ASSERT(__StackLimit >= __HeapLimit, "region RAM overflowed with stack")
}



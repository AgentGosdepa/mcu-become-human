	.syntax	unified
	.arch	armv6-m

	.section .stack
	.align	3
	.equ	Stack_Size, 0x00000100
	.globl	__StackTop
	.globl	__StackLimit
__StackLimit:
	.space	Stack_Size
	.size	__StackLimit, . - __StackLimit
__StackTop:
	.size	__StackTop, . - __StackTop

	.section .heap
	.align	3
	.equ	Heap_Size, 0x00000200
	.globl	__HeapBase
	.globl	__HeapLimit
__HeapBase:
	.if	Heap_Size
	.space	Heap_Size
	.endif
	.size	__HeapBase, . - __HeapBase
__HeapLimit:
	.size	__HeapLimit, . - __HeapLimit

	.section .vectors
	.align 2
	.globl	__Vectors
__Vectors:
	.long	__StackTop            /* Top of Stack */
	.long	Reset_Handler         /* Reset Handler */
	.long	NMI_Handler           /* NMI Handler */
	.long	HardFault_Handler     /* Hard Fault Handler */
	.long	Reserved_IRQHandler   /* Reserved */
	.long	Reserved_IRQHandler   /* Reserved */
	.long	Reserved_IRQHandler   /* Reserved */
	.long	Reserved_IRQHandler   /* Reserved */
	.long	Reserved_IRQHandler   /* Reserved */
	.long	Reserved_IRQHandler   /* Reserved */
	.long	Reserved_IRQHandler   /* Reserved */
	.long	SVC_Handler           /* SVCall Handler */
	.long	Reserved_IRQHandler   /* Reserved */
	.long	Reserved_IRQHandler   /* Reserved */
	.long	PendSV_Handler        /* PendSV Handler */
	.long	SysTick_Handler       /* SysTick Handler */

	/* External interrupts */
	.long	Reserved_IRQHandler         /*  0:  Watchdog Timer            */
	.long	Reserved_IRQHandler         /*  1:  Real Time Clock           */
	.long	Reserved_IRQHandler         /*  2:  Timer0 / Timer1           */
	.long	Reserved_IRQHandler         /*  3:  Timer2 / Timer3           */
	.long	Reserved_IRQHandler         /*  4:  MCIa                      */
	.long	Reserved_IRQHandler         /*  5:  EXTI0_1                   */
	.long	Reserved_IRQHandler         /*  6:  UART0 - DUT FPGA          */
	.long	Reserved_IRQHandler         /*  7:  UART1 - DUT FPGA          */
	.long	Reserved_IRQHandler         /*  8:  UART2 - DUT FPGA          */
	.long	Reserved_IRQHandler         /*  9:  UART4 - not connected     */
	.long	Reserved_IRQHandler         /* 10: AACI / AC97                */
	.long	Reserved_IRQHandler         /* 11: CLCD Combined Interrupt    */
	.long	Reserved_IRQHandler         /* 12: Ethernet                   */
	.long	Reserved_IRQHandler         /* 13: USB Device                 */
	.long	Reserved_IRQHandler         /* 14: USB Host Controller        */
	.long	Reserved_IRQHandler         /* 15: Character LCD              */
	.long	Reserved_IRQHandler         /* 16: Flexray                    */
	.long	Reserved_IRQHandler         /* 17: CAN                        */
	.long	Reserved_IRQHandler         /* 18: LIN                        */
	.long	Reserved_IRQHandler         /* 19: I2C ADC/DAC                */
	.long	Reserved_IRQHandler         /* 20: Reserved                   */
	.long	Reserved_IRQHandler         /* 21: Reserved                   */
	.long	Reserved_IRQHandler         /* 22: Reserved                   */
	.long	Reserved_IRQHandler         /* 23: Reserved                   */
	.long	Reserved_IRQHandler         /* 24: Reserved                   */
	.long	Reserved_IRQHandler         /* 25: Reserved                   */
	.long	Reserved_IRQHandler         /* 26: Reserved                   */
	.long	Reserved_IRQHandler         	/* 27: USART1                  */
	.long	Reserved_IRQHandler         /* 28: Reserved - CPU FPGA CLCD   */
	.long	Reserved_IRQHandler         /* 29: Reserved - CPU FPGA        */
	.long	Reserved_IRQHandler         /* 30: UART3    - CPU FPGA        */
	.long	Reserved_IRQHandler         /* 31: SPI Touchscreen - CPU FPGA */

	.size	__Vectors, . - __Vectors

	.text
	.thumb
	.thumb_func
	.align	1
	.globl	Reset_Handler
	.type	Reset_Handler, %function
Reset_Handler:
  /* jump into main() function */
	bl	main

	.end

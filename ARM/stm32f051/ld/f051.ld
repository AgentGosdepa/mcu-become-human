MEMORY
{
	flash (rx) : ORIGIN = 0x08000000, LENGTH = 128K
	ram (rwx) : ORIGIN = 0x20000000, LENGTH = 8K
}

.text :
{
	. = ALIGN(4);
	KEEP(*(.interrupt_vector))
	KEEP(*(.isr_vector))
	*(.text)
	*(.text*)
	*(.rodata)
	*(.rodata*)
	*(.glue_7)
	*(.glue_7t)
	*(.eh_frame)
	KEEP (*(.init))
	KEEP (*(.fini))
	. = ALIGN(4);
} > flash

_data_flash = .;

.data : AT ( _data_flash )
{
	. = ALIGN(4);
	_data_begin = .;
	_sdata = _data_begin;
	*(.data)
	*(.data*)
	. = ALIGN(4);
	_data_end = .;
	_edata = _data_end;
} > ram

.bss :
{
	. = ALIGN(4);
	_bss_begin = .;
	_sbss = _bss_begin;
	__bss_start__ = _bss_begin;
	*(.bss)
	*(.bss*)
	*(COMMON)
	. = ALIGN(4);
	_bss_end = .;
	_ebss = _bss_end;
	__bss_end__ = _bss_end;
} > ram


_stack_size = 256;
_stack_end = 0x20000000 + 8K;
_estack = _stack_end;
_stack_begin = _stack_end - _stack_size;

. = _stack_begin;
._stack :
{
	. = . + _stack_size;
} > ram

ENTRY(Reset_Handler)

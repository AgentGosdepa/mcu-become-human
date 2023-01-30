/* From Manual Ch.4 Memory map */
MEMORY {
	/* QSPI0 Non-volatile memory IS25LP032: 32Mbits / 4MBytes */
	flash (rx) : ORIGIN = 0x20000000, LENGTH = 4M
	/* Instruction Tightly Integrated Memory */
	itim (rwx) : ORIGIN = 0x08000000, LENGTH = 8K
	/* Data Tightly-Integrated Memory, or RAM
	   [ .data--> .bss--> heap-->  <--stack ] */
	dtim  (rw) : ORIGIN = 0x80000000, LENGTH = 16K
}

_lds_stack_size   = 0x1000;  /* will be placed in high 4KB */
_lds_stack_bottom = ORIGIN(dtim) + LENGTH(dtim);
_lds_stack_top    = _lds_stack_bottom - _lds_stack_size;

SECTIONS {
	.text.onflash : {
		*(.text.init_stack)
		*(.text.start)
	} >flash AT>flash

	.text : {
		_lds_text_vma_start = .;
		*(.text*)
		_lds_text_vma_end = .;
	} >itim AT>flash
	_lds_text_lma_start = LOADADDR(.text);

	.data : {
		_lds_data_vma_start = .;
		*(.rodata*)
		*(.data*)
		*(.sdata*)
		_lds_data_vma_end = .;
	} >dtim AT>flash
	/* note: LMA is flash address, VMA is dtim address. */
	_lds_data_lma_start = LOADADDR(.data);

	.bss (NOLOAD) : {
		_lds_bss_start = .;
		*(.bss*)
		*(.sbss*)
		*(COMMON)
		_lds_bss_end = .;
	} >dtim
}

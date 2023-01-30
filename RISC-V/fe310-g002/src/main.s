#io5
.equ IO0, 0x10012000
.equ INPUT_EN, (IO0 + 0x4)
.equ OUTPUT_EN, (IO0 + 0x8)
.equ OUTPUT_VAL, (IO0 + 0xC)

.equ LED, 5

.global _start
.text
_start:
	li t0, OUTPUT_EN
	lw t1, 0(t0)
	li t2, 0b1 << LED
	or t1, t1, t2
	sw t1, 0(t0)

	li t0, OUTPUT_VAL
	lw t1, 0(t0)
	li t2, 0b1 << LED
	or t1, t1, t2
	sw t1, 0(t0)

MAIN_LOOP:

	li t0, OUTPUT_VAL
	lw t1, 0(t0)
	li t2, 0b1 << LED
	xor t1, t1, t2
	sw t1, 0(t0)

	li t0, 8000000
sleep:
	addi t0, t0, -1
	bnez t0, sleep

	j MAIN_LOOP

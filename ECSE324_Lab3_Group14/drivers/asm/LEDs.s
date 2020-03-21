			.text
			.equ LEDS_BASE, 0xFF200000
			.global read_LEDs_ASM
			.global write_LEDs_ASM

read_LEDs_ASM:
			LDR R1, =LEDS_BASE		// loads address of Red LED Parallel Port into R1
			LDR R0, [R1]			// loads contents of R1 into R0
			BX LR					// branches out of subroutine

write_LEDs_ASM:
			LDR R1, =LEDS_BASE		// loads address of Red LED Parallel Port into R1
			STR R0, [R1]			// copies the contents of R0 into memory location at the address that is found in register R1
			BX LR					// branches out of subroutine

			.end
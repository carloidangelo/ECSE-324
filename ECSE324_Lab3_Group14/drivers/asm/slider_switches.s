			.text
			.equ SW_BASE, 0xFF200040
			.global read_slider_switches_ASM

read_slider_switches_ASM:
			LDR R1, =SW_BASE		// loads address of Slider Switch Parallel Port into R1	
			LDR R0, [R1]			// loads contents of R1 into R0
			BX LR					// branches out of subroutine

			.end
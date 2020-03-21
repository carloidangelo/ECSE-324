			.text
			.equ PS2_BASE, 0xFF200100
			.global read_PS2_data_ASM

read_PS2_data_ASM:
			PUSH {R4-R6}
			LDR R1, =PS2_BASE
			LDR R2, [R1]
			MOV R3, #0x8000			// used to check RVALID bit
			TST R3, R2		
			BEQ NOT_VALID
			STRB R2, [R0]
			MOV R0, #1
			B DONE
NOT_VALID:
			MOV R0, #0
DONE:
			POP {R4-R6}
			BX LR					// branches out of subroutine

			.end

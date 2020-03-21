			.text
			.equ BB_BASE, 0xFF200050
			.global read_PB_data_ASM
			.global PB_data_is_pressed_ASM
			.global read_PB_edgecap_ASM
			.global PB_edgecap_is_pressed_ASM
			.global PB_clear_edgecp_ASM
			.global enable_PB_INT_ASM
			.global disable_PB_INT_ASM

read_PB_data_ASM:
			LDR R1, =BB_BASE			
			LDR R0, [R1]			
			BX LR					

PB_data_is_pressed_ASM:
			PUSH {R4-R7}
			LDR R6, =BB_BASE
			MOV R4, #1
			MOV R5, #1
LOOP:		TST R0, R5
			BEQ SKIP
			LDR R7, [R6]
			AND R4, R4, R7
SKIP:		LSL R4, #1
			LSL R5, #1
			CMP R5, #16
			BNE LOOP
			ASR R4, #4
			CMP R4, #1
			MOVEQ R0, #1
			MOVNE R0, #0
			POP {R4-R7}
			BX LR	

read_PB_edgecap_ASM:
			LDR R1, =BB_BASE			
			LDR R0, [R1, #12]			
			BX LR
	
PB_edgecap_is_pressed_ASM:
			PUSH {R4-R7}
			LDR R6, =BB_BASE
			MOV R4, #1
			MOV R5, #1
LOOP2:		TST R0, R5
			BEQ SKIP2
			LDR R7, [R6, #12]
			AND R4, R4, R7
SKIP2:		LSL R4, #1
			LSL R5, #1
			CMP R5, #16
			BNE LOOP2
			ASR R4, #4
			CMP R4, #1
			MOVEQ R0, #1
			MOVNE R0, #0
			POP {R4-R7}
			BX LR	

PB_clear_edgecp_ASM:
			LDR R1, =BB_BASE			
			STR R0, [R1, #12]			
			BX LR

enable_PB_INT_ASM:
			LDR R1, =BB_BASE			
			STR R0, [R1, #8]			
			BX LR

disable_PB_INT_ASM:
			LDR R1, =BB_BASE
			MOV R2, #15			
			EOR R0, R0, R2
			STR R0, [R1, #8]			
			BX LR

			.end

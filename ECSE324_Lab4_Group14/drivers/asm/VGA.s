			.text
			.equ PIX_BASE, 0xC8000000
			.equ CHAR_BASE, 0xC9000000
			.global VGA_clear_charbuff_ASM
			.global VGA_clear_pixelbuff_ASM
			.global VGA_write_char_ASM
			.global VGA_write_byte_ASM
			.global VGA_draw_point_ASM
			
			
VGA_clear_pixelbuff_ASM:
			PUSH {R4-R10,LR}
			LDR R7, =PIX_BASE 
			LDR R8, =0
			LDR R9, =319
			LDR R10, =0
			LDR R4, =0
			LDR R5, =0x400
			LDR R6, =0
			B LOOP1A
LOOP1A:			CMP R8,R9
				BGT END1
				LDR R7, =PIX_BASE
				LSL R10, R8,#1
				ADD R7, R7, R10
				ADD R8, R8, #1
				MOV R4, #0
				B LOOP1B
LOOP1B:				CMP R4, #239
					BGT LOOP1A
					ADD R7, R7, R5
					ADD R4,R4, #1
					STR R6, [R7]
					B LOOP1B
END1:		POP {R4-R10,LR}
			BX LR
			
			
			
VGA_clear_charbuff_ASM:
				PUSH {R4-R9,LR}
				MOV R8,#0
				MOV R4, #0
				LDR R6, =CHAR_BASE
DOOPTA:				CMP R8, #60
					BEQ DEND2
					LSL R7, R8, #7
					ORR R9, R6, R7
					ADD R8, R8, #1
					MOV R5, #0
DOOPTB:					
						CMP R5, #80
						BEQ DOOPTA
						ORR R9, R9, R5
						ADD R5, R5, #1
						STR R4, [R9]
						B DOOPTB
DEND2:			
				
				POP {R4-R9,LR}
				BX LR
				
				
				
VGA_write_char_ASM:
				PUSH {R4,LR}
				CMP R0,#0
				BLT END3
				CMP R0,#79
				BGT END3
				CMP R1,#0
				BLT END3
				CMP R1,#59
				BGT END3
				
				LDR R4, =CHAR_BASE
				ORR R4, R4, R0
				LSL R1, R1, #7
				ORR R4, R4, R1
				STR R2, [R4]
				
END3:			POP {R4,LR}
				BX LR
				


				
VGA_write_byte_ASM:
				PUSH {R4-R5,LR}
				CMP R0,#0
				BLT END4
				CMP R0,#79
				BGT END4
				CMP R1,#0
				BLT END4
				CMP R1,#59
				BGT END4
				ADD R5, R0, R1
				CMP R5, #137
				BGT END4
				
				
				AND R4, R2, #0xF0
				LSR R4, R4, #4
				CMP R4, #10
				ADDLT R4, #48
				ADDGE R4, #65
				
				LDR R5, =CHAR_BASE
				ORR R5, R5, R0
				LSL R1, R1, #7
				ORR R5, R5, R1
				STR R4, [R5]
				
				AND R4, R2, #0xF
				CMP R4, #10
				ADDLT R4, #48
				ADDGE R4, #65
				
				ADD R0, R0, #1
				CMP R0, #79
				MOVGT R0,#0
				ADDGT R1,#1
				LDR R5, =CHAR_BASE
				ORR R5, R5, R0
				LSL R1, R1, #7
				ORR R5, R5, R1
				STR R4, [R5]
				
				
END4:			POP {R4-R5,LR}
				BX LR


VGA_draw_point_ASM:
				PUSH {R4,LR}
				CMP R1,#0
				BLT END5
				CMP R1,#239
				BGT END5
				CMP R0,#0
				BLT END5
				LDR R4, =319
				CMP R0, R4
				BGT END5
				
				
				LDR R4, =CHAR_BASE
				LSL R0, R0, #1
				ORR R4, R4, R0
				LSL R1, R1, #10
				ORR R4, R4, R1
				STR R2, [R4]
				
				
			
			
END5:			POP {R4,LR}
				BX LR
				
				

			.end

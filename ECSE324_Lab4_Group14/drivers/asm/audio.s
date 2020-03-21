			.text
			.equ FIFO_SPACE, 0xFF203044
			.global play_audio

play_audio:			
			LDR R1, =FIFO_SPACE  					
			LDRB R2, [R1, #2] 			
			LDRB R3, [R1, #3] 			
			CMP R2, #0
			BEQ END 					
			CMP R3, #0
			BEQ END
			STR R0, [R1, #4] 				
			STR R0, [R1, #8]
			MOV R0, #1
			B END
SKIP:		 	
		    MOV R0, #0	
END:
			BX LR				    	// branches out of subroutine

			.end

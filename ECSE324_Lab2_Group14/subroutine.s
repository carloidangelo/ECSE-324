			.text
			.global MAX_2
MAX_2:
			CMP R0,R1
			BXGE LR    
			MOV R0,R1 //switch only if R1 bigger than R0
			BX LR
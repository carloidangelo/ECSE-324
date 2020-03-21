				.text
				.global _start

_start:
				LDR R0, N  //we only need one parameter, N, whose value is stored in R0
				BL FIBONACCI
				LDR R4, =RESULT
				STR R0, [R4] //store the returned value from the subroutine into S
				

END:			B END //infinite loop!

FIBONACCI:		CMP R0,#0 
				MOVLT R0, #-1
				BXLT LR  //if N samller than zero retun -1
				CMP R2,#2
				MOVLT R0, #1 // if N smllaer than  two return 1
				BXLT LR
				SUB R4, R0 , #1 //R4 takes the value N-1
				SUB R5, R0, #2   // R5 takes the value N-2
				PUSH {R4,R5,LR}  //store the local variables and LR n the stack
				SUB R0,R0, #1
				BL FIBONACCI  // Call F(N-1)
				STR R0, [SP]  //Store F(N-1) into the local variable of R4
				LDR R0, [SP,#4] // R0 takes the value N-2
				BL FIBONACCI   //Call F(N-2)
				POP {R4,R5, LR}  //Pop these values back
				ADD R0, R0,R4   // R0 <- F(n-2)+F(n-1)
				BX LR   // branch back to the caller , returnig R0


N:				.word 7 //number of entries in the list
RESULT:			.word 0


			.text
			.global _start

_start:
			LDR R0, =NUMBERS	// R0 points to the first number in the list
			LDR R1, N  			// R1 holds the number of elements in the list (N)
			SUB R1, R1, #1		// R1 holds N-1, parameter for FINDMAX (counter)
			MOV R4, LR			// move current value of LR into R4
			BL FINDMAX			// special branch instr. that stores address of next instr. in LR
			MOV LR, R4			// restore original value of LR
			STR R0, RESULT 		// store the max to the memory location RESULT

END:		B END				// infinite loop!

FINDMAX:	PUSH {R4, R5}		// current state of processor is saved
			LDR R4, [R0]		// R4 holds the first number in the list
LOOP:		LDR R5, [R0, #4]!	// R5 holds the next number in the list
			CMP R4, R5			// check if it is greater than the maximum
			MOVLT R4, R5		// if R5 > R4, update the current max 
			SUBS R1, R1, #1   	// decrement the loop counter
			BGT LOOP			// branch back to the loop if counter > 0
			MOV R0, R4			// move max into R0 (convention)
			POP {R4, R5}		// state of processor is restored to what it was before the subroutine call
			BX LR				// exit subroutine

RESULT:		.word	0			// memory assigned for result location
N:			.word	7			// number of entries in the list
NUMBERS:	.word	4, 5, 3, 6	// the list data
			.word	1, 8, 2
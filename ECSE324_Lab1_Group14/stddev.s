			.text
			.global _start

_start:
			LDR R6, =RESULT   	// R6 points to the result location
			LDR R2, [R6, #4]  	// R2 holds the number of elements in the list
			ADD R3, R6, #8    	// R3 points to the first number
			LDR R0, [R3]      	// R0 holds the first number in the list

LOOPMAX:	SUBS R2, R2, #1   	// decrement the loop counter
			BEQ DONEMAX			// end loop if counter has reached 0
			ADD R3, R3, #4		// R3 points to next number in list
			LDR R1, [R3]		// R1 holds the next number in the list
			CMP R0, R1			// check if it is greater than the maximum
			BGE LOOPMAX			// if no, branch back to the loop
			MOV R0, R1			// if yes, update the current max
			B LOOPMAX			// branch back to the loop
			
DONEMAX:	MOV R4, R0			// R4 holds the maximum
			LDR R2, [R6, #4]  	// R2 holds the number of elements in the list
			ADD R3, R6, #8		// R3 points to the first number
			LDR R0, [R3] 		// R0 holds the first number in the list
			
LOOPMIN:	SUBS R2, R2, #1   	// decrement the loop counter
			BEQ DONEMIN			// end loop if counter has reached 0
			ADD R3, R3, #4		// R3 points to next number in list
			LDR R1, [R3]		// R1 holds the next number in the list
			CMP R0, R1			// check if it is less than the minimum
			BLE LOOPMIN			// if no, branch back to the loop
			MOV R0, R1			// if yes, update the current min
			B LOOPMIN			// branch back to the loop

DONEMIN:	MOV R5, R0			// R5 holds the minimum

			SUB R0, R4, R5		// R0 holds the difference betewen max and min
			ASR	R1, R0, #2		// R1 holds the difference divided by 4
			STR R1, [R6]		// R6 holds the standard deviation	
			
END:		B END				// infinite loop!

RESULT:		.word	0			// memory assigned for result location
N:			.word	7			// number of entries in the list
NUMBERS:	.word	4, 5, 3, 6	// the list data
			.word	7, 10, 2
	

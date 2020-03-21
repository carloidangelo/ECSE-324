			.text
			.global _start

_start:
			LDR R6, =N   		// R6 points to the N location
			LDR R5, [R6]  		// R5 holds the number of elements in the list
			MOV R1, R6			// R1 points to the N location (for LOOPSUM) 
			MOV R3, #0			// R3 holds the initial sum which is 0
			MOV R0, #0			// R0 holds 0 - will be used as a counter		

LOOPSUM:	CMP R0, R5			// compare count with N
			BGE DONESUM			// if count >= N, exit loop
			LDR R2, [R1, #4]!  	// R2 holds the first number / address in R1 is updated
			ADD R3, R3, R2   	// R3 hold the resulting sum 
			ADD R0, R0, #1		// increment count by 1
			B LOOPSUM			// loop again
			
DONESUM:	MOV R0, #0			// R0 holds 0 - counter is reset
			MOV R1, R6			// R1 points to the N location (for LOOPCA)
			MOV R4, R5			// R4 holds contents of R5(N)

LOOPELM:	CMP R4, #2			// compare value in R4 to 2 
			BLT AVG 			// if value in R5 is less than 2, exit loop
			LSR R4, R4, #1      // will find to what power of 2 N is at
			ADD R0, R0, #1		// increment counter
			B LOOPELM			// go through loop again
					
AVG:		MOV R4, R0			// R4 holds the number of right shifts you need
			ASR R4, R3, R4		// R4 holds the average
			MOV R0, #0			// R0 holds 0 - counter is reset

LOOPCA:		CMP R0, R5			// compare count with N
			BGE END				// if count >= N, exit loop
			LDR R2, [R1, #4]!  	// R2 holds the first number / address in R1 is updated
			SUB R3, R2, R4		// R3 hols the difference between element and avg
			STR R3, [R1]		// store resulting centered signal value 'in place'
			ADD R0, R0, #1		// increment count by 1
			B LOOPCA			// loop again

END:		B END				// infinite loop!

N:			.word	8			// number of entries in the list
NUMBERS:	.word	-5, -2, 0, 3, 5, 4, -9, -32 	 		// the list data

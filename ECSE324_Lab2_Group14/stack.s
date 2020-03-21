			.text
			.global _start

_start:
			LDR R0, PUSHEXP   		// R0 holds the value of PUSHEXP
			STMDB SP!, {R0}			// places the contents of R0 onto the stack (PUSH)
			ADD R0, R0, #1			// adds 1 to value stored in R0
			LDMIA SP!, {R0}			// restores the contents of R0 from the stack (POP)

			LDR R3, =POPEXP   		// R3 points to the first number in POPEXP list
			LDR R0, [R3]			// R0 holds the first number in the list
			LDR R1, [R3, #4]		// R1 holds the second number in the list
			LDR R2, [R3, #8]		// R2 holds the third number in the list
			STMDB SP!, {R0 - R2}	// places the contents of R0 - R2 onto the stack (PUSH)
			ADD R0, R0, #1			// adds 1 to value stored in R0
			ADD R1, R1, #1			// adds 1 to value stored in R1
			ADD R2, R2, #1			// adds 1 to value stored in R2
			LDMIA SP!, {R0 - R2}	// restores the contents of R0 - R2 from the stack (POP)

END:		B END					// infinite loop!

PUSHEXP:	.word	5				// test value
POPEXP:		.word	1, 2, 3			// list data
	

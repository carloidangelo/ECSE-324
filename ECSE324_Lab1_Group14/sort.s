				.text
				.global _start

_start:
				LDR R4, =N //R4 points to the list length
				MOV R5, #0 // set R5 as a boolean soreted..... 1 is sorted 0 is not

LOOP:				CMP R5,#1 
				BEQ END //end LOOP if R5 is 1 (the list is sorted)
				MOV R5, #1
				LDR R2, [R4] //R2 holds the number of elements in the list
				ADD R3, R4, #4 //R3 points oot he first number
				LDR R0, [R3] //R0 holds the first number in the list


LOOPT:				SUBS R2, R2, #1  // an inner loop
				BEQ LOOP // end LOOPT and go bacck to LOOP when we scan the list one time
				ADD R3, R3, #4 //R3 points to the next number in the list
				LDR R1, [R3] //R1 holds the next number in the list
				CMP R0, R1 //check if next number is greater than previous number
				MOVLE R0,R1 // copy the content of R1 to R0 (to be able to compare consecutive number)
				BLE LOOPT 
				MOV R5, #0 //set sorted to false
				STR R0, [R3]
				STR R1, [R3,#-4]
				B LOOPT //branch back to the inner loop



END:				B END //infinite loop!


N:				.word 9 //number of entries in the list
NUMBERS:		.word 100, 122, 99, 80 //the list data
				.word 7, 6, 500, 1, 9

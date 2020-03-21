#include <stdio.h>

#include "./drivers/inc/ps2_keyboard.h"
#include "./drivers/inc/VGA.h"

int main(){

	char holdData[1];
	int x = 0;
	int y = 0;
	VGA_clear_charbuff_ASM();
	while(1){
		while (read_PS2_data_ASM(holdData)){
			VGA_write_byte_ASM(x, y, holdData[0]);
			x = x + 3;
			if (x >= 79){
				x = 0;
				y++;
			}
			if (y >= 59){
				y = 0;
				VGA_clear_charbuff_ASM();
			}
		}
	}			
	return 0;
}
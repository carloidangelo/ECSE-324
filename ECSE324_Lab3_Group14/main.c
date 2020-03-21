#include <stdio.h>

#include "./drivers/inc/LEDs.h"
#include "./drivers/inc/slider_switches.h"
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/pushbuttons.h"

int main(){

	HEX_flood_ASM(HEX4 | HEX5);
	char segmentNumber = 0xF; 
	while(1){
		write_LEDs_ASM(read_slider_switches_ASM());
		if (read_slider_switches_ASM() >= 512){
			HEX_clear_ASM(HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5);
		}else {
			if (PB_edgecap_is_pressed_ASM(PB0) | PB_edgecap_is_pressed_ASM(PB1) | PB_edgecap_is_pressed_ASM(PB2) | PB_edgecap_is_pressed_ASM(PB3)){
				char hexValue = (char)read_slider_switches_ASM() & segmentNumber;
				HEX_write_ASM(read_PB_edgecap_ASM(), hexValue);
				PB_clear_edgecp_ASM(PB0 | PB1 | PB2 | PB3);
			}
		}	
	}

	return 0;
}

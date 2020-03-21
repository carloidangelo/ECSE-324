#include <stdio.h>


#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/HPS_TIM.h"

int main(){

	HEX_clear_ASM(HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5); //clear the displays
	int time=0; // time to be displayed (starts at zero....increments of 10ms)
	int counting=0; // a boolean to advance the stopwatch or not
	
	HPS_TIM_config_t hps_tim0;  //create the first timer settings , counting in increments of 10 ms
	hps_tim0.tim = TIM0;
	hps_tim0.timeout=10000; //counting in increments of 10000 micoseconds (10 ms)
	hps_tim0.LD_en=1;
	hps_tim0.INT_en=1;
	hps_tim0.enable=1;
	
	HPS_TIM_config_t hps_tim1;  //create the second timer settings , counting in increments of 5 ms
	hps_tim1.tim=TIM1;
	hps_tim1.timeout=5000; //counting in increments of 5000 micoseconds (5 ms)
	hps_tim1.LD_en=1;
	hps_tim1.INT_en=1;
	hps_tim1.enable=1;
	
	HPS_TIM_config_ASM(&hps_tim1);
	HPS_TIM_config_ASM(&hps_tim0);
	while(1){
		if(HPS_TIM_read_INT_ASM(TIM1)) //check if 5 ms have passed
		{
			
			if(HPS_TIM_read_INT_ASM(TIM0)) // a multiple of 10 ms have passed
			{
				HPS_TIM_clear_INT_ASM(TIM0 | TIM1); //rset the 5ms and 10 ms timer
				if(counting==1)
				{
					time++; //increment the time if the stopwatch is running
				}
			}
			else // a multiple of 5 (but not 10 ms) have passed)
			{
				HPS_TIM_clear_INT_ASM(TIM1); //ewset the 5mstimer
			}
			
			if(PB_edgecap_is_pressed_ASM(PB0))
			{
				counting=1; //change the boolean value, stopwatch will increment
				PB_clear_edgecp_ASM(PB0);
			}
			if(PB_edgecap_is_pressed_ASM(PB1))
			{
				counting=0; //change the boolean value, stopwatch will stop
				PB_clear_edgecp_ASM(PB1);
			}
			if(PB_edgecap_is_pressed_ASM(PB2))
			{
				time=0; //reset the time to zero
				PB_clear_edgecp_ASM(PB2);
			}
			
			
			HEX_write_ASM(HEX0,time%10); //display hundredths
			HEX_write_ASM(HEX1,(time/10)%10); //display tenths
			HEX_write_ASM(HEX2,(time/100)%10); //display seconds
			HEX_write_ASM(HEX3,(time/1000)%6); //display tens of seconds
			HEX_write_ASM(HEX4,(time/6000)%10); //display minutes
			HEX_write_ASM(HEX5,(time/60000)%10); //display tens of minutes
		}
	}
	

	return 0;
}


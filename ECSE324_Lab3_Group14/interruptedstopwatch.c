#include <stdio.h>

#include "./drivers/inc/int_setup.h"
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/ISRs.h"
#include "./drivers/inc/HPS_TIM.h"


int main(){

	int_setup(2,(int []){73,199}); //enable the interrupt for timer0 and the pushbuttons
	HEX_clear_ASM(HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5); //clear the displays

	int time=0; // time to be displayed (starts at zero....increments of 10ms)
	int counting=0; // a boolean to advance the stopwatch or not
	HPS_TIM_config_t hps_tim0;  //create the first timer settings , counting in increments of 10 ms
	hps_tim0.tim=TIM0;
	hps_tim0.timeout=10000; //counting in increments of 10000 micoseconds (10 ms)
	hps_tim0.LD_en=1;
	hps_tim0.INT_en=1;
	hps_tim0.enable=1;
	
	HPS_TIM_config_ASM(&hps_tim0);
	
	
	while(1){
		
		enable_PB_INT_ASM(PB0 | PB1 | PB2); // enable the interrupts
		if(hps_tim0_int_flag!=0 && counting==1) //check if 10 ms have passed and stopwatch is incrementing
		{
			hps_tim0_int_flag=0;
			time++;
			
		}
			
			
			
			
		if(PB_int_flag==1 || PB_int_flag==3 || PB_int_flag==5 ||PB_int_flag==7)
		{
			PB_int_flag=0;
			counting=1; //change the boolean value, stopwatch will increment
			
			
		}
		
		
		if(PB_int_flag==2 || PB_int_flag==3 || PB_int_flag==6 ||PB_int_flag==7)
		{
			PB_int_flag=0;
			counting=0; //change the boolean value, stopwatch will stop
			
		}
		
		if(PB_int_flag==4 || PB_int_flag==5 || PB_int_flag==6 ||PB_int_flag==7)
		{
			PB_int_flag=0;
			time=0; //reset the time to zero
		}
			
			
			
		
		
		HEX_write_ASM(HEX0,time%10); //display hundredths
		HEX_write_ASM(HEX1,(time/10)%10); //display tenths
		HEX_write_ASM(HEX2,(time/100)%10); //display seconds
		HEX_write_ASM(HEX3,(time/1000)%6); //display tens of seconds
		HEX_write_ASM(HEX4,(time/6000)%10); //display minutes
		HEX_write_ASM(HEX5,(time/60000)%10); //display tens of minutes
	}
	

	return 0;
}
	

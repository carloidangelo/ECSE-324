#include <stdio.h>

#include "./drivers/inc/audio.h"

int main(){
	int high_pitch = 0x00FFFFFF;
	int low_pitch = 0x00000000;		
	int square_value = high_pitch; 
	int i;
	while(1){
		for(i=0 ;i < 240 ;i++){ 
			if(!play_audio(square_value)){
				i--;
			}
		}
		if(square_value == high_pitch){ 
			square_value = low_pitch;
		}		
		else if(square_value == low_pitch){
			square_value = high_pitch;
		}
	}
	return 0;
}

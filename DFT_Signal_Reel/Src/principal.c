

#include "DriverJeuLaser.h"

short int buf[64];
extern int DFT_ModuleAuCarre(short int * Signal64ech, char k);
int tab[64];

void Systick_Callback()
{
	Start_DMA1(64);
	Wait_On_End_Of_DMA1();
	Stop_DMA1;
		
	for(int i=0; i < 64; i++)
	{
		tab[i] = DFT_ModuleAuCarre(buf, i); // LeSignal, k
	}	
}

int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();

// Config Systick
Systick_Period_ff(360000); //Ticks = 5 ms * 72x10^6 = 360 000
Systick_Prio_IT(0, Systick_Callback);
SysTick_On;
SysTick_Enable_IT;
	
// Config archi matérielle
Init_TimingADC_ActiveADC_ff(ADC1, 72);
Single_Channel_ADC(ADC1, 2);
Init_Conversion_On_Trig_Timer_ff(ADC1, TIM2_CC2, 225);
Init_ADC1_DMA1(0, buf);

//============================================================================	
	
while	(1)
	{
	}
}


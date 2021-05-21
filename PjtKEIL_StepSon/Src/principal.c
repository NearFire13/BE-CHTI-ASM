

#include "DriverJeuLaser.h"

extern void CallbackSon(void);

int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Apr�s ex�cution : le coeur CPU est clock� � 72MHz ainsi que tous les timers
CLOCK_Configure();

// configuration du Timer 4 en d�bordement 91 us
Timer_1234_Init_ff(TIM4, 6552); //Ticks = (91*10^-6) * (72x10^6) = 6552

// Activation des interruptions issues du Timer 4
// Association de la fonction � ex�cuter lors de l'interruption : CallbackSon
// cette fonction (si �crite en ASM) doit �tre conforme � l'AAPCS
	
// Activation du D�bordement Timer
Active_IT_Debordement_Timer(TIM4, 2, CallbackSon); // Priorit� 2
	
Run_Timer(TIM4);

PWM_Init_ff(TIM3, 3, 720); // T(PWM) = 720/72.10^6 = 10^-5 donc f = 1/10^(-5) = 100 000 Hz (100 kHz)

// configuration de PortB.0 (PB0) en sortie push-pull
GPIO_Configure(GPIOB, 0, OUTPUT, ALT_PPULL);

//============================================================================	
	
	
while	(1)
{
	
}
}


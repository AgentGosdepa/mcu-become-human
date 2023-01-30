void Reserved_IRQHandler(void)
{
 while(1)
 {

 }
}

void NMI_Handler(void)
{
  while(1)
  {
    /* nothing to be run here */
  }
}

void HardFault_Handler(void)
{
  while(1)
  {
    /* nothing to be run here */
  }
}

void SVC_Handler(void)
{
  while(1)
  {
    /* nothing to be run here */
  }
}

void PendSV_Handler(void)
{
  while(1)
  {
    /* nothing to be run here */
  }
}

void SysTick_Handler(void)
{
  while(1)
  {
    /* nothing to be run here */
  }
}


#include "stm32f103xb.h"
#define PA 0x40010800UL




int main()
{
    RCC->APB2ENR |= RCC_APB2ENR_IOPAEN;

    GPIOA->CRL &= ~GPIO_CRL_CNF5;
    GPIOA->CRL |= GPIO_CRL_MODE5_0;
  //*((unsigned*)PA) = (1<<(4*5));


    while(1){
      for(volatile int i=0; i<200000; i++){}
      GPIOA->ODR ^= GPIO_ODR_ODR5;
    }


    while(1){}

    return 0;
}

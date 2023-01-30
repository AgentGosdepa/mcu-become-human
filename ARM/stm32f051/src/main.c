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


//#include "stm32f051x8.h"
#define PC 0x48000800
#define AHB1 0x40021000 


int main()
{
//PC9
  //GPIOC->MODER |= GPIO_MODER_MODER9_0 | GPIO_MODER_MODER8_0;
 *((unsigned*)(AHB1+0x14)) |= (1<<19);
 *((unsigned*)(PC)) |= (1 << 18) | (1 << 16);
//*((unsigned*)(PC+0x14)) |= (1<<8);
while(1){
//  for(volatile int i=0; i<10000; i++){}
// *((unsigned*)(PC+0x14)) |= (1<<9);
// *((unsigned*)(PC+0x14)) |= (1<<8);
// *((unsigned*)(PC+0x14)) ^= (1<<8);
  for(volatile int i=0; i<200000; i++){}
 *((unsigned*)(PC+0x14)) ^= (1<<9);
// *((unsigned*)(PC+0x14)) ^= (1<<8);
}
while(1){}

return 0;
}

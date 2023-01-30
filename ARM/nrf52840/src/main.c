
int main(void)
{
    *((unsigned*)0x50000734UL) = (1UL<<0UL | 1UL<<1UL | 0UL<<2UL | 0UL<<8UL | 0UL<<16UL); //out p013
    *((unsigned*)0x50000738UL) = (1UL<<0UL | 1UL<<1UL | 0UL<<2UL | 0UL<<8UL | 0UL<<16UL); //out p014
    *((unsigned*)0x5000073CUL) = (1UL<<0UL | 1UL<<1UL | 0UL<<2UL | 0UL<<8UL | 0UL<<16UL); //out p015
    *((unsigned*)0x50000740UL) = (1UL<<0UL | 1UL<<1UL | 0UL<<2UL | 0UL<<8UL | 0UL<<16UL); //out p016
    *((unsigned*)0x50000508UL) = (0x1UL << 13U | 0x1UL << 14U | 0x1UL << 15U | 0x1UL << 16U); //dis led
    
    while(1){
            for(volatile int i=0; i<800000; i++){}
              *((unsigned*)0x50000504UL) ^= (0x1UL << 13U | 0x1UL << 16U);
    }

    while(1){}
    return 0;
}
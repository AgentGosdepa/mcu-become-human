#define PORTA_PIN 5 // PA1, PA3, PA5

int main(void)
{
    *((unsigned*)(0x40020000 + 0x1C)) |= 1 << 21;
    *((unsigned*)(0x400A8000 + 0x4)) |= 1 << PORTA_PIN;
    *((unsigned*)(0x400A8000 + 0x0C)) |= 1 << PORTA_PIN;
    *((unsigned*)(0x400A8000 + 0x18)) |= 1 << 2 * PORTA_PIN;
    *((unsigned*)(0x400A8000 + 0x0)) |= 1 << PORTA_PIN;


    while(1)
{
    *((unsigned*)(0x400A8000 + 0x0)) ^= (1 << PORTA_PIN);
    for(volatile int i=0; i<100000; i++);
}

}
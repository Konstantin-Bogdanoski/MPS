#include <built_in.h>
void main() {
int i = 7;
int memory = 0;
short int count = 0;
ANSEL = 0;
ANSELH = 0;

TRISE.B1 = 1;
TRISA = 0;
while(1){
         if(PORTE.B1){
         count++;
         Delay_ms(15);
         if(i == 7){
              PORTA = 0b01000000;
              i-=2;
              continue;
         }
         else if(i == 5){
              PORTA = 0b00010000;
              i-=2;
              continue;
              }
              else if(i == 3){
                   PORTA = 0b00000100;
                   i-=2;
                   continue;
                   }
                   else if(i == 1){
                        PORTA = 0b00000001;
                        i=7;
                        continue;
                        }
         }
         else{
              if(count == 0) continue;
              EEPROM_Write(0x00 + memory, count);
              memory++;
              count = 0;
         }
}
}
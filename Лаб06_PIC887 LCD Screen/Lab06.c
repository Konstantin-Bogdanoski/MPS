#include <built_in.h>

sbit LCD_RS at RA4_bit;
sbit LCD_EN at RA5_bit;
sbit LCD_D4 at RA0_bit;
sbit LCD_D5 at RA1_bit;
sbit LCD_D6 at RA2_bit;
sbit LCD_D7 at RA3_bit;
sbit LCD_RS_Direction at TRISA4_bit;
sbit LCD_EN_Direction at TRISA5_bit;
sbit LCD_D4_Direction at TRISA0_bit;
sbit LCD_D5_Direction at TRISA1_bit;
sbit LCD_D6_Direction at TRISA2_bit;
sbit LCD_D7_Direction at TRISA3_bit;

const int len = 16;
char ch;
int i;
char text[20], text2[20];
short flag;
unsigned cnt;

void interrupt(){
     if (TMR0IF_bit) {
        cnt++;
        TMR0IF_bit = 0;
        TMR0 = 88;
        }
             else if(INTF_bit){
                  if(flag==1) flag=0;
                  else flag=1;
                  INTF_bit=0;
                  
                  if(OPTION_REG.B6==1)OPTION_REG.B6=0;
                  else OPTION_REG.B6=1;
                  }
     }

void main() {
cnt = 0;
flag = 0;
ANSEL = 0;
ANSELH = 0;
PORTB = 0;    //0 all bits
TRISB.B0 = 1;   // B0 e INPUT
INTCON = 0b10110000; // Ovozmozhi prekini od TM0 i B0
Lcd_Init();

while(1) {
         while(flag){
                       Lcd_Cmd(_LCD_CURSOR_OFF);
                       Lcd_Cmd(_LCD_CLEAR);
                       strcpy(text,"KONSTANTIN");
                       cnt=0;
                       while(cnt>=95){}
                       Lcd_Out(1,1,text);
                       strcpy(text2,"161048");
                       Lcd_Out(2,1,text2);
                      }
         Lcd_Cmd(_LCD_CLEAR);
         }
}
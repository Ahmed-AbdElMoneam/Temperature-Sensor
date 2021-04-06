#line 1 "E:/ «· Â  —„ À«‰Ì/labs/MyProject.c"
#line 5 "E:/ «· Â  —„ À«‰Ì/labs/MyProject.c"
sbit LCD_RS at RC4_bit;
sbit LCD_EN at RC5_bit;
sbit LCD_D7 at RC3_bit;
sbit LCD_D6 at RC2_bit;
sbit LCD_D5 at RC1_bit;
sbit LCD_D4 at RC0_bit;

sbit LCD_RS_Direction at TRISC4_bit;
sbit LCD_EN_Direction at TRISC5_bit;
sbit LCD_D7_Direction at TRISC3_bit;
sbit LCD_D6_Direction at TRISC2_bit;
sbit LCD_D5_Direction at TRISC1_bit;
sbit LCD_D4_Direction at TRISC0_bit;
char txt[7];
int time, counter = 0;
void initialize_timer_interrupt(void){
 TMR0IE_bit = 1;
 GIE_bit = 1;
 T0CS_bit = 0;
 PSA_bit = 0;
 PS0_bit = 0;
 PS1_bit = 0;
 PS2_bit = 1;
 TMR0 = 6;
}
void main(){
 TRISB.B0 = 1;
 TRISB.B1 = 0;
 INTE_bit = 1;
 Lcd_Init();
 LCD_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1, 1, "Elapsed Time: ");
 initialize_timer_interrupt();
 if(PORTB.B0 == 1){
 PORTB.B1 = 1;
 }
 else if(PORTB.B0 == 0){
 PORTB.B1 = 0;
 }
 while(1){
 if(counter == 250 && PORTB.B1 == 1){
 counter = 0;
 time++;
 IntToStrWithZeros(time, txt);
 Lcd_Out(2, 1, txt);
 }
 if(PORTB.B0 == 0){
 PORTB.B1 = 0;
 counter = 0;
 time = 0;
 }
 }
}
void interrupt(void){
 if(INTCON.TMR0IF == 1){
 counter++;
 INTCON.TMR0IF = 0;
 TMR0 = 6;
 }
 if(INTF_bit == 1){
 PORTB.B1 = 1;
 INTF_bit = 0;
 }
}

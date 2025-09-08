#line 1 "C:/Users/Ala Hassine/Desktop/USB/USB.c"
unsigned char readbuff[64] absolute 0x500;
unsigned char writebuff[64] absolute 0x540;
unsigned char i;

sbit LED_1 at RD0_bit;
sbit LED_2 at RD1_bit;
sbit LED_3 at RD2_bit;
sbit LED_4 at RD3_bit;
sbit Bouton_1 at RA1_bit;
sbit Bouton_2 at RA2_bit;
sbit Bouton_3 at RA3_bit;
sbit Bouton_4 at RA4_bit;

sbit LCD_RS at RB0_bit;
sbit LCD_EN at RB1_bit;
sbit LCD_D4 at RB5_bit;
sbit LCD_D5 at RB4_bit;
sbit LCD_D6 at RB3_bit;
sbit LCD_D7 at RB2_bit;
sbit LCD_RS_Direction at TRISB0_bit;
sbit LCD_EN_Direction at TRISB1_bit;
sbit LCD_D4_Direction at TRISB5_bit;
sbit LCD_D5_Direction at TRISB4_bit;
sbit LCD_D6_Direction at TRISB3_bit;
sbit LCD_D7_Direction at TRISB2_bit;

void interrupt()
{
 USB_Interrupt_Proc();
}

void main()
{
 ADCON1 = 0x0E;
 CMCON = 7;
 TRISA = 0xFF;
 TRISD = 0x00;
 PORTD = 0;
 TRISB = 0;
 PORTB = 0;
 HID_Enable(&readbuff, &writebuff);
 Delay_ms(1000);
 Lcd_Init();
 Lcd_Cmd(_LCD_CURSOR_OFF);
 while (1)
 {
 while(HID_Read() == 0);
 if (readbuff[0] == 'A') LED_1 = 1;
 if (readbuff[0] == 'B') LED_1 = 0;
 if (readbuff[0] == 'C') LED_2 = 1;
 if (readbuff[0] == 'D') LED_2 = 0;
 if (readbuff[0] == 'E') LED_3 = 1;
 if (readbuff[0] == 'F') LED_3 = 0;
 if (readbuff[0] == 'G') LED_4 = 1;
 if (readbuff[0] == 'H') LED_4 = 0;
 if (readbuff[0] == 'X')
 {
 for (i = 1; i <= 16; i++)
 {
 Lcd_Chr(1, i, readbuff[i]);
 }
 for (i = 17; i <= 32; i++)
 {
 Lcd_Chr(2, i-16, readbuff[i]);
 }
 }
 if (readbuff[0] == 'Y')
 {
 Lcd_Cmd(_LCD_CLEAR);
 lcd_Cmd(_LCD_FIRST_ROW);
 }
 if (readbuff[0] == 'Z')
 {
 writebuff[0] = (ADC_Read(0) >> 2);
 writebuff[1] = Bouton_1 + 48;
 writebuff[2] = Bouton_2 + 48;
 writebuff[3] = Bouton_3 + 48;
 writebuff[4] = Bouton_4 + 48;
 while(HID_Write(&writebuff, 64) == 0);
 }
 }
}


_interrupt:

;USB.c,27 :: 		void interrupt()
;USB.c,29 :: 		USB_Interrupt_Proc();
	CALL        _USB_Interrupt_Proc+0, 0
;USB.c,30 :: 		}
L_end_interrupt:
L__interrupt25:
	RETFIE      1
; end of _interrupt

_main:

;USB.c,32 :: 		void main()
;USB.c,34 :: 		ADCON1 = 0x0E;
	MOVLW       14
	MOVWF       ADCON1+0 
;USB.c,35 :: 		CMCON  = 7;
	MOVLW       7
	MOVWF       CMCON+0 
;USB.c,36 :: 		TRISA = 0xFF;
	MOVLW       255
	MOVWF       TRISA+0 
;USB.c,37 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;USB.c,38 :: 		PORTD = 0;
	CLRF        PORTD+0 
;USB.c,39 :: 		TRISB = 0;
	CLRF        TRISB+0 
;USB.c,40 :: 		PORTB = 0;
	CLRF        PORTB+0 
;USB.c,41 :: 		HID_Enable(&readbuff, &writebuff);
	MOVLW       _readbuff+0
	MOVWF       FARG_HID_Enable_readbuff+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FARG_HID_Enable_readbuff+1 
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Enable_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Enable_writebuff+1 
	CALL        _HID_Enable+0, 0
;USB.c,42 :: 		Delay_ms(1000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
	NOP
;USB.c,43 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;USB.c,44 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;USB.c,45 :: 		while (1)
L_main1:
;USB.c,47 :: 		while(HID_Read() == 0);
L_main3:
	CALL        _HID_Read+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
	GOTO        L_main3
L_main4:
;USB.c,48 :: 		if (readbuff[0] == 'A') LED_1 = 1;
	MOVF        1280, 0 
	XORLW       65
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
	BSF         RD0_bit+0, BitPos(RD0_bit+0) 
L_main5:
;USB.c,49 :: 		if (readbuff[0] == 'B') LED_1 = 0;
	MOVF        1280, 0 
	XORLW       66
	BTFSS       STATUS+0, 2 
	GOTO        L_main6
	BCF         RD0_bit+0, BitPos(RD0_bit+0) 
L_main6:
;USB.c,50 :: 		if (readbuff[0] == 'C') LED_2 = 1;
	MOVF        1280, 0 
	XORLW       67
	BTFSS       STATUS+0, 2 
	GOTO        L_main7
	BSF         RD1_bit+0, BitPos(RD1_bit+0) 
L_main7:
;USB.c,51 :: 		if (readbuff[0] == 'D') LED_2 = 0;
	MOVF        1280, 0 
	XORLW       68
	BTFSS       STATUS+0, 2 
	GOTO        L_main8
	BCF         RD1_bit+0, BitPos(RD1_bit+0) 
L_main8:
;USB.c,52 :: 		if (readbuff[0] == 'E') LED_3 = 1;
	MOVF        1280, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L_main9
	BSF         RD2_bit+0, BitPos(RD2_bit+0) 
L_main9:
;USB.c,53 :: 		if (readbuff[0] == 'F') LED_3 = 0;
	MOVF        1280, 0 
	XORLW       70
	BTFSS       STATUS+0, 2 
	GOTO        L_main10
	BCF         RD2_bit+0, BitPos(RD2_bit+0) 
L_main10:
;USB.c,54 :: 		if (readbuff[0] == 'G') LED_4 = 1;
	MOVF        1280, 0 
	XORLW       71
	BTFSS       STATUS+0, 2 
	GOTO        L_main11
	BSF         RD3_bit+0, BitPos(RD3_bit+0) 
L_main11:
;USB.c,55 :: 		if (readbuff[0] == 'H') LED_4 = 0;
	MOVF        1280, 0 
	XORLW       72
	BTFSS       STATUS+0, 2 
	GOTO        L_main12
	BCF         RD3_bit+0, BitPos(RD3_bit+0) 
L_main12:
;USB.c,56 :: 		if (readbuff[0] == 'X')
	MOVF        1280, 0 
	XORLW       88
	BTFSS       STATUS+0, 2 
	GOTO        L_main13
;USB.c,58 :: 		for (i = 1; i <= 16; i++)
	MOVLW       1
	MOVWF       _i+0 
L_main14:
	MOVF        _i+0, 0 
	SUBLW       16
	BTFSS       STATUS+0, 0 
	GOTO        L_main15
;USB.c,60 :: 		Lcd_Chr(1, i, readbuff[i]);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        _i+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       _readbuff+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FSR0L+1 
	MOVF        _i+0, 0 
	ADDWF       FSR0L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0L+1, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;USB.c,58 :: 		for (i = 1; i <= 16; i++)
	INCF        _i+0, 1 
;USB.c,61 :: 		}
	GOTO        L_main14
L_main15:
;USB.c,62 :: 		for (i = 17; i <= 32; i++)
	MOVLW       17
	MOVWF       _i+0 
L_main17:
	MOVF        _i+0, 0 
	SUBLW       32
	BTFSS       STATUS+0, 0 
	GOTO        L_main18
;USB.c,64 :: 		Lcd_Chr(2, i-16, readbuff[i]);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       16
	SUBWF       _i+0, 0 
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       _readbuff+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FSR0L+1 
	MOVF        _i+0, 0 
	ADDWF       FSR0L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0L+1, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;USB.c,62 :: 		for (i = 17; i <= 32; i++)
	INCF        _i+0, 1 
;USB.c,65 :: 		}
	GOTO        L_main17
L_main18:
;USB.c,66 :: 		}
L_main13:
;USB.c,67 :: 		if (readbuff[0] == 'Y')
	MOVF        1280, 0 
	XORLW       89
	BTFSS       STATUS+0, 2 
	GOTO        L_main20
;USB.c,69 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;USB.c,70 :: 		lcd_Cmd(_LCD_FIRST_ROW);
	MOVLW       128
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;USB.c,71 :: 		}
L_main20:
;USB.c,72 :: 		if (readbuff[0] == 'Z')
	MOVF        1280, 0 
	XORLW       90
	BTFSS       STATUS+0, 2 
	GOTO        L_main21
;USB.c,74 :: 		writebuff[0] = (ADC_Read(0) >> 2);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	MOVF        R2, 0 
	MOVWF       1344 
;USB.c,75 :: 		writebuff[1] = Bouton_1 + 48;
	MOVLW       0
	BTFSC       RA1_bit+0, BitPos(RA1_bit+0) 
	MOVLW       1
	MOVWF       1345 
	MOVLW       48
	ADDWF       1345, 1 
;USB.c,76 :: 		writebuff[2] = Bouton_2 + 48;
	MOVLW       0
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	MOVLW       1
	MOVWF       1346 
	MOVLW       48
	ADDWF       1346, 1 
;USB.c,77 :: 		writebuff[3] = Bouton_3 + 48;
	MOVLW       0
	BTFSC       RA3_bit+0, BitPos(RA3_bit+0) 
	MOVLW       1
	MOVWF       1347 
	MOVLW       48
	ADDWF       1347, 1 
;USB.c,78 :: 		writebuff[4] = Bouton_4 + 48;
	MOVLW       0
	BTFSC       RA4_bit+0, BitPos(RA4_bit+0) 
	MOVLW       1
	MOVWF       1348 
	MOVLW       48
	ADDWF       1348, 1 
;USB.c,79 :: 		while(HID_Write(&writebuff, 64) == 0);
L_main22:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main23
	GOTO        L_main22
L_main23:
;USB.c,80 :: 		}
L_main21:
;USB.c,81 :: 		}
	GOTO        L_main1
;USB.c,82 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

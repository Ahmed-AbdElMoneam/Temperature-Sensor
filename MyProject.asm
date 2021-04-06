
_initialize_timer_interrupt:

;MyProject.c,20 :: 		void initialize_timer_interrupt(void){
;MyProject.c,21 :: 		TMR0IE_bit = 1;
	BSF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
;MyProject.c,22 :: 		GIE_bit = 1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;MyProject.c,23 :: 		T0CS_bit = 0;
	BCF        T0CS_bit+0, BitPos(T0CS_bit+0)
;MyProject.c,24 :: 		PSA_bit = 0;
	BCF        PSA_bit+0, BitPos(PSA_bit+0)
;MyProject.c,25 :: 		PS0_bit = 0;
	BCF        PS0_bit+0, BitPos(PS0_bit+0)
;MyProject.c,26 :: 		PS1_bit = 0;
	BCF        PS1_bit+0, BitPos(PS1_bit+0)
;MyProject.c,27 :: 		PS2_bit = 1;
	BSF        PS2_bit+0, BitPos(PS2_bit+0)
;MyProject.c,28 :: 		TMR0 = 6;
	MOVLW      6
	MOVWF      TMR0+0
;MyProject.c,29 :: 		}
L_end_initialize_timer_interrupt:
	RETURN
; end of _initialize_timer_interrupt

_main:

;MyProject.c,30 :: 		void main(){
;MyProject.c,31 :: 		TRISB.B0 = 1;
	BSF        TRISB+0, 0
;MyProject.c,32 :: 		TRISB.B1 = 0;
	BCF        TRISB+0, 1
;MyProject.c,33 :: 		INTE_bit = 1;
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;MyProject.c,34 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;MyProject.c,35 :: 		LCD_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,36 :: 		Lcd_Out(1, 1, "Elapsed Time: ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,37 :: 		initialize_timer_interrupt();
	CALL       _initialize_timer_interrupt+0
;MyProject.c,38 :: 		if(PORTB.B0 == 1){
	BTFSS      PORTB+0, 0
	GOTO       L_main0
;MyProject.c,39 :: 		PORTB.B1 = 1;
	BSF        PORTB+0, 1
;MyProject.c,40 :: 		}
	GOTO       L_main1
L_main0:
;MyProject.c,41 :: 		else if(PORTB.B0 == 0){
	BTFSC      PORTB+0, 0
	GOTO       L_main2
;MyProject.c,42 :: 		PORTB.B1 = 0;
	BCF        PORTB+0, 1
;MyProject.c,43 :: 		}
L_main2:
L_main1:
;MyProject.c,44 :: 		while(1){
L_main3:
;MyProject.c,45 :: 		if(counter == 250 && PORTB.B1 == 1){
	MOVLW      0
	XORWF      _counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main14
	MOVLW      250
	XORWF      _counter+0, 0
L__main14:
	BTFSS      STATUS+0, 2
	GOTO       L_main7
	BTFSS      PORTB+0, 1
	GOTO       L_main7
L__main11:
;MyProject.c,46 :: 		counter = 0;
	CLRF       _counter+0
	CLRF       _counter+1
;MyProject.c,47 :: 		time++;
	INCF       _time+0, 1
	BTFSC      STATUS+0, 2
	INCF       _time+1, 1
;MyProject.c,48 :: 		IntToStrWithZeros(time, txt);
	MOVF       _time+0, 0
	MOVWF      FARG_IntToStrWithZeros_input+0
	MOVF       _time+1, 0
	MOVWF      FARG_IntToStrWithZeros_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStrWithZeros_output+0
	CALL       _IntToStrWithZeros+0
;MyProject.c,49 :: 		Lcd_Out(2, 1, txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,50 :: 		}
L_main7:
;MyProject.c,51 :: 		if(PORTB.B0 == 0){
	BTFSC      PORTB+0, 0
	GOTO       L_main8
;MyProject.c,52 :: 		PORTB.B1 = 0;
	BCF        PORTB+0, 1
;MyProject.c,53 :: 		counter = 0;
	CLRF       _counter+0
	CLRF       _counter+1
;MyProject.c,54 :: 		time = 0;
	CLRF       _time+0
	CLRF       _time+1
;MyProject.c,55 :: 		}
L_main8:
;MyProject.c,56 :: 		}
	GOTO       L_main3
;MyProject.c,57 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MyProject.c,58 :: 		void interrupt(void){
;MyProject.c,59 :: 		if(INTCON.TMR0IF == 1){
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt9
;MyProject.c,60 :: 		counter++;
	INCF       _counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter+1, 1
;MyProject.c,61 :: 		INTCON.TMR0IF = 0;
	BCF        INTCON+0, 2
;MyProject.c,62 :: 		TMR0 = 6;
	MOVLW      6
	MOVWF      TMR0+0
;MyProject.c,63 :: 		}
L_interrupt9:
;MyProject.c,64 :: 		if(INTF_bit == 1){
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt10
;MyProject.c,65 :: 		PORTB.B1 = 1;
	BSF        PORTB+0, 1
;MyProject.c,66 :: 		INTF_bit = 0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;MyProject.c,67 :: 		}
L_interrupt10:
;MyProject.c,68 :: 		}
L_end_interrupt:
L__interrupt16:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

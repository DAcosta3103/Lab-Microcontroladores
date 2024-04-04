;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.0 #11528 (Linux)
;--------------------------------------------------------
; PIC port for the 14-bit core
;--------------------------------------------------------
;	.file	"dado.c"
	list	p=12f683
	radix dec
	include "p12f683.inc"
;--------------------------------------------------------
; external declarations
;--------------------------------------------------------
	extern	__moduint
	extern	__mulint
	extern	_ANSEL
	extern	_TRISIO
	extern	_GPIO
	extern	_GPIObits
	extern	__sdcc_gsinit_startup
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	global	_main
	global	_delay
	global	_generarNumeroAleatorio
	global	_seed

	global PSAVE
	global SSAVE
	global WSAVE
	global STK12
	global STK11
	global STK10
	global STK09
	global STK08
	global STK07
	global STK06
	global STK05
	global STK04
	global STK03
	global STK02
	global STK01
	global STK00

sharebank udata_ovr 0x0070
PSAVE	res 1
SSAVE	res 1
WSAVE	res 1
STK12	res 1
STK11	res 1
STK10	res 1
STK09	res 1
STK08	res 1
STK07	res 1
STK06	res 1
STK05	res 1
STK04	res 1
STK03	res 1
STK02	res 1
STK01	res 1
STK00	res 1

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL_dado_0	udata
r0x1003	res	1
r0x1002	res	1
r0x1004	res	1
r0x1005	res	1
r0x1006	res	1
r0x1007	res	1
r0x1008	res	1
r0x1009	res	1
r0x100A	res	1
r0x100B	res	1
;--------------------------------------------------------
; initialized data
;--------------------------------------------------------

IDD_dado_0	idata
_seed
	db	0x00, 0x00	; 0

;--------------------------------------------------------
; initialized absolute data
;--------------------------------------------------------
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
;	udata_ovr
;--------------------------------------------------------
; reset vector 
;--------------------------------------------------------
STARTUP	code 0x0000
	nop
	pagesel __sdcc_gsinit_startup
	goto	__sdcc_gsinit_startup
;--------------------------------------------------------
; code
;--------------------------------------------------------
code_dado	code
;***
;  pBlock Stats: dbName = M
;***
;has an exit
;functions called:
;   _generarNumeroAleatorio
;   _delay
;   _generarNumeroAleatorio
;   _delay
;3 compiler assigned registers:
;   r0x100A
;   r0x100B
;   STK00
;; Starting pCode block
S_dado__main	code
_main:
; 2 exit points
;	.line	37; "dado.c"	ANSEL = 0x00;
	BANKSEL	_ANSEL
	CLRF	_ANSEL
;	.line	38; "dado.c"	TRISIO = 0b00001000;  // Ponemos todos los pines como salida excepto por GP3, el cual corresponde al botón
	MOVLW	0x08
	MOVWF	_TRISIO
;	.line	39; "dado.c"	GPIO = 0x00;          // Todos los pines inician en bajo
	BANKSEL	_GPIO
	CLRF	_GPIO
_00161_DS_:
;	.line	45; "dado.c"	if (BOTON == 1){      // Nos aseguramos de solo operar cuando el boton se presione
	BANKSEL	r0x100A
	CLRF	r0x100A
	BANKSEL	_GPIObits
	BTFSS	_GPIObits,3
	GOTO	_00001_DS_
	BANKSEL	r0x100A
	INCF	r0x100A,F
_00001_DS_:
	BANKSEL	r0x100A
	MOVF	r0x100A,W
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00159_DS_
;	.line	46; "dado.c"	numero = generarNumeroAleatorio();
	PAGESEL	_generarNumeroAleatorio
	CALL	_generarNumeroAleatorio
	PAGESEL	$
	BANKSEL	r0x100B
	MOVWF	r0x100B
	MOVF	STK00,W
;	.line	47; "dado.c"	if (numero == 1){
	MOVWF	r0x100A
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00156_DS_
	MOVF	r0x100B,W
	XORLW	0x00
	BTFSS	STATUS,2
	GOTO	_00156_DS_
;	.line	48; "dado.c"	Salida0 = 1;
	BANKSEL	_GPIObits
	BSF	_GPIObits,0
	GOTO	_00159_DS_
_00156_DS_:
;	.line	49; "dado.c"	} else if (numero == 2){
	BANKSEL	r0x100A
	MOVF	r0x100A,W
	XORLW	0x02
	BTFSS	STATUS,2
	GOTO	_00153_DS_
	MOVF	r0x100B,W
	XORLW	0x00
	BTFSS	STATUS,2
	GOTO	_00153_DS_
;	.line	50; "dado.c"	Salida1 = 1;
	BANKSEL	_GPIObits
	BSF	_GPIObits,1
	GOTO	_00159_DS_
_00153_DS_:
;	.line	51; "dado.c"	} else if (numero == 3){
	BANKSEL	r0x100A
	MOVF	r0x100A,W
	XORLW	0x03
	BTFSS	STATUS,2
	GOTO	_00150_DS_
	MOVF	r0x100B,W
	XORLW	0x00
	BTFSS	STATUS,2
	GOTO	_00150_DS_
;	.line	52; "dado.c"	Salida0 = 1;
	BANKSEL	_GPIObits
	BSF	_GPIObits,0
;	.line	53; "dado.c"	Salida1 = 1;
	BSF	_GPIObits,1
	GOTO	_00159_DS_
_00150_DS_:
;	.line	54; "dado.c"	} else if (numero == 4){
	BANKSEL	r0x100A
	MOVF	r0x100A,W
	XORLW	0x04
	BTFSS	STATUS,2
	GOTO	_00147_DS_
	MOVF	r0x100B,W
	XORLW	0x00
	BTFSS	STATUS,2
	GOTO	_00147_DS_
;	.line	55; "dado.c"	Salida0 = 1;
	BANKSEL	_GPIObits
	BSF	_GPIObits,0
;	.line	56; "dado.c"	Salida1 = 1;
	BSF	_GPIObits,1
;	.line	57; "dado.c"	Salida2 = 1;
	BSF	_GPIObits,2
	GOTO	_00159_DS_
_00147_DS_:
;	.line	58; "dado.c"	} else if (numero == 5){
	BANKSEL	r0x100A
	MOVF	r0x100A,W
	XORLW	0x05
	BTFSS	STATUS,2
	GOTO	_00144_DS_
	MOVF	r0x100B,W
	XORLW	0x00
	BTFSS	STATUS,2
	GOTO	_00144_DS_
;	.line	59; "dado.c"	Salida0 = 1;
	BANKSEL	_GPIObits
	BSF	_GPIObits,0
;	.line	60; "dado.c"	Salida1 = 1;
	BSF	_GPIObits,1
;	.line	61; "dado.c"	Salida2 = 1;
	BSF	_GPIObits,2
;	.line	62; "dado.c"	Salida4 = 1;
	BSF	_GPIObits,4
	GOTO	_00159_DS_
_00144_DS_:
;	.line	63; "dado.c"	} else if (numero == 6){
	BANKSEL	r0x100A
	MOVF	r0x100A,W
	XORLW	0x06
	BTFSS	STATUS,2
	GOTO	_00159_DS_
	MOVF	r0x100B,W
	XORLW	0x00
	BTFSS	STATUS,2
	GOTO	_00159_DS_
;	.line	64; "dado.c"	Salida0 = 1;
	BANKSEL	_GPIObits
	BSF	_GPIObits,0
;	.line	65; "dado.c"	Salida1 = 1;
	BSF	_GPIObits,1
;	.line	66; "dado.c"	Salida2 = 1;
	BSF	_GPIObits,2
;	.line	67; "dado.c"	Salida4 = 1;
	BSF	_GPIObits,4
;	.line	68; "dado.c"	Salida5 = 1;
	BSF	_GPIObits,5
_00159_DS_:
;	.line	71; "dado.c"	delay(tiempo);
	MOVLW	0xd0
	MOVWF	STK00
	MOVLW	0x07
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	72; "dado.c"	Salida0 = 0;
	BANKSEL	_GPIObits
	BCF	_GPIObits,0
;	.line	73; "dado.c"	Salida1 = 0;
	BCF	_GPIObits,1
;	.line	74; "dado.c"	Salida2 = 0;
	BCF	_GPIObits,2
;	.line	75; "dado.c"	Salida4 = 0;
	BCF	_GPIObits,4
;	.line	76; "dado.c"	Salida5 = 0;
	BCF	_GPIObits,5
	GOTO	_00161_DS_
;	.line	79; "dado.c"	}
	RETURN	
; exit point of _main

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;9 compiler assigned registers:
;   r0x1002
;   STK00
;   r0x1003
;   r0x1004
;   r0x1005
;   r0x1006
;   r0x1007
;   r0x1008
;   r0x1009
;; Starting pCode block
S_dado__delay	code
_delay:
; 2 exit points
;	.line	23; "dado.c"	void delay(unsigned int tiempo)
	BANKSEL	r0x1002
	MOVWF	r0x1002
	MOVF	STK00,W
	MOVWF	r0x1003
;	.line	26; "dado.c"	for(i = 0; i < tiempo; i++)
	CLRF	r0x1004
	CLRF	r0x1005
_00115_DS_:
	BANKSEL	r0x1002
	MOVF	r0x1002,W
	SUBWF	r0x1005,W
	BTFSS	STATUS,2
	GOTO	_00136_DS_
	MOVF	r0x1003,W
	SUBWF	r0x1004,W
_00136_DS_:
	BTFSC	STATUS,0
	GOTO	_00117_DS_
;;genSkipc:3307: created from rifx:0x7fff0a8af270
;	.line	28; "dado.c"	for(j = 0; j < 1000; j++)
	MOVLW	0xe8
	BANKSEL	r0x1006
	MOVWF	r0x1006
	MOVLW	0x03
	MOVWF	r0x1007
_00113_DS_:
	MOVLW	0xff
	BANKSEL	r0x1006
	ADDWF	r0x1006,W
	MOVWF	r0x1008
	MOVLW	0xff
	MOVWF	r0x1009
	MOVF	r0x1007,W
	BTFSC	STATUS,0
	INCFSZ	r0x1007,W
	ADDWF	r0x1009,F
	MOVF	r0x1008,W
	MOVWF	r0x1006
	MOVF	r0x1009,W
	MOVWF	r0x1007
	MOVF	r0x1009,W
	IORWF	r0x1008,W
	BTFSS	STATUS,2
	GOTO	_00113_DS_
;	.line	26; "dado.c"	for(i = 0; i < tiempo; i++)
	INCF	r0x1004,F
	BTFSC	STATUS,2
	INCF	r0x1005,F
	GOTO	_00115_DS_
_00117_DS_:
;	.line	32; "dado.c"	}
	RETURN	
; exit point of _delay

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   __mulint
;   __moduint
;   __mulint
;   __moduint
;5 compiler assigned registers:
;   STK02
;   STK01
;   STK00
;   r0x1002
;   r0x1003
;; Starting pCode block
S_dado__generarNumeroAleatorio	code
_generarNumeroAleatorio:
; 2 exit points
;	.line	18; "dado.c"	seed = seed + 1;                    // Incrementamos la semilla
	BANKSEL	_seed
	INCF	_seed,F
	BTFSC	STATUS,2
	INCF	(_seed + 1),F
;	.line	19; "dado.c"	return ((seed * 32719 + 3) % 6) + 1; // Generamos un número entre 1 y 6
	MOVF	_seed,W
	MOVWF	STK02
	MOVF	(_seed + 1),W
	MOVWF	STK01
	MOVLW	0xcf
	MOVWF	STK00
	MOVLW	0x7f
	PAGESEL	__mulint
	CALL	__mulint
	PAGESEL	$
	BANKSEL	r0x1002
	MOVWF	r0x1002
	MOVF	STK00,W
	MOVWF	r0x1003
	MOVLW	0x03
	ADDWF	r0x1003,F
	BTFSC	STATUS,0
	INCF	r0x1002,F
	MOVLW	0x06
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVF	r0x1003,W
	MOVWF	STK00
	MOVF	r0x1002,W
	PAGESEL	__moduint
	CALL	__moduint
	PAGESEL	$
	BANKSEL	r0x1002
	MOVWF	r0x1002
	MOVF	STK00,W
	MOVWF	r0x1003
	INCF	r0x1003,F
	BTFSC	STATUS,2
	INCF	r0x1002,F
	MOVF	r0x1003,W
	MOVWF	STK00
	MOVF	r0x1002,W
;	.line	20; "dado.c"	}
	RETURN	
; exit point of _generarNumeroAleatorio


;	code size estimation:
;	  170+   34 =   204 instructions (  476 byte)

	end

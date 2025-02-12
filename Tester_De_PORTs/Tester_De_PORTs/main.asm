/*
TESTER DE PUERTOS
Creado el 12/02/2025 a las 01:28:02
Autor: Mario Betancourt (23440)
Descripción: El programa implementa un contador de 4 bits con el microcontrolador ATMega328P
usando dos entradas en PORTB y cuatro salidas en PORTD.
*/

// Encabezado
.include "M328PDEF.inc"
.cseg
.org    0x0000

// Configurar la pila
LDI     R16, LOW(RAMEND)
OUT     SPL, R16
LDI     R16, HIGH(RAMEND)
OUT     SPH, R16

SETUP:
	// Activación de pines de salida en el puerto B
	LDI		R16, 0xFF
	OUT		DDRB, R16
	LDI     R16, 0x00
    OUT     PORTB, R16

	// Activación de pines de salida en el puerto B
	LDI		R16, 0xFF
	OUT		DDRC, R16
	LDI     R16, 0x00
    OUT     PORTC, R16

	// Activación de pines de salida en el puerto D
	LDI		R16, 0xFF
	OUT		DDRD, R16
	LDI     R16, 0x00
    OUT     PORTD, R16
	

MAINLOOP:
	CALL	CONTEO

	RJMP	MAINLOOP


CONTEO:
	LDI		R16, 0xFF
	LDI		R17, 0XFF
	LDI		r18, 0xFF
	CALL	SUB_RUTINA_CONTEO1

SUB_RUTINA_CONTEO1:
	DEC		R16
	BRNE	1
	CALL	SUB_RUTINA_CONTEO2
	RJMP	SUB_RUTINA_CONTEO1

SUB_RUTINA_CONTEO2:
	DEC		R17
	BRNE	1
	CALL	SUB_RUTINA_CONTEO3
	RJMP	SUB_RUTINA_CONTEO2

SUB_RUTINA_CONTEO3:
	DEC		R18
	BRNE	1
	RET
	RJMP	SUB_RUTINA_CONTEO3


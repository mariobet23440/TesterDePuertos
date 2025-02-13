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
	/*
	LDI		R16, 0xFF
	OUT		DDRC, R16
	LDI     R16, 0x00
    OUT     PORTC, R16
	*/

	// Activación de pines de salida en el puerto D
	LDI		R16, 0xFF
	OUT		DDRD, R16
	LDI     R16, 0x00
    OUT     PORTD, R16

	// Registros de contadores
	LDI		R20, 0x01
	LDI		R21, 0x01
	LDI		R22, 0x01
	
// Mainloop
MAINLOOP:
	// Incrementar contadores y sacarlos en los puertos
	INC		R20
	OUT		PORTB, R20
	CALL	DELAY_SETUP
	CALL	DELAY_SETUP
	CALL	DELAY_SETUP


	/*
	INC		R21
	OUT		PORTC, R21
	CALL	DELAY_SETUP
	*/

	//INC		R22
	//OUT		PORTD, R22
	//CALL	DELAY_SETUP

	RJMP	MAINLOOP

// Vamos a construir una rutina de conteo
// A esta le llamaré DELAY_255 POW 3 porque puede contar un número de veces igual al cubo de 255
DELAY_255POW3:
	LDI		R18, 1					// El número de la derecha representa el no. de iteraciones
	CALL	DELAY_255POW2

// A esta llamada le nombraré DELAY_255 porque permite hacer ciclos de conteo de 255 un máximo de 255 veces
DELAY_255POW2:
	LDI		R17, 255				// El número de la derecha representa el no. de iteraciones

	CPI		R18, 0
	BREQ	DELAY_END

	DEC		R18
	CALL	DELAY_LOOP

DELAY_LOOP:
	// Reestablecer el valor de R16 a 255
	LDI		R16, 0xFF
	
	// Si R17 es igual a cero, terminar la función
	CPI		R17, 0
	BREQ	DELAY_END

	// Si no, ejecutar un ciclo de conteo
	DEC		R17					// Decrementar el valor de R17
	CALL	CONTEO_R16
	

CONTEO_R16:
	DEC		R16
	BRNE	CONTEO_R16
	RJMP	DELAY_LOOP

DELAY_END:
	RET
	
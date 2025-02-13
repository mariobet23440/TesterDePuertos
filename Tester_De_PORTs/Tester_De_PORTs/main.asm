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
	ROL		R20
	OUT		PORTB, R20
	CALL	DELAY_SETUP

	/*
	INC		R21
	OUT		PORTC, R21
	CALL	DELAY_SETUP
	*/

	INC		R22
	OUT		PORTD, R22
	CALL	DELAY_SETUP

	RJMP	MAINLOOP

// Vamos a construir una rutina de conteo
// Usaremos el registro R16 como contador (En cada subrutina se contará de 255 a 0)
// Y luego incrementaremos el valor de R17 hasta un número deseado
DELAY_SETUP:
	LDI		R17, 2				// El número de la derecha representa el no. de iteraciones
	CALL	DELAY_LOOP

DELAY_LOOP:
	// Reestablecer el valor de R16 a 255
	LDI		R16, 0xFF
	
	// Si R17 no es igual a 0 realizar un ciclo de conteo
	CPI		R17, 0
	
	// Si la bandera Z del SREG está encendida, regresar a MAINLOOP
	SBRS	SREG, 1
	RET

	// Si no, ejecutar un ciclo de conteo
	DEC		R17					// Decrementar el valor de R17
	CALL	CONTEO_R16
	

CONTEO_R16:
	DEC		R16
	BRNE	CONTEO_R16
	RJMP	DELAY_LOOP
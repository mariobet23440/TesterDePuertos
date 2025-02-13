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
    LDI     R16, 0xFF
    OUT     DDRB, R16
    LDI     R16, 0x00
    OUT     PORTB, R16

    // Activación de pines de salida en el puerto D
    LDI     R16, 0xFF
    OUT     DDRD, R16
    LDI     R16, 0x00
    OUT     PORTD, R16

    // Registros de contadores
    LDI     R20, 0x01
    LDI     R22, 0x01

MAINLOOP:
    // Incrementar contadores y sacarlos en los puertos
    ROL     R20
    OUT     PORTB, R20
    CALL    DELAY_SETUP

    INC     R22
    OUT     PORTD, R22
    CALL    DELAY_SETUP

    RJMP    MAINLOOP

DELAY_255_POW3:
    LDI     R18, 255
DELAY_255_POW3_LOOP:
    CALL    DELAY_SETUP
    DEC     R18
    BRNE    DELAY_255_POW3_LOOP
    RET

DELAY_SETUP:
    LDI     R17, 255
DELAY_LOOP:
    LDI     R16, 0xFF
    CPI     R17, 0
    BREQ    DELAY_END
    DEC     R17
CONTEO_R16:
    DEC     R16
    BRNE    CONTEO_R16
    RJMP    DELAY_LOOP

DELAY_END:
    RET

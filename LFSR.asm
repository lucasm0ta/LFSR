; LFSR NOISE SOURCE
; Uses 11 bytes of memory:
; SHIFT_REG3, SHIFT_REG2, SHIFT_REG1, SHIFT_REG0
; NEW_REG0  The replacement SHIFT_REG0 byte
; TEMP_REG3A    Exactly what they say on the tin.
; TEMP_REG3B
; TEMP_REG2A    Temporary copies of REGs 2 &amp;amp;amp;amp; 3
; TEMP_REG2B

NoiseSource:
    ; First I need to copy two bytes I'm going to muck with
    movf    SHIFT_REG3, w
    movwf   TEMP_REG3A  ; I need 2 copies for left/right shifts
    movwf   TEMP_REG3B
    movwf   NEW_REG0    ; Get bit 32 while we've got it
    movf    SHIFT_REG2, w
    movwf   TEMP_REG2A  ; Two copies of this too
    movwf   TEMP_REG2B

    ; Next, I need to XOR all the bytes together
    rlf TEMP_REG2A, f   ; Left shift 1st set of copies
    rlf TEMP_REG3A, f
    rlf TEMP_REG2A, f
    rlf TEMP_REG3A, w
    xorwf   NEW_REG0, f ; XOR with bit 30
    rrf TEMP_REG3B, f   ; Right shift 2nd set of copies
    rrf TEMP_REG2B, f
    movf    TEMP_REG2B, w
    xorwf   NEW_REG0, f ; XOR with bit 25
    rrf TEMP_REG3B, f
    rrf TEMP_REG2B, w
    xorwf   NEW_REG0, f ; XOR with bit 26

    ; Perform a byte shift on the whole 32-bit register
    movf SHIFT_REG2, w  ; Put SR2 into SR3
    movwf SHIFT_REG3
    movf SHIFT_REG1, w  ; Put SR1 into SR2
    movwf SHIFT_REG2
    movf SHIFT_REG0, w  ; Put SR0 into SR1
    movwf SHIFT_REG1
    movf NEW_REG0, w        ; Put NEW_REG0 into SR0
    movwf SHIFT_REG0
    return

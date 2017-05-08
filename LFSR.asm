%include "asm_io.inc"
global lfsr_nasm

section   .text
message db "OLA",0;
lfsr_nasm:
    mov ecx, eax ;ecx será o retorno

    mov ebx, eax
    shr ebx, 2
    xor ecx, ebx

    mov ebx, eax
    shr ebx, 3
    xor ecx, ebx

    mov ebx, eax
    shr ebx, 5
    xor ecx, ebx

    mov ebx, eax
    shr ebx, 8
    xor ecx, ebx

    mov ebx, eax
    shr ebx, 13
    xor ecx, ebx

    mov ebx, eax
    shr ebx, 21
    xor ecx, ebx

    and ecx, 1

    shl ecx, 23

    shr eax, 1

    or eax, ecx

    ;call print_int
    ;call print_nl
    ret

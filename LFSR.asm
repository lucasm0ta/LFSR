; Algoritmo LFSR - Trabalho SB 3
;
; Alunos:
;      Breno Xavier Pinto      130103845
;      Gabriel Naves da Silva  120011867
;      Lucas Mota Ribeiro      120016995
; --------------------------------------

%include "asm_io.inc"   ; Inclui funções do Paul Carter de entrada e saída
global lfsr_nasm        ; Permite ser chamado em função C.

section   .text
lfsr_nasm:
    mov ecx, eax         ;ecx é bit a ser inserido no incio

    mov ebx, eax        ; Shift 2 à esquerda e xor com ecx
    shr ebx, 2
    xor ecx, ebx

    mov ebx, eax        ; Shift 3 à esquerda e xor com ecx
    shr ebx, 3
    xor ecx, ebx

    mov ebx, eax        ; Shift 5 à esquerda e xor com ecx
    shr ebx, 5
    xor ecx, ebx

    mov ebx, eax        ; Shift 8 à esquerda e xor com ecx
    shr ebx, 8
    xor ecx, ebx

    mov ebx, eax        ; Shift 13 à esquerda e xor com ecx
    shr ebx, 13
    xor ecx, ebx

    mov ebx, eax        ; Shift 21 à esquerda e xor com ecx
    shr ebx, 21
    xor ecx, ebx

    and ecx, 1          ; ecx & 1 para definir o bit a ser inserido no inicio

    shl ecx, 23         ; move o bit de ecx para a posição 23

    shr eax, 1          ; Shifta eax 1 posição para a direita

    or eax, ecx         ; Adiciona o bit ecx no início

    ;call print_int
    ;call print_nl
    ret
